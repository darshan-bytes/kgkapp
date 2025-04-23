import 'package:kgk/kgk.dart';

part 'retailer_order_listing_event.dart';

part 'retailer_order_listing_state.dart';

enum RetailerOrdersTab { diamond, gemstone, jewellery }

class RetailerOrderListingBloc extends Bloc<RetailerOrderListingEvent, RetailerOrderListingState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  // controllers
  late TabController tabController;
  final TextEditingController diamondSearchController = TextEditingController();
  final TextEditingController gemstoneSearchController = TextEditingController();
  final TextEditingController jewellerySearchController = TextEditingController();

  OrderStoneTypeModel? selectedStoneType;

  SmartPaginationScrollController diamondScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController gemstoneScrollController = SmartPaginationScrollController();
  SmartPaginationScrollController jewelleryScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.diamond.tr),
    Tab(text: APPStrings.gemstone.tr),
    Tab(text: APPStrings.jewellery.tr),
  ];

  // Orders lists
  List<B2BCustomListingDataModel> diamondList = [];
  List<B2BCustomListingDataModel> gemstoneList = [];
  List<B2BCustomListingDataModel> jewelleryList = [];

  // Stone types
  final List<OrderStoneTypeModel> arrStoneType = [
    const OrderStoneTypeModel(name: "Regular"),
    const OrderStoneTypeModel(name: "Special"),
    const OrderStoneTypeModel(name: "Diamond"),
    const OrderStoneTypeModel(name: "Gemstone"),
    const OrderStoneTypeModel(name: "Jewellery"),
  ];

  RetailerOrderListingBloc() : super(const RetailerOrderListingInitialState()) {
    on<RetailerOrderListingInitialEvent>(_onInitOrdersEvent);
    on<ChangeRetailerOrderStoneTypeEvent>(_onChangeStoneType);
    on<RetailerOrderListingLoadMoreEvent>(_onListingLoadMoreEvent);
    on<ChangeRetailerOrderTabsEvent>(_onChangeTabEvent);
    on<RetailerOrderListPullToRefreshEvent>(_onListPullToRefreshEvent);
  }

  void _onInitOrdersEvent(RetailerOrderListingInitialEvent event, Emitter<RetailerOrderListingState> emit) {
    emit(const RetailerOrderListingReloadState());
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    clearData();
    diamondList = _generateDiamondOrdersList();
    gemstoneList = _generateDiamondOrdersList();
    jewelleryList = _generateJewelleryOrdersList();

    if (diamondScrollController.isInitialised) {
      diamondScrollController.dispose();
      diamondScrollController = SmartPaginationScrollController();
    }
    diamondScrollController.init(
      loadAction: (int currentPage) async {
        add(RetailerOrderListingLoadMoreEvent(currentPage: currentPage, listType: RetailerOrdersTab.diamond));
      },
    );

    if (gemstoneScrollController.isInitialised) {
      gemstoneScrollController.dispose();
      gemstoneScrollController = SmartPaginationScrollController();
    }

    gemstoneScrollController.init(
      loadAction: (int currentPage) async {
        add(RetailerOrderListingLoadMoreEvent(currentPage: currentPage, listType: RetailerOrdersTab.gemstone));
      },
    );

    if (jewelleryScrollController.isInitialised) {
      jewelleryScrollController.dispose();
      jewelleryScrollController = SmartPaginationScrollController();
    }
    jewelleryScrollController.init(
      loadAction: (int currentPage) async {
        add(RetailerOrderListingLoadMoreEvent(currentPage: currentPage, listType: RetailerOrdersTab.jewellery));
      },
    );

    refreshCompleter.complete(true);
    emit(const RetailerOrderListingListLoadedState());
  }

  void _onChangeStoneType(ChangeRetailerOrderStoneTypeEvent event, Emitter<RetailerOrderListingState> emit) {
    emit(const RetailerOrderListingReloadState());
    selectedStoneType = event.selectedStoneType;
    if (selectedStoneType != null) {
      emit(ChangeRetailerOrderStoneTypeState(selectedStoneType!));
    }
  }

  void _onChangeTabEvent(ChangeRetailerOrderTabsEvent event, Emitter<RetailerOrderListingState> emit) {
    emit(const RetailerOrderListingReloadState());
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
    emit(const ChangeRetailerOrderTabsState());
  }

  Future<void> _onListingLoadMoreEvent(RetailerOrderListingLoadMoreEvent event, Emitter<RetailerOrderListingState> emit) async {
    emit(RetailerOrderListingLoadingMoreState(event.listType));
    await Future.delayed(const Duration(seconds: 2));

    List<B2BCustomListingDataModel> newDataList = [];

    switch (event.listType) {
      case RetailerOrdersTab.diamond:
        newDataList = _generateDiamondOrdersList();
        diamondList.addAll(newDataList);
        diamondScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case RetailerOrdersTab.gemstone:
        newDataList = _generateDiamondOrdersList();
        gemstoneList.addAll(newDataList);
        gemstoneScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case RetailerOrdersTab.jewellery:
        newDataList = _generateJewelleryOrdersList();
        jewelleryList.addAll(newDataList);
        jewelleryScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
    }

    emit(RetailerOrderListingListLoadedMoreState(event.currentPage + 1, event.listType));
  }

  Future<void> _onListPullToRefreshEvent(RetailerOrderListPullToRefreshEvent event, Emitter<RetailerOrderListingState> emit) async {
    emit(const RetailerOrderListingReloadState());

    await Future.delayed(const Duration(seconds: 2));
    switch (event.listType) {
      case RetailerOrdersTab.diamond:
        diamondScrollController.pullToRefresh();
        diamondList = _generateDiamondOrdersList();
        break;
      case RetailerOrdersTab.gemstone:
        gemstoneScrollController.pullToRefresh();
        gemstoneList = _generateDiamondOrdersList();
        break;
      case RetailerOrdersTab.jewellery:
        jewelleryScrollController.pullToRefresh();
        jewelleryList = _generateJewelleryOrdersList();
        break;
    }
    refreshCompleter.complete(true);
    emit(const RetailerOrderListingListLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    final RetailerOrdersTab currentTab = RetailerOrdersTab.values[tabController.index];
    add(RetailerOrderListPullToRefreshEvent(listType: currentTab));
    bool result = await refreshCompleter.future;
    return result;
  }

  SmartPaginationScrollController get currentScrollController {
    final RetailerOrdersTab currentTab = RetailerOrdersTab.values[tabController.index];
    switch (currentTab) {
      case RetailerOrdersTab.diamond:
        return diamondScrollController;
      case RetailerOrdersTab.gemstone:
        return gemstoneScrollController;
      case RetailerOrdersTab.jewellery:
        return jewelleryScrollController;
    }
  }

  void clearData() {
    diamondSearchController.clear();
    gemstoneSearchController.clear();
    jewellerySearchController.clear();
    tabController.animateTo(0);
    selectedStoneType = null;
  }

  @override
  Future<void> close() {
    diamondScrollController.dispose();
    gemstoneScrollController.dispose();
    jewelleryScrollController.dispose();
    return super.close();
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
