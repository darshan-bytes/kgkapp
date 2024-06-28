import 'package:kgk/kgk.dart';

part 'find_store_event.dart';

part 'find_store_state.dart';

class FindStoreBloc extends Bloc<FindStoreEvent, FindStoreState> {
  TextEditingController addressSearchController = TextEditingController();

  List<AddressModel> addressList = [];

  final Completer<GoogleMapController> mapController = Completer<GoogleMapController>();

  CameraPosition myCameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  FindStoreBloc() : super(FindStoreInitial()) {
    on<FindStoreEvent>((event, emit) {});
    on<FindStoreInitialEvent>(_findStoreInitialEvent);
    on<FindStoreShowFullAddressEvent>(_findStoreShowFullAddressEvent);
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
        }
      }
    }

    emit(FindStoreShowFullAddressState(event.index, oldIndex, event.isExpanded));
  }

  void _findStoreInitialEvent(FindStoreInitialEvent event, Emitter<FindStoreState> emit) {
    emit(FindReloadState());
    addressList = List.generate(
        3,
        (index) => AddressModel(
            storeName: 'KGK Diamonds Pvt. Ltd.',
            storeDistance: '1.5 km',
            storeAddress: 'Bank of India Aditya, G Block Bkc, Bandra Kurla Complex, Bandra East, Mumbai, Maharashtra 400051',
            isExpanded: false,
            addressDetailsKey: GlobalKey<SmartExpansionTileState>()));
    emit(FindStoreAddressLoadedState());
  }
}
