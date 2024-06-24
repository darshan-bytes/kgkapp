import 'package:kgk/kgk.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  // controllers
  late TabController tabController;
  final TextEditingController diamondSearchController = TextEditingController();
  final TextEditingController gemstoneSearchController = TextEditingController();
  final TextEditingController jewellerySearchController = TextEditingController();

  OrderStoneTypeModel? selectedStoneType;

  // Tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.diamond.tr),
    Tab(text: APPStrings.gemstone.tr),
    Tab(text: APPStrings.jewellery.tr),
  ];

  // Orders lists
  List<MyOrderDetailsModel> filteredDiamondOrdersList = _generateDiamondOrdersList();
  List<MyOrderDetailsModel> originalDiamondOrdersList = _generateDiamondOrdersList();

  List<MyOrderDetailsModel> filteredGemstoneOrdersList = _generateGemstoneOrdersList();
  List<MyOrderDetailsModel> originalGemstoneOrdersList = _generateGemstoneOrdersList();

  List<MyOrderDetailsModel> filteredJewelleryOrdersList = _generateJewelleryOrdersList();
  List<MyOrderDetailsModel> originalJewelleryOrdersList = _generateJewelleryOrdersList();

  // Stone types
  final List<OrderStoneTypeModel> arrStoneType = [
    const OrderStoneTypeModel(name: "Regular"),
    const OrderStoneTypeModel(name: "Special"),
    const OrderStoneTypeModel(name: "Diamond"),
    const OrderStoneTypeModel(name: "Gemstone"),
    const OrderStoneTypeModel(name: "Jewellery"),
  ];

  OrdersBloc() : super(const OrdersInitial()) {
    on<OrdersInitialEvent>(_onInitOrdersEvent);
    on<ChangeOrdersStoneTypeEvent>(_onChangeStoneType);
    on<FilterDiamondOrdersEvent>(_onFilterDiamondOrdersEvent);
    on<FilterGemstoneOrdersEvent>(_onFilterGemstoneOrdersEvent);
    on<FilterJewelleryOrdersEvent>(_onFilterJewelleryOrdersEvent);
    on<ChangeOrderTabsEvent>(_onChangeTabEvent);
  }

  void _onInitOrdersEvent(OrdersInitialEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    clearData();
    emit(const OrdersInitial());
  }

  void _onChangeStoneType(ChangeOrdersStoneTypeEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    selectedStoneType = event.selectedStoneType;
    if (selectedStoneType != null) {
      emit(ChangeOrdersStoneTypeState(selectedStoneType!));
    }
  }

  void _onFilterDiamondOrdersEvent(FilterDiamondOrdersEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    if (diamondSearchController.text.isNotEmpty) {
      filteredDiamondOrdersList = originalDiamondOrdersList
          .where(
              (MyOrderDetailsModel element) => (element.orderId ?? '').toLowerCase().contains(diamondSearchController.text.toLowerCase()))
          .toList();
    } else {
      filteredDiamondOrdersList = originalDiamondOrdersList;
    }
    emit(const FilterDiamondOrdersState());
  }

  void _onFilterGemstoneOrdersEvent(FilterGemstoneOrdersEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    if (gemstoneSearchController.text.isNotEmpty) {
      filteredGemstoneOrdersList = originalGemstoneOrdersList
          .where(
              (MyOrderDetailsModel element) => (element.orderId ?? '').toLowerCase().contains(gemstoneSearchController.text.toLowerCase()))
          .toList();
    } else {
      filteredGemstoneOrdersList = originalGemstoneOrdersList;
    }
    emit(const FilterGemstoneOrdersState());
  }

  void _onFilterJewelleryOrdersEvent(FilterJewelleryOrdersEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    if (jewellerySearchController.text.isNotEmpty) {
      filteredJewelleryOrdersList = originalJewelleryOrdersList
          .where(
              (MyOrderDetailsModel element) => (element.orderId ?? '').toLowerCase().contains(jewellerySearchController.text.toLowerCase()))
          .toList();
    } else {
      filteredJewelleryOrdersList = originalJewelleryOrdersList;
    }
    emit(const FilterJewelleryOrdersState());
  }

  void _onChangeTabEvent(ChangeOrderTabsEvent event, Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    switch (tabController.index) {
      case 0:
        gemstoneSearchController.clear();
        jewellerySearchController.clear();
        filteredGemstoneOrdersList = originalGemstoneOrdersList;
        filteredJewelleryOrdersList = originalJewelleryOrdersList;
        break;
      case 1:
        jewellerySearchController.clear();
        diamondSearchController.clear();
        filteredDiamondOrdersList = originalDiamondOrdersList;
        filteredJewelleryOrdersList = originalJewelleryOrdersList;
        break;
      case 2:
        diamondSearchController.clear();
        gemstoneSearchController.clear();
        filteredDiamondOrdersList = originalDiamondOrdersList;
        filteredGemstoneOrdersList = originalGemstoneOrdersList;
        break;
    }
    emit(const ChangeOrderTabsState());
  }

  void clearData() {
    diamondSearchController.clear();
    gemstoneSearchController.clear();
    jewellerySearchController.clear();
    tabController.animateTo(0);
    selectedStoneType = null;
    filteredDiamondOrdersList = originalDiamondOrdersList;
    filteredGemstoneOrdersList = originalGemstoneOrdersList;
    filteredJewelleryOrdersList = originalJewelleryOrdersList;
  }

  // Helper methods
  static List<MyOrderDetailsModel> _generateDiamondOrdersList() {
    return List.generate(
      8,
      (index) => MyOrderDetailsModel(
        id: index.toString(),
        orderId: "1456${index + 7}",
        orderStatus: OrderStatus.inProgress,
        orderDate: "17/03/23 06:00 PM",
        orderTotal: "\$12,500",
        orderItems: "5",
        orderQuantity: "40",
      ),
    );
  }

  static List<MyOrderDetailsModel> _generateGemstoneOrdersList() {
    return List.generate(
      8,
      (index) => MyOrderDetailsModel(
        id: index.toString(),
        orderId: "1456${index + 3}",
        orderStatus: OrderStatus.active,
        orderDate: "17/03/23 06:00 PM",
        orderTotal: "\$12,500",
        orderItems: "5",
        orderQuantity: "40",
      ),
    );
  }

  static List<MyOrderDetailsModel> _generateJewelleryOrdersList() {
    return List.generate(
      8,
      (index) => MyOrderDetailsModel(
        id: index.toString(),
        orderId: "1456${index + 6}",
        orderStatus: OrderStatus.inProgress,
        orderDate: "17/03/23 06:00 PM",
        orderTotal: "\$12,500",
        orderItems: "5",
        orderQuantity: "40",
      ),
    );
  }
}
