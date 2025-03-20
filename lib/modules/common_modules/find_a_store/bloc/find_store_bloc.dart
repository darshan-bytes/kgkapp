import 'package:geolocator/geolocator.dart' as geoloc;
import 'package:kgk/kgk.dart';

part 'find_store_event.dart';

part 'find_store_state.dart';

class FindStoreBloc extends Bloc<FindStoreEvent, FindStoreState> {
  TextEditingController addressSearchController = TextEditingController();

  List<AddressModel> addressList = [];

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  CameraPosition? myCameraPosition;
  Set<Marker> markers = {};
  FocusNode searchFocusNode = FocusNode();
  final LocationService locationManager = LocationService();

  /// This variable is used to check whether the toggle is Precious tab or Semi Precious tab
  bool isInitialToggle = true;

  /// Tab title
  String tabOneTitle = 'Store List';
  String tabTwoTitle = 'Store Map';

  FindStoreBloc() : super(FindStoreInitial()) {
    on<FindStoreInitialEvent>(_findStoreInitialEvent);
    on<FindStoreShowFullAddressEvent>(_findStoreShowFullAddressEvent);
    on<FindRetailStoreEvent>(_getStoreListingEvent);
    on<GetDirectionEvent>(_getDirectionEvent);
    on<SortAddressByLatLongEvent>(_sortAddressByLatLongEvent);
    on<FindStoreChangeTypeEvent>(_findStoreChangeTypeEvent);
  }

