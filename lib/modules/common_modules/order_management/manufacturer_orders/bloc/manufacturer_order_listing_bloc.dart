import 'package:kgk/kgk.dart';

part 'manufacturer_order_listing_event.dart';

part 'manufacturer_order_listing_state.dart';

class ManufacturerOrderListingBloc extends Bloc<ManufacturerOrderListingEvent, ManufacturerOrderListingState> {
  //Controller for search
  final TextEditingController manufacturerOrderSearchController = TextEditingController();

  //List of orders
  List<B2BCustomListingDataModel> manufacturerOrderList = _generateManufacturerOrderList();

  //Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  ManufacturerOrderModel? selectedOrderType;

  // Stone types
  final List<ManufacturerOrderModel> orderTypeList = [
    const ManufacturerOrderModel(name: "Regular"),
    const ManufacturerOrderModel(name: "Special"),
    const ManufacturerOrderModel(name: "Diamond"),
    const ManufacturerOrderModel(name: "Gemstone"),
    const ManufacturerOrderModel(name: "Jewellery"),
  ];

  ManufacturerOrderListingBloc() : super(ManufacturerOrderListingInitial()) {
    on<InitialManufacturerOrderListingEvent>(_onInitialManufacturerOrderListEvent);
    on<ManufacturerOrderListLoadMoreEvent>(_onManufacturerOrderListLoadMoreEvent);
    on<ManufacturerChangeOrdersTypeEvent>(_onManufacturerChangeOrdersTypeEvent);
  }

  void _onInitialManufacturerOrderListEvent(InitialManufacturerOrderListingEvent event, Emitter<ManufacturerOrderListingState> emit) {
    emit(ManufacturerOrderListReloadState());

    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }

    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ManufacturerOrderListLoadMoreEvent(currentPage));
      },
    );
    clearData();
    selectedOrderType = orderTypeList.first;
    emit(ManufacturerOrderListingLoadedState());
  }

  Future<void> _onManufacturerOrderListLoadMoreEvent(
      ManufacturerOrderListLoadMoreEvent event, Emitter<ManufacturerOrderListingState> emit) async {
    emit(const ManufacturerOrderListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    manufacturerOrderList.addAll(_generateManufacturerOrderList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 5);
    emit(ManufacturerOrderListLoadedMoreState(event.currentPage + 1));
  }

  void _onManufacturerChangeOrdersTypeEvent(ManufacturerChangeOrdersTypeEvent event, Emitter<ManufacturerOrderListingState> emit) {
    emit(ManufacturerOrderListReloadState());
    selectedOrderType = event.selectedOrderType;
    if (selectedOrderType != null) {
      emit(ManufacturerChangeOrdersTypeState(selectedOrderType!));
    }
  }

  void clearData() {
    manufacturerOrderSearchController.clear();
    manufacturerOrderList = _generateManufacturerOrderList();
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  static List<B2BCustomListingDataModel> _generateManufacturerOrderList() {
    return List.generate(15, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strOrderId: '#345734',
        status: ProjectStatus.onTime,
        strCustomerName: 'Entice',
        strCustomerNameImageUrl: 'https://i.ibb.co/BCrvsbv/image-466.png',
        strMobileNumber: '+1 406 555 0120',
        strItems: '5',
        strQuality: '40',
        strOrderOn: '17/03/23 06:00 PM',
        purchaseOrderStatus: ProjectStatus.created,
      );
    });
  }
}
