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
  double? currentLat, currentLong;
  FocusNode searchFocusNode = FocusNode();

  FindStoreBloc() : super(FindStoreInitial()) {
    on<FindStoreInitialEvent>(_findStoreInitialEvent);
    on<FindStoreShowFullAddressEvent>(_findStoreShowFullAddressEvent);
    on<FindRetailStoreEvent>(_getStoreListingEvent);
    on<GetDirectionEvent>(_getDirectionEvent);
  }

  Future<void> _getStoreListingEvent(FindRetailStoreEvent event, Emitter<FindStoreState> emit) async {
    emit(FindReloadState());

    List<RetailStoreModel> dataList = await findRetailStore(event.context, useCurrentLocation: event.useCurrentLocation);
    addressList = dataList.map((e) {
      double distanceInKm = geoloc.Geolocator.distanceBetween(
              currentLat ?? 0.0, currentLong ?? 0.0, e.latitude.toDouble ?? 0.0, e.longitude.toDouble ?? 0.0) /
          1000;

      _addMarker(e.latitude, e.longitude, e.name);
      return AddressModel(
          storeName: e.name,
          storeDistance: distanceInKm.toStringAsFixed(2),
          storeAddress: "${e.address2 ?? ''}, ${e.address1 ?? ''}",
          isExpanded: false,
          addressDetailsKey: GlobalKey<SmartExpansionTileState>(),
          latitude: e.latitude,
          longitude: e.longitude);
    }).toList();
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
    await getLocation(event.context);
    emit(FindStoreAddressLoadedState());
  }

  Future<void> getLocation(BuildContext mainContext) async {
    geoloc.LocationPermission permission;

    // Request permission initially
    permission = await geoloc.Geolocator.requestPermission();

    mainContext.setAppLoading(true); // Start loading

    try {
      // Handle "Denied" scenario
      if (permission == geoloc.LocationPermission.denied || permission == geoloc.LocationPermission.deniedForever) {
        permission = await geoloc.Geolocator.requestPermission();
        if (permission == geoloc.LocationPermission.denied || permission == geoloc.LocationPermission.deniedForever) {
          mainContext.setAppLoading(false); // Stop loading
          await Utils.showPermissionDeniedDialog(
              context: mainContext,
              onOkPressed: (context) async {
                if (permission == geoloc.LocationPermission.deniedForever || permission == geoloc.LocationPermission.denied) {
                  await geoloc.Geolocator.openAppSettings();
                  Navigator.pop(context);
                }
                await getLocation(mainContext);
              });
          return; // Exit early
        }
      }

      geoloc.Position position = await geoloc.Geolocator.getCurrentPosition(
        locationSettings: geoloc.LocationSettings(accuracy: geoloc.LocationAccuracy.high),
      );

      currentLat = position.latitude;
      currentLong = position.longitude;

      LatLng location = LatLng(currentLat!, currentLong!);
      myCameraPosition = CameraPosition(
        target: location,
        zoom: 14.4746,
      );

      _addMarker(currentLat.toString(), currentLong.toString(), '');

      mainContext.setAppLoading(false);
      final GoogleMapController controller = await mapController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(myCameraPosition!));
    } catch (e) {
      debugPrint('Error fetching location: $e');
    }
  }

  Future<List<RetailStoreModel>> findRetailStore(BuildContext context,
      {bool useCurrentLocation = false, bool isShowLoader = true, bool isForceFetch = false}) async {
    List<RetailStoreModel> dataList = [];
    try {
      final Map<String, dynamic> body = {
        ApiKey.filters: {
          ApiKey.dynamicObject: {
            ApiKey.zipCode: useCurrentLocation ? LatLng(currentLat ?? 0.0, currentLong ?? 0.0) : addressSearchController.text
          }
        },
        ApiKey.search: "",
        ApiKey.pagination: {ApiKey.limit: AppConst.pageLimit, ApiKey.page: AppConst.page1},
        ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueAsc.toUpperCase()}
      };
      Either<ErrorResponse, PaginationData<RetailStoreModel>>? response = await AppRepository(context).getRetailStore(body: body);
      response?.fold((l) {
        dataList = [];
        Utils.showMessage(l.message);
      }, (success) {
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
}