  Future<void> _getStoreListingEvent(FindRetailStoreEvent event, Emitter<FindStoreState> emit) async {
    emit(FindReloadState());

    geoloc.Position? position = await locationManager.getCurrentLocation(event.context);

    if (position == null) return;

    List<RetailStoreModel> dataList = await findRetailStore(event.context, position, useCurrentLocation: event.useCurrentLocation);
    addressList = dataList.map((e) {
      double distanceInKm = geoloc.Geolocator.distanceBetween(
              position.latitude, position.longitude, e.latitude.toDouble ?? 0.0, e.longitude.toDouble ?? 0.0) /
          1000;
      _addMarker(e.latitude, e.longitude, e.name);
      return AddressModel(
          storeName: e.name,
          storeDistance: distanceInKm.toStringAsFixed(2),
          storeAddress: "${e.address2 != null && e.address2!.isNotEmpty ? '${e.address2}, ' : ''}${e.address1 ?? ''}",
          isExpanded: false,
          addressDetailsKey: GlobalKey<SmartExpansionTileState>(),
          latitude: e.latitude,
          longitude: e.longitude);
    }).toList();
    if (event.useCurrentLocation) {
      myCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: AppConst.zoomPosition,
      );
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

    geoloc.Position? position = await locationManager.getCurrentLocation(event.context);

    add(FindRetailStoreEvent(context: event.context, useCurrentLocation: true));

    if (position != null) {
      myCameraPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: AppConst.zoomPosition);

      final GoogleMapController controller = await mapController.future;

      await controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition!));
    }
    emit(FindStoreAddressLoadedState());
  }

  //_findStoreChangeTypeEvent
  void _findStoreChangeTypeEvent(FindStoreChangeTypeEvent event, Emitter<FindStoreState> emit) {
    emit(FindReloadState());
    isInitialToggle = event.isInitialToggle;
    emit(FindStoreChangeTypeState());
  }

  Future<List<RetailStoreModel>> findRetailStore(BuildContext context, geoloc.Position position,
      {bool useCurrentLocation = false, bool isShowLoader = true, bool isForceFetch = false}) async {
    List<RetailStoreModel> dataList = [];
    try {
      final Map<String, dynamic> body = {
        ApiKey.filters: {
          ApiKey.dynamicObject: {}
        },
        ApiKey.search: "",
        ApiKey.pagination: {ApiKey.limit: AppConst.pageLimit50, ApiKey.page: AppConst.page1},
        ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueAsc.toUpperCase()}
      };
      Either<ErrorResponse, PaginationData<RetailStoreModel>>? response = await AppRepository(context).getRetailStore(body: body);
      response?.fold((l) {
        dataList = [];
        Utils.showMessage(l.message);
      }, (success) {
        /// Sort data based on my currunt location
        if (useCurrentLocation) {
          success.dataList?.sort((a, b) {
            double distanceA = geoloc.Geolocator.distanceBetween(
                position.latitude, position.longitude, a.latitude.toDouble ?? 0.0, a.longitude.toDouble ?? 0.0);
            double distanceB = geoloc.Geolocator.distanceBetween(
                position.latitude, position.longitude, b.latitude.toDouble ?? 0.0, b.longitude.toDouble ?? 0.0);
            return distanceA.compareTo(distanceB);
          });
        }
        dataList = success.dataList as List<RetailStoreModel>;
      });
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
      await launchUrl(
        Uri.parse(googleUrl),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not open the map.';
    }
  }

  void _sortAddressByLatLongEvent(SortAddressByLatLongEvent event, Emitter<FindStoreState> emit) async {
    emit(FindReloadState());
    List<AddressModel> sortedList = [];
    if (event.isCurrentLocation) {
      event.context.setAppLoading(true);
      addressSearchController.clear();
      geoloc.Position? position = await locationManager.getCurrentLocation(event.context);
      if (position == null) return;
      sortedList = await sortAddressesByLocation(position.latitude, position.longitude, emit);
      event.context.setAppLoading(false);
    } else {
      sortedList = await sortAddressesByLocation(event.latitude, event.longitude, emit);
    }
    addressList = sortedList;
    myCameraPosition = CameraPosition(
      target: LatLng(event.latitude, event.longitude),
      zoom: AppConst.zoomPosition,
    );
    emit(const FindStoreAddressLoadedState());
    final GoogleMapController controller = await mapController.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition!));
  }

  // Function to sort addresses based on distance from given lat/long
  Future<List<AddressModel>> sortAddressesByLocation(double userLat, double userLong, Emitter<FindStoreState> emit) async {
    List<AddressModel> dummyList = addressList.map((e) {
      double distanceInKm =
          geoloc.Geolocator.distanceBetween(userLat, userLong, e.latitude.toDouble ?? 0.0, e.longitude.toDouble ?? 0.0) / 1000;
      _addMarker(e.latitude, e.longitude, e.storeName);
      return AddressModel(
          storeName: e.storeName,
          storeDistance: distanceInKm.toStringAsFixed(2),
          storeAddress: e.storeAddress,
          isExpanded: false,
          addressDetailsKey: GlobalKey<SmartExpansionTileState>(),
          latitude: e.latitude,
          longitude: e.longitude);
    }).toList();

    // Create a copy of the list to avoid modifying the original
    List<AddressModel> sortedList = List.from(dummyList);

    // Simple distance calculation (Euclidean distance)
    sortedList.sort((a, b) {
      // Convert string coordinates to double, use 0.0 if null
      double latA = double.tryParse(a.latitude ?? "0.0") ?? 0.0;
      double longA = double.tryParse(a.longitude ?? "0.0") ?? 0.0;
      double latB = double.tryParse(b.latitude ?? "0.0") ?? 0.0;
      double longB = double.tryParse(b.longitude ?? "0.0") ?? 0.0;

      // Calculate distance from user location to each store
      double distanceA = ((latA - userLat) * (latA - userLat)) + ((longA - userLong) * (longA - userLong));
      double distanceB = ((latB - userLat) * (latB - userLat)) + ((longB - userLong) * (longB - userLong));

      return distanceA.compareTo(distanceB);
    });

    searchFocusNode.unfocus();
    FocusManager.instance.primaryFocus?.unfocus();

    return sortedList;
  }
}
