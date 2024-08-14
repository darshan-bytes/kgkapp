import 'package:kgk/kgk.dart';

part 'orders_event.dart';

part 'orders_state.dart';

enum MyOrdersTab {
  diamond,
  gemstone,
  jewellery,
}

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
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
  List<MyOrderDetailsModel> diamondList = [];
  List<MyOrderDetailsModel> gemstoneList = [];
  List<MyOrderDetailsModel> jewelleryList = [];

  // Stone types
  final List<OrderStoneTypeModel> arrStoneType = [
    const OrderStoneTypeModel(name: "Regular"),
    const OrderStoneTypeModel(name: "Special"),
    const OrderStoneTypeModel(name: "Diamond"),
    const OrderStoneTypeModel(name: "Gemstone"),
    const OrderStoneTypeModel(name: "Jewellery"),
  ];

  OrdersBloc() : super(const OrdersInitialState()) {
    on<OrdersInitialEvent>(_onInitOrdersEvent);
    on<ChangeOrdersStoneTypeEvent>(_onChangeStoneType);
    on<MyOrderListingLoadMoreEvent>(_onListingLoadMoreEvent);
    on<ChangeOrderTabsEvent>(_onChangeTabEvent);
    on<OrdersListPullToRefreshEvent>(_onListPullToRefreshEvent);
  }

  void _onInitOrdersEvent(OrdersInitialEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    clearData();
    diamondList = _generateDiamondOrdersList();
    gemstoneList = _generateGemstoneOrdersList();
    jewelleryList = _generateJewelleryOrdersList();

    if (diamondScrollController.isInitialised) {
      diamondScrollController.dispose();
      diamondScrollController = SmartPaginationScrollController();
    }
    diamondScrollController.init(
      loadAction: (int currentPage) async {
        add(MyOrderListingLoadMoreEvent(currentPage: currentPage, listType: MyOrdersTab.diamond));
      },
    );

    if (gemstoneScrollController.isInitialised) {
      gemstoneScrollController.dispose();
      gemstoneScrollController = SmartPaginationScrollController();
    }
    gemstoneScrollController.init(
      loadAction: (int currentPage) async {
        add(MyOrderListingLoadMoreEvent(currentPage: currentPage, listType: MyOrdersTab.gemstone));
      },
    );

    if (jewelleryScrollController.isInitialised) {
      jewelleryScrollController.dispose();
      jewelleryScrollController = SmartPaginationScrollController();
    }
    jewelleryScrollController.init(
      loadAction: (int currentPage) async {
        add(MyOrderListingLoadMoreEvent(currentPage: currentPage, listType: MyOrdersTab.jewellery));
      },
    );

    refreshCompleter.complete(true);
    emit(const OrdersListLoadedState());
  }

  void _onChangeStoneType(ChangeOrdersStoneTypeEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    selectedStoneType = event.selectedStoneType;
    if (selectedStoneType != null) {
      emit(ChangeOrdersStoneTypeState(selectedStoneType!));
    }
  }

  void _onChangeTabEvent(ChangeOrderTabsEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
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
    emit(const ChangeOrderTabsState());
  }

  Future<void> _onListingLoadMoreEvent(MyOrderListingLoadMoreEvent event, Emitter<OrdersState> emit) async {
    emit(OrdersLoadingMoreState(event.listType));
    await Future.delayed(const Duration(seconds: 2));

    List<MyOrderDetailsModel> newDataList = [];

    switch (event.listType) {
      case MyOrdersTab.diamond:
        newDataList = _generateDiamondOrdersList();
        diamondList.addAll(newDataList);
        diamondScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MyOrdersTab.gemstone:
        newDataList = _generateGemstoneOrdersList();
        gemstoneList.addAll(newDataList);
        gemstoneScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
      case MyOrdersTab.jewellery:
        newDataList = _generateJewelleryOrdersList();
        jewelleryList.addAll(newDataList);
        jewelleryScrollController.isPageLoaded.complete(event.currentPage == 3);
        break;
    }

    emit(OrdersListLoadedMoreState(event.currentPage + 1, event.listType));
  }

  Future<void> _onListPullToRefreshEvent(OrdersListPullToRefreshEvent event, Emitter<OrdersState> emit) async {
    emit(const OrdersReloadState());
    await Future.delayed(const Duration(seconds: 2));
    switch (event.listType) {
      case MyOrdersTab.diamond:
        diamondScrollController.pullToRefresh();
        diamondList = _generateDiamondOrdersList();
        break;
      case MyOrdersTab.gemstone:
        gemstoneScrollController.pullToRefresh();
        gemstoneList = _generateGemstoneOrdersList();
        break;
      case MyOrdersTab.jewellery:
        jewelleryScrollController.pullToRefresh();
        jewelleryList = _generateJewelleryOrdersList();
        break;
    }
    refreshCompleter.complete(true);
    emit(const OrdersListLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    final MyOrdersTab currentTab = MyOrdersTab.values[tabController.index];
    add(OrdersListPullToRefreshEvent(listType: currentTab));
    bool result = await refreshCompleter.future;
    return result;
  }

  SmartPaginationScrollController get currentScrollController {
    final MyOrdersTab currentTab = MyOrdersTab.values[tabController.index];
    switch (currentTab) {
      case MyOrdersTab.diamond:
        return diamondScrollController;
      case MyOrdersTab.gemstone:
        return gemstoneScrollController;
      case MyOrdersTab.jewellery:
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
  static List<MyOrderDetailsModel> _generateDiamondOrdersList() {
    return List.generate(
      10,
      (index) => MyOrderDetailsModel(
        id: index.toString(),
        orderId: "1456${index + 7}",
        orderStatus: ProjectStatus.orangeInProgress,
        orderDate: "17/03/23",
        orderTotal: "\$12,500",
        orderItems: "5",
        orderQuantity: "40",
        deliveryDate: "22/03/23",
        orderImages: [
          'https://i.ibb.co/HgjT1rt/Image.png',
          'https://i.ibb.co/1LRFJ3h/Lab-grown-Category.png',
          'https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png',
          'https://i.ibb.co/1J2wWPr/Image-4.png',
          'https://i.ibb.co/FVJDbvp/Image323.png',
          'https://i.ibb.co/4VSsw5B/Image-8.png'
        ],
      ),
    );
  }

  static List<MyOrderDetailsModel> _generateGemstoneOrdersList() {
    return List.generate(
      10,
      (index) => MyOrderDetailsModel(
        id: index.toString(),
        orderId: "1456${index + 3}",
        orderStatus: ProjectStatus.orangeInProgress,
        orderDate: "17/03/23",
        orderTotal: "\$12,500",
        orderItems: "5",
        orderQuantity: "40",
        deliveryDate: "22/03/23",
        orderImages: [
          'https://i.ibb.co/HgjT1rt/Image.png',
          'https://i.ibb.co/1LRFJ3h/Lab-grown-Category.png',
          'https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png',
          'https://i.ibb.co/1J2wWPr/Image-4.png',
          'https://i.ibb.co/FVJDbvp/Image323.png',
          'https://i.ibb.co/4VSsw5B/Image-8.png'
        ],
      ),
    );
  }

  static List<MyOrderDetailsModel> _generateJewelleryOrdersList() {
    return List.generate(
      10,
      (index) => MyOrderDetailsModel(
        id: index.toString(),
        orderId: "1456${index + 6}",
        orderStatus: ProjectStatus.orangeInProgress,
        orderDate: "17/03/23",
        orderTotal: "\$12,500",
        orderItems: "5",
        orderQuantity: "40",
        deliveryDate: "22/03/23",
        orderImages: [
          'https://i.ibb.co/HgjT1rt/Image.png',
          'https://i.ibb.co/1LRFJ3h/Lab-grown-Category.png',
          'https://i.ibb.co/nBQy6n5/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png',
          'https://i.ibb.co/1J2wWPr/Image-4.png',
          'https://i.ibb.co/FVJDbvp/Image323.png',
          'https://i.ibb.co/4VSsw5B/Image-8.png'
        ],
      ),
    );
  }
}
