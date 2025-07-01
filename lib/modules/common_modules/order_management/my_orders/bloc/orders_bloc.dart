import 'package:kgk/kgk.dart';

part 'orders_event.dart';

part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  late AppBloc appBloc;

  /// List of Order data
  List<MyOrderDetailsModel> originalOrderList = [];

  /// List of filtered Order data
  List<MyOrderDetailsModel> filteredOrderList = [];

  /// List of filter data
  List<FilterData> filterData = [];

  /// Identify Current user type
  UserType userType = UserType.b2cUser;

  /// Order search controller
  final TextEditingController orderSearchController = TextEditingController();

  /// paginationScrollController is used to control the pagination
  SmartPaginationScrollController orderPaginationScrollController = SmartPaginationScrollController();

  /// Pagination and filter data
  int? totalNumberOfPages;

  /// Focus node
  FocusNode focusNode = FocusNode();

  /// Constructor for OrdersBloc
  OrdersBloc() : super(const OrdersInitialState()) {
    on<OrdersInitialEvent>(_onInitOrdersEvent);
    on<MyOrderListingLoadMoreEvent>(_onListingLoadMoreEvent);
    on<OrdersListPullToRefreshEvent>(_onListPullToRefreshEvent);
    on<OrdersListSearchEvent>(_onListSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<OrdersListFilterEvent>(_onListFilterEvent);
    on<NavigateToOrderDetailsEvent>(_onNavigateToOrderDetailsEvent);
  }

  @override
  Future<void> close() {
    orderPaginationScrollController.dispose();
    return super.close();
  }

  /// Initializes the OrdersBloc by fetching order data
  Future<void> _onInitOrdersEvent(OrdersInitialEvent event, Emitter<OrdersState> emit) async {
    await _initializeBloc(event.context, emit);
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
    await _handleSearch(emit, context: event.context);
  }

  /// Handles the filter event for order listings
  Future<void> _onListFilterEvent(OrdersListFilterEvent event, Emitter<OrdersState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  /// Handles the navigate to order details event
  Future<void> _onNavigateToOrderDetailsEvent(NavigateToOrderDetailsEvent event, Emitter<OrdersState> emit) async {
    await _handleNavigateToOrderDetails(event, emit);
  }

  /// Initializes the OrdersBloc with pagination and initial data fetching
  Future<void> _initializeBloc(BuildContext context, Emitter<OrdersState> emit) async {
    emit(const OrdersLoadingState());
    appBloc = BlocProvider.of<AppBloc>(context);
    userType = appBloc.userType;
    _initializePagination(context);
    await _fetchFilterData(context, emit);
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
  Future<void> _fetchFilterData(BuildContext context, Emitter<OrdersState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
    }
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
    filterData = newAppliedFilterData;
    await fetchOrderListData(context, emit);
    emit(OrdersListLoadedState());
  }

  /// Handles the search event locally
  Future<void> _handleSearch(Emitter<OrdersState> emit, {required BuildContext context}) async {
    emit(const OrdersLoadingState());
    orderPaginationScrollController.pullToRefresh();
    filteredOrderList.clear();
    originalOrderList.clear();
    await fetchOrderListData(context, emit);
    if (orderSearchController.text.isNotNullNorEmpty) focusNode.requestFocus();
    emit(const OrdersListLoadedState());
  }

  /// Handles the navigate to order details event
  Future<void> _handleNavigateToOrderDetails(NavigateToOrderDetailsEvent event, Emitter<OrdersState> emit) async {
    event.context.pushNamed(AppRoutes.orderDetailsPage, arguments: {RoutesData.orderNumber: event.uniqueId, RoutesData.bloc: this});
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
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
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
    String? commodity,
    required String searchQuery,
  }) {
    Map<String, dynamic> query = {};
    query.addAll(buildFilters(filterData));
    query.addAll({
      if (searchQuery.isNotEmpty) ApiKey.search: searchQuery,
      ApiKey.page: currentPage,
      ApiKey.limit: pageLimit,
      ApiKey.dir: AppConst.sortValueDesc,
      ApiKey.field: AppConst.uniqueId,
      if (commodity != null) ApiKey.commodity: commodity,
    });
    return query;
  }

  /// Fetches the order list data from the API
  Future<void> fetchOrderListData(
    BuildContext context,
    Emitter<OrdersState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
  }) async {
    /// Build the query base on the current tab applied filters data
    buildQuery(
      filterData: filterData,
      searchQuery: orderSearchController.text,
      currentPage: orderPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    ).forEach((key, value) {
      query ??= {};
      query![key] = value;
    });
    Either<ErrorResponse, PaginationData<OrderItem>>? response = await AppRepository(
      context,
    ).getMyOrderList(body: query, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
        emit(OrdersListLoadedState());
      },
      (success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.totalRecords, AppConst.pageLimit);
        originalOrderList.addAll(_populateOrderList((success.dataList as List<OrderItem>)));
        filteredOrderList = List.from(originalOrderList);
        if (!orderPaginationScrollController.isPageLoaded.isCompleted) {
          orderPaginationScrollController.isPageLoaded.complete(orderPaginationScrollController.currentPage == totalNumberOfPages);
        }
        emit(OrdersListLoadedState());
      },
    );
  }

  /// Populates the order list from the API data
  List<MyOrderDetailsModel> _populateOrderList(List<OrderItem> dataList) {
    return dataList.map<MyOrderDetailsModel>((OrderItem data) {
      return MyOrderDetailsModel(
        id: data.uniqueId?.toString(),
        orderId: data.uniqueId?.toString(),
        orderStatus: getOrderStatus(orderStatus: data.orderStatus ?? ''),
        orderDate: data.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
        orderTotal: data.totalPrice?.setCurrency,
        orderItems: data.items?.toString(),
        orderQuantity: data.totalQuantity?.toString(),
        orderImages: [data.createdByDetails?.profilePic?.setMediaUrl ?? ''],
        orderedBy: data.createdByDetails?.fullName ?? '',
        commodity: data.commodity ?? '',
      );
    }).toList();
  }

  /// Sets up the filters for each tab
  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response = await AppRepository(context).fetchOrderListingFilterOptionList();
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (AdvanceFilterOptionModel success) {
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
        }
      },
    );
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

  ProjectStatus getOrderStatus({required String orderStatus}) {
    switch (orderStatus) {
      case "delay":
        return ProjectStatus.delay;
      case "pending":
        return ProjectStatus.pending;
      case "completed":
        return ProjectStatus.completed;
      case "cancelled":
        return ProjectStatus.cancelled;
      case "in_progress":
      case "inprogress":
        return ProjectStatus.orangeInProgress;
      default:
        return ProjectStatus.pending;
    }
  }
}
