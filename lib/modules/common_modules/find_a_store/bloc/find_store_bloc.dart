import 'package:geolocator/geolocator.dart' as geoloc;
import 'package:kgk/kgk.dart';

part 'find_store_event.dart';

part 'find_store_state.dart';

class FindStoreBloc extends Bloc<FindStoreEvent, FindStoreState> {
  TextEditingController addressSearchController = TextEditingController();

  List<AddressModel> addressList = [];

  /// Controller for managing pagination
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  CameraPosition? myCameraPosition;
  Set<Marker> markers = {};
  FocusNode searchFocusNode = FocusNode();
  final LocationService locationManager = LocationService();

  /// This variable is used to check whether the toggle is Precious tab or Semi Precious tab
  bool isInitialToggle = true;

  /// Tab title
  String tabOneTitle = APPStrings.listView.tr;
  String tabTwoTitle = APPStrings.mapView.tr;

  double userLat = 0.0;
  double userLong = 0.0;

  ValueKey mapKey = const ValueKey('mapKey');

  FindStoreBloc() : super(FindStoreInitial()) {
    on<FindStoreInitialEvent>(_findStoreInitialEvent);
    on<FindStoreShowFullAddressEvent>(_findStoreShowFullAddressEvent);
    on<FindRetailStoreEvent>(_getStoreListingEvent);
    on<GetDirectionEvent>(_getDirectionEvent);
    on<SortAddressByLatLongEvent>(_sortAddressByLatLongEvent);
    on<FindStoreChangeTypeEvent>(_findStoreChangeTypeEvent);
    on<FindStoreLoadMoreEvent>(_findStoreLoadMoreEvent);
  }

