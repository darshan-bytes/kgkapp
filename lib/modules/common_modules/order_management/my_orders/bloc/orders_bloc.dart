import 'package:kgk/kgk.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  /// List of Order data
  List<MyOrderDetailsModel> originalOrderList = [];

  /// List of filtered Order data
  List<MyOrderDetailsModel> filteredOrderList = [];

  /// List of filter data
  List<FilterData> filterData = [];

  /// List of applied filter data
  final Map<int, List<FilterData>> appliedFilterData = {};

  /// Identify Current user type
  UserType userType = UserType.b2cUser;

  /// TabController for managing tabs in the UI.
  late TabController tabController;

  /// For keeping track of the current tab and stop same tab on click event
  int currentTab = -1;

  /// List of tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.diamond.tr),
    Tab(text: APPStrings.gemstone.tr),
    Tab(text: APPStrings.jewellery.tr),
  ];

  /// TODO: selected stone type for filter is currently not in use as discussed with JD.
  // OrderStoneTypeModel? selectedStoneType;

  /// Order search controller
  final TextEditingController orderSearchController = TextEditingController();

  /// paginationScrollController is used to control the pagination
  SmartPaginationScrollController orderPaginationScrollController = SmartPaginationScrollController();

  /// Pagination and filter data
  int? totalNumberOfPages;

  /// Focus node
  FocusNode focusNode = FocusNode();

  /// TODO: selected stone type for filter is currently not in use as discussed with JD.
  // final List<OrderStoneTypeModel> arrStoneType = [
  //   const OrderStoneTypeModel(name: "Regular"),
  //   const OrderStoneTypeModel(name: "Special"),
  //   const OrderStoneTypeModel(name: "Diamond"),
  //   const OrderStoneTypeModel(name: "Gemstone"),
  //   const OrderStoneTypeModel(name: "Jewellery"),
  // ];

  /// Constructor for OrdersBloc
  OrdersBloc() : super(const OrdersInitialState()) {
    on<OrdersInitialEvent>(_onInitOrdersEvent);
    on<ChangeOrderTabsEvent>(_onChangeTabEvent);
    on<MyOrderListingLoadMoreEvent>(_onListingLoadMoreEvent);
    on<OrdersListPullToRefreshEvent>(_onListPullToRefreshEvent);
    on<OrdersListSearchEvent>(_onListSearchEvent);
    on<OrdersListFilterEvent>(_onListFilterEvent);

    /// TODO: selected stone type for filter is currently not in use as discussed with JD.
    // on<ChangeOrdersStoneTypeEvent>(_onChangeStoneType);
  }

  /// Closes the OrdersBloc
  @override
  Future<void> close() {
    orderPaginationScrollController.dispose();
    return super.close();
  }

  /// Initializes the OrdersBloc by fetching order data
  Future<void> _onInitOrdersEvent(OrdersInitialEvent event, Emitter<OrdersState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// Handles the ChangeOrderTabsEvent for tab switching
  Future<void> _onChangeTabEvent(ChangeOrderTabsEvent event, Emitter<OrdersState> emit) async {
    await _handleTabSelection(event.context, event.index, emit);
  }

  /// Handles the load more event for order listings
  Future<void> _onListingLoadMoreEvent(MyOrderListingLoadMoreEvent event, Emitter<OrdersState> emit) async {
    await _handleLoadMore(context: event.context, emit: emit, currentPage: event.currentPage);
  }

  /// Handles the pull to refresh event for order listings
  Future<void> _onListPullToRefreshEvent(OrdersListPullToRefreshEvent event, Emitter<OrdersState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  /// Handles the search event for order listings
  Future<void> _onListSearchEvent(OrdersListSearchEvent event, Emitter<OrdersState> emit) async {
    _handleSearch(emit);
  }

  /// Handles the filter event for order listings
  Future<void> _onListFilterEvent(OrdersListFilterEvent event, Emitter<OrdersState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  /// TODO: selected stone type for filter is currently not in use as discussed with JD.
  // void _onChangeStoneType(ChangeOrdersStoneTypeEvent event, Emitter<OrdersState> emit) {
  //   emit(const OrdersReloadState());
  //   selectedStoneType = event.selectedStoneType;
  //   if (selectedStoneType != null) {
  //     emit(ChangeOrdersStoneTypeState(selectedStoneType!));
  //   }
  // }

  /// Initializes the OrdersBloc with pagination and initial data fetching
  Future<void> _initializeBloc(BuildContext context, Emitter<OrdersState> emit) async {
    emit(const OrdersLoadingState());
    userType = BlocProvider.of<AppBloc>(context).userType;
    _initializePagination(context);
    _fetchFilterData(context, emit);
    if (totalNumberOfPages == null || orderPaginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchOrderListData(context, emit);
    }
    emit(const OrdersListLoadedState());
  }

  /// Initializes pagination for loading more order data
  void _initializePagination(BuildContext context) {
    orderPaginationScrollController.init(
      loadAction: (int currentPage) async {
        add(MyOrderListingLoadMoreEvent(currentPage: currentPage, context: context));
      },
    );
  }

  /// Fetches filter data
  void _fetchFilterData(BuildContext context, Emitter<OrdersState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  /// Handles tab selection and reloads order data accordingly
  Future<void> _handleTabSelection(BuildContext context, int index, Emitter<OrdersState> emit) async {
    if (currentTab == index) return;
    currentTab = index;
    emit(const OrdersLoadingState());

    /// Update filter data for the current tab
    BlocProvider.of<AdvanceSortFilterBloc>(context)
        .add(AddAdvanceSortFilterDataEvent(filterOptionList: appliedFilterData[currentTab] ?? [], context: context));

    /// Reload order data
    await _reloadOrderData(context, emit);
    emit(ChangeOrderTabsState());
  }

  /// Reloads the order data for the specified category
  Future<void> _reloadOrderData(BuildContext context, Emitter<OrdersState> emit) async {
    orderSearchController.clear();
    orderPaginationScrollController.pullToRefresh();
    originalOrderList.clear();
    filteredOrderList.clear();
    await fetchOrderListData(context, emit);
  }

  /// Handles loading more orders when user scrolls
  Future<void> _handleLoadMore({required BuildContext context, required Emitter<OrdersState> emit, required int currentPage}) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(OrdersLoadingMoreState());
      await fetchOrderListData(context, emit);
      emit(OrdersListLoadedMoreState(currentPage));
    }
  }

  /// Pulls to refresh the order list
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<OrdersState> emit) async {
    emit(const OrdersLoadingState());
    orderPaginationScrollController.pullToRefresh();
    originalOrderList.clear();
    filteredOrderList.clear();
    await fetchOrderListData(context, emit);
    emit(const OrdersListLoadedState());
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<OrdersState> emit, List<FilterData> newAppliedFilterData) async {
    emit(OrdersLoadingState());
    orderPaginationScrollController.pullToRefresh();
    originalOrderList.clear();

    /// set applied filter data base on current tab
    appliedFilterData[currentTab] = newAppliedFilterData.map((e) => e).toList();

    await fetchOrderListData(context, emit);
    emit(OrdersListLoadedState());
  }

  /// Handles the search event locally
  void _handleSearch(Emitter<OrdersState> emit) {
    emit(const OrdersReloadState());
    if (orderSearchController.text.isNotEmpty) {
      String query = orderSearchController.text.toLowerCase();
      filteredOrderList = originalOrderList
          .where((auction) =>
              (auction.deliveryDate ?? '').toLowerCase().contains(query) ||
              (auction.orderDate ?? '').toLowerCase().contains(query) ||
              (auction.orderId ?? '').toLowerCase().contains(query) ||
              (auction.orderItems ?? '').toLowerCase().contains(query) ||
              (auction.orderQuantity ?? '').toLowerCase().contains(query))
          .toList();
    } else {
      filteredOrderList = List.from(originalOrderList);
    }
    emit(const OrdersListLoadedState());
  }

  /// Builds the filters dynamically based on the filter data
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {};

    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD)
            ].join(',');
          }
          break;
        case FilterType.checkbox:
          List<String?>? selectedCodes = element.secondaryFilterData?.where((e) => e.isSelected).map((e) => e.code).toList();
          if (selectedCodes != null && selectedCodes.isNotEmpty) {
            filters[element.code ?? ''] = selectedCodes.join(',');
          }
          break;
        default:
          break;
      }
    }

    return filters;
  }

  /// Builds the query dynamically based on the filter data, pagination, and sorting
  Map<String, dynamic> buildQuery({
    required List<FilterData> filterData,
    required int currentPage,
    required int pageLimit,
    required String commodity,
  }) {
    Map<String, dynamic> query = {};
    query.addAll(buildFilters(filterData));
    query.addAll({
      ApiKey.page: currentPage,
      ApiKey.limit: pageLimit,
      ApiKey.commodity: commodity,
    });
    return query;
  }

  /// Fetches the order list data from the API
  Future<void> fetchOrderListData(BuildContext context, Emitter<OrdersState> emit,
      {bool isLoadMore = false, Map<String, dynamic>? query}) async {
    /// Here we need commodity base order data so we Get the commodity for the current tab
    String commodity = _getCommodityForTab(tabController.index);

    /// Build the query base on the current tab applied filters data
    query = buildQuery(
      filterData: appliedFilterData[tabController.index] ?? [],
      currentPage: orderPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
      commodity: commodity,
    );
    Either<ErrorResponse, PaginationData<OrderItem>>? response =
        await AppRepository(context).getMyOrderList(body: query, isLoadMore: isLoadMore);

    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      originalOrderList.addAll(_populateOrderList((success.dataList as List<OrderItem>)));
      filteredOrderList = List.from(originalOrderList);
      orderPaginationScrollController.isPageLoaded.complete(orderPaginationScrollController.currentPage == totalNumberOfPages);
      emit(OrdersListLoadedState());
    });
  }

  /// Populates the order list from the API data
  List<MyOrderDetailsModel> _populateOrderList(List<OrderItem> dataList) {
    return dataList.map<MyOrderDetailsModel>((OrderItem data) {
      return MyOrderDetailsModel(
        id: data.sId,
        orderId: data.sId,
        orderStatus: ProjectStatus.orangeInProgress,
        orderDate: data.createdAt,
        orderTotal: data.totalPrice,
        orderItems: data.items?.toString(),
        orderQuantity: data.totalQuantity?.toString(),
        deliveryDate: data.createdByDetails?.accountType,
        orderImages: [data.createdByDetails?.profilePic ?? ''],
      );
    }).toList();
  }

  /// Sets up the filters for each tab
  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response = await AppRepository(context).fetchOrderListingFilterOptionList();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (AdvanceFilterOptionModel success) {
      filterData.clear();
      if (success.filters.isNotNullNorEmpty) {
        for (Filters filterOption in success.filters ?? <Filters>[]) {
          FilterData filter = FilterData(
            name: filterOption.title,
            code: filterOption.key,
            inputType: filterOption.type,
            filterType: filterOption.getFilterType(filterType: filterOption.type),
            secondaryFilterData: _getSecondaryFilterData(filterOption: filterOption),
          );
          filterData.add(filter);
        }
        List.generate(tabs.length, (index) {
          return appliedFilterData[index] = filterData.map((e) {
            FilterData filter = FilterData(
              code: e.code,
              name: e.name,
              inputType: e.inputType,
              filterType: e.filterType,
              dateRange: e.dateRange,
              isAdvanceFilter: e.isAdvanceFilter,
              minMaxValues: e.minMaxValues,
              rangeValues: e.rangeValues,
              subFilterCodes: e.subFilterCodes,
            );
            filter.secondaryFilterData = e.secondaryFilterData?.map((se) {
              SecondaryFilterData secondaryFilterData = SecondaryFilterData(
                name: se.name,
                code: se.code,
                image: se.image,
                isSelected: se.isSelected,
              );
              return secondaryFilterData;
            }).toList();
            return filter;
          }).toList();
        });
      }
    });
  }

  /// Get secondary filter data
  List<SecondaryFilterData> _getSecondaryFilterData({required Filters filterOption}) {
    FilterType filterType = filterOption.getFilterType(filterType: filterOption.type);
    List<SecondaryFilterData> tempSecondaryData = [];
    if (filterType == FilterType.checkbox) {
      tempSecondaryData = filterOption.options?.map((option) => SecondaryFilterData(name: option.label, code: option.value)).toList() ?? [];
    }
    return tempSecondaryData;
  }

  String _getCommodityForTab(int index) {
    switch (index) {
      case 0:
        return AppConst.diamond;
      case 1:
        return AppConst.gemstone;
      case 2:
        return AppConst.jewellery;
      default:
        return AppConst.diamond;
    }
  }
}
