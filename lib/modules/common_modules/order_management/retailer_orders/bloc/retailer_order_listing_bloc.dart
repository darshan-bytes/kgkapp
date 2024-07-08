import 'package:kgk/kgk.dart';

part 'retailer_order_listing_event.dart';

part 'retailer_order_listing_state.dart';

class RetailerOrderListingBloc extends Bloc<RetailerOrderListingEvent, RetailerOrderListingState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  // controllers
  late TabController tabController;
  final TextEditingController diamondSearchController = TextEditingController();
  final TextEditingController gemstoneSearchController = TextEditingController();
  final TextEditingController jewellerySearchController = TextEditingController();

  RetailerOrderModel? selectedStoneType;

  // Pagination Scroll controller
  SmartPaginationScrollController retailerDiamondScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController retailerGemstoneScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController retailerJewelleryScrollController = SmartPaginationScrollController();

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.diamond.tr),
    Tab(text: APPStrings.gemstone.tr),
    Tab(text: APPStrings.jewellery.tr),
  ];

  // Orders lists
  List<B2BCustomListingDataModel> retailerDiamondOrdersList = _generateDiamondOrdersList();
  List<B2BCustomListingDataModel> retailerGemstoneOrdersList = _generateGemstoneOrdersList();
  List<B2BCustomListingDataModel> retailerJewelleryOrdersList = _generateJewelleryOrdersList();

  // Stone types
  final List<RetailerOrderModel> arrStoneType = [
    const RetailerOrderModel(name: "Regular"),
    const RetailerOrderModel(name: "Special"),
    const RetailerOrderModel(name: "Diamond"),
    const RetailerOrderModel(name: "Gemstone"),
    const RetailerOrderModel(name: "Jewellery"),
  ];

  RetailerOrderListingBloc() : super(RetailerOrderListingInitialState()) {
    on<InitialRetailerOrderListingEvent>(_onInitRetailerOrdersListingEvent);
    on<RetailerChangeOrdersTypeEvent>(_onChangeOrderType);
    on<RetailerChangeOrderTabsEvent>(_onChangeTabEvent);
  }

  void _onInitRetailerOrdersListingEvent(InitialRetailerOrderListingEvent event, Emitter<RetailerOrderListingState> emit) {
    emit(const RetailerOrderListReloadState());
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    clearData();
    emit(const RetailerOrderListingLoadedState());
  }

  void _onChangeOrderType(RetailerChangeOrdersTypeEvent event, Emitter<RetailerOrderListingState> emit) {
    emit(const RetailerOrderListReloadState());
    selectedStoneType = event.selectedOrderType;
    if (selectedStoneType != null) {
      emit(RetailerChangeOrdersTypeState(selectedStoneType!));
    }
  }

  void _onChangeTabEvent(RetailerChangeOrderTabsEvent event, Emitter<RetailerOrderListingState> emit) {
    emit(const RetailerOrderListReloadState());
    switch (tabController.index) {
      case 0:
        gemstoneSearchController.clear();
        jewellerySearchController.clear();
        break;
      case 1:
        jewellerySearchController.clear();
        diamondSearchController.clear();
        break;
      case 2:
        diamondSearchController.clear();
        gemstoneSearchController.clear();
        break;
    }
    emit(const RetailerChangeOrderTabsState());
  }

  void clearData() {
    diamondSearchController.clear();
    gemstoneSearchController.clear();
    jewellerySearchController.clear();
    tabController.animateTo(0);
    selectedStoneType = null;
  }

  // Helper methods
  static List<B2BCustomListingDataModel> _generateDiamondOrdersList() {
    return List.generate(
      8,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strOrderId: "#34573${index + 2}",
        status: ProjectStatus.active,
        strOrderedBy: "Michael Lee",
        strOrderedByImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strMobileNumber: "+1 406 555 0120",
        strItems: "15",
        strTotalAmount: "\$12,500",
        strOrderOn: "17/03/23 06:00 PM",
      ),
    );
  }

  static List<B2BCustomListingDataModel> _generateGemstoneOrdersList() {
    return List.generate(
      8,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strOrderId: "#34573${index + 2}",
        status: ProjectStatus.active,
        strOrderedBy: "Michael Lee",
        strOrderedByImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strMobileNumber: "+1 406 555 0120",
        strItems: "15",
        strTotalAmount: "\$12,500",
        strOrderOn: "17/03/23 06:00 PM",
      ),
    );
  }

  static List<B2BCustomListingDataModel> _generateJewelleryOrdersList() {
    return List.generate(
      8,
      (index) => B2BCustomListingDataModel(
        id: index.toString(),
        strOrderId: "#34573${index + 2}",
        orderStatus: ProjectStatus.onTime,
        strCustomerNameImageUrl: 'https://i.ibb.co/hy6pH4g/Frame-3977.png',
        strCustomerName: 'Dianne Russell',
        strMobileNumber: "+1 406 555 0120",
        strItems: "5",
        strQuality: "40",
        strOrderOn: "17/03/23 06:00 PM",
        salesOrderStatus: ProjectStatus.created,
      ),
    );
  }
}