  Future<void> _getStoreListingEvent(FindRetailStoreEvent event, Emitter<FindStoreState> emit) async {
    emit(FindReloadState());

    geoloc.Position? position = await locationManager.getCurrentLocation(event.context);

    if (position == null) return;

    List<RetailStoreModel> dataList = await findRetailStore(
      event.context,
      position.latitude,
      position.longitude,
      useCurrentLocation: event.useCurrentLocation,
    );
    addressList.addAll(
      dataList.map((e) {
        _addMarker(e.latitude, e.longitude, e.name);
        return AddressModel(
          storeName: e.name,
          storeDistance: e.distance?.toStringAsFixed(2),
          storeAddress: "${e.address2 != null && e.address2!.isNotEmpty ? '${e.address2}, ' : ''}${e.address1 ?? ''}",
          isExpanded: false,
          addressDetailsKey: GlobalKey<SmartExpansionTileState>(),
          latitude: e.latitude,
          longitude: e.longitude,
        );
      }).toList(),
    );
    if (event.useCurrentLocation) {
      myCameraPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: AppConst.zoomPosition);
      final GoogleMapController controller = await mapController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition!));
    }
    searchFocusNode.unfocus();
    emit(FindStoreAddressLoadedState());
  }

  void _findStoreShowFullAddressEvent(FindStoreShowFullAddressEvent event, Emitter<FindStoreState> emit) {
    emit(FindReloadState());

    int oldIndex = -1;
    addressList[event.index].isExpanded = event.isExpanded;

    if (event.isExpanded) {
      for (int i = 0; i < addressList.length; i++) {
        if (i != event.index && addressList[i].isExpanded) {
          oldIndex = i;
          addressList[i].addressDetailsKey.currentState?.collapse();
          break;
        }
      }
    }

    emit(FindStoreShowFullAddressState(event.index, oldIndex, event.isExpanded));
  }

  Future<void> _findStoreInitialEvent(FindStoreInitialEvent event, Emitter<FindStoreState> emit) async {
    emit(FindReloadState());
    event.context.setAppLoading(true);

    _initializePagination(event.context, emit);

    geoloc.Position? position = await locationManager.getCurrentLocation(event.context);

    userLat = position?.latitude ?? 0.0;
    userLong = position?.longitude ?? 0.0;

    add(FindRetailStoreEvent(context: event.context, useCurrentLocation: true));

    if (position != null) {
      myCameraPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: AppConst.zoomPosition);

      final GoogleMapController controller = await mapController.future;

      await controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition!));
    }
    emit(FindStoreAddressLoadedState());
  }

  /// Initializes pagination behavior
  void _initializePagination(BuildContext context, Emitter<FindStoreState> emit) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(FindStoreLoadMoreEvent(currentPage, context));
      },
    );
    emit(FindStorePaginationInitializedState());
  }

  void _findStoreChangeTypeEvent(FindStoreChangeTypeEvent event, Emitter<FindStoreState> emit) {
    emit(FindReloadState());
    isInitialToggle = event.isInitialToggle;
    emit(FindStoreChangeTypeState());
  }

  Future<List<RetailStoreModel>> findRetailStore(
    BuildContext context,
    double latitude,
    double longitude, {
    bool useCurrentLocation = false,
    bool isShowLoader = true,
    bool isForceFetch = false,
  }) async {
    List<RetailStoreModel> dataList = [];
    try {
      final Map<String, dynamic> body = {
        ApiKey.filters: {
          ApiKey.dynamicObject: {
            ApiKey.latLong: [latitude, longitude],
          },
        },
        ApiKey.search: "",
        ApiKey.pagination: {ApiKey.limit: AppConst.pageLimit50, ApiKey.page: paginationScrollController.currentPage.toString()},
        ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueAsc.toUpperCase()},
      };
      Either<ErrorResponse, PaginationData<RetailStoreModel>>? response = await AppRepository(context).getRetailStore(body: body);
      response?.fold(
        (l) {
          dataList = [];
          Utils.showMessage(l.message);
        },
        (success) {
          dataList = success.dataList as List<RetailStoreModel>;
          totalNumberOfPages = Utils.calculateTotalPages(success.totalRecords, AppConst.pageLimit50);
          paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
        },
      );
    } catch (e) {
      printWrapped(e.toString());
    }
    return dataList;
  }

  void _addMarker(String? lat, String? long, String? title) {
    Marker marker = Marker(
      markerId: MarkerId(title ?? ''),
      infoWindow: InfoWindow(title: title),
      position: LatLng(lat.toDouble ?? 0.0, long.toDouble ?? 0.0),
    );
    markers.add(marker);
  }

  void _getDirectionEvent(GetDirectionEvent event, Emitter<FindStoreState> emit) async {
    String googleUrl = Utils.getGoogleMapUrl(latitude: event.latitude, longitude: event.longitude);
    if (await canLaunchUrl(Uri.parse(googleUrl))) {
      await launchUrl(Uri.parse(googleUrl), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open the map.';
    }
  }

  void _sortAddressByLatLongEvent(SortAddressByLatLongEvent event, Emitter<FindStoreState> emit) async {
    emit(FindReloadState());
    userLat = event.latitude;
    userLong = event.longitude;
    paginationScrollController.currentPage = 1;
    addressList.clear();

    double latitude, longitude;

    if (event.isCurrentLocation) {
      event.context.setAppLoading(true);
      addressSearchController.clear();

      final position = await locationManager.getCurrentLocation(event.context);
      if (position == null) {
        event.context.setAppLoading(false);
        return;
      }

      latitude = position.latitude;
      longitude = position.longitude;
    } else {
      latitude = event.latitude;
      longitude = event.longitude;
    }

    // Fetch store data and populate address list
    await _populateAddressList(event.context, latitude, longitude);

    // Update camera position
    myCameraPosition = CameraPosition(target: LatLng(latitude, longitude), zoom: AppConst.zoomPosition);

    if (event.isCurrentLocation) {
      event.context.setAppLoading(false);
    }

    emit(const FindStoreAddressLoadedState());

    // Animate camera to new position
    final controller = await mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition!));
  }

  // Extract common functionality into a separate method
  Future<void> _populateAddressList(BuildContext context, double latitude, double longitude) async {
    final dataList = await findRetailStore(context, latitude, longitude);

    for (final store in dataList) {
      _addMarker(store.latitude, store.longitude, store.name);

      addressList.add(
        AddressModel(
          storeName: store.name,
          storeDistance: store.distance?.toStringAsFixed(2),
          storeAddress: _formatAddress(store.address1, store.address2),
          isExpanded: false,
          addressDetailsKey: GlobalKey<SmartExpansionTileState>(),
          latitude: store.latitude,
          longitude: store.longitude,
        ),
      );
    }
  }

  // Helper method to format address
  String _formatAddress(String? address1, String? address2) {
    final hasAddress2 = address2 != null && address2.isNotEmpty;
    return hasAddress2 ? '$address2, ${address1 ?? ''}' : address1 ?? '';
  }

  //_findStoreLoadMoreEvent
  void _findStoreLoadMoreEvent(FindStoreLoadMoreEvent event, Emitter<FindStoreState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  /// Load more products
  Future<void> _handleLoadMore(BuildContext context, Emitter<FindStoreState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(FindStoreLoadingMoreState());
      await findRetailStore(context, userLat, userLong);
      emit(FindStoreLoadedMoreState(currentPage));
    }
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }
}
