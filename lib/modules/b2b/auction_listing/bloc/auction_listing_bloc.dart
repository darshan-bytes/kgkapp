import 'package:kgk/kgk.dart';

part 'auction_listing_event.dart';

part 'auction_listing_state.dart';

class AuctionListingBloc extends Bloc<AuctionListingEvent, AuctionListingState> {
  /// This controller is used to control the search
  final TextEditingController auctionSearchController = TextEditingController();

  /// This list holds the original data
  List<AuctionListModel> originalAuctionList = [];

  /// paginationScrollController is used to control the pagination
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// Focus node is used to control the focus
  FocusNode focusNode = FocusNode();

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  AuctionListingBloc() : super(AuctionListingInitialState()) {
    on<InitialAuctionListingEvent>(_onInitialAuctionListingEvent);
    on<AuctionListLoadMoreEvent>(_onAuctionListLoadMoreEvent);
    on<AuctionListPullToRefreshEvent>(_onAuctionListPullToRefreshEvent);
    on<AuctionListSearchEvent>(_onAuctionListSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<AuctionListFilterEvent>(_onAuctionListFilterEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> _onInitialAuctionListingEvent(InitialAuctionListingEvent event, Emitter<AuctionListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onAuctionListLoadMoreEvent(AuctionListLoadMoreEvent event, Emitter<AuctionListingState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onAuctionListPullToRefreshEvent(AuctionListPullToRefreshEvent event, Emitter<AuctionListingState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onAuctionListFilterEvent(AuctionListFilterEvent event, Emitter<AuctionListingState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  Future<void> _onAuctionListSearchEvent(AuctionListSearchEvent event, Emitter<AuctionListingState> emit) async {
    emit(AuctionListingReloadState());
    paginationScrollController.pullToRefresh();
    originalAuctionList.clear();

    await fetchAuctionListData(event.context, emit, isLoadMore: false);
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<AuctionListingState> emit) async {
    emit(AuctionListingLoadingState());
    _initializePagination(context);
    await _fetchFilterData(context, emit);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchAuctionListData(context, emit, isLoadMore: false);
    }
    emit(AuctionListingLoadedState());
  }

  Future<void> _fetchFilterData(BuildContext context, Emitter<AuctionListingState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
    }
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(AuctionListLoadMoreEvent(context: context, currentPage: currentPage));
      },
    );
  }

  /// Build the filters dynamically
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {};

    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD, isWithLanguage: false),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD, isWithLanguage: false),
            ];
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

  /// Build the complete query dynamically
  Map<String, dynamic> buildQuery({required List<FilterData> filterData, required int currentPage, required int pageLimit}) {
    Map<String, dynamic> query = {};

    /// this is for status filter
    query.addAll(buildFilters(filterData));

    /// Add pagination, search, and sorting parameters
    query.addAll({
      ApiKey.search: auctionSearchController.text.trim(),
      ApiKey.page: currentPage,
      ApiKey.limit: pageLimit,
      ApiKey.sortField: ApiKey.id,
      ApiKey.direction: AppConst.sortValueDesc.toUpperCase(),
    });
    return query;
  }

  /// Fetch auction listing data
  Future<void> fetchAuctionListData(
    BuildContext context,
    Emitter<AuctionListingState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
  }) async {
    /// Build the query dynamically
    query = buildQuery(filterData: filterData, currentPage: paginationScrollController.currentPage, pageLimit: AppConst.pageLimit);
    Either<ErrorResponse, AuctionListingModel>? response = await AppRepository(context).getAuctionList(body: query, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (AuctionListingModel success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        if (paginationScrollController.currentPage == 1) {
          originalAuctionList.clear();
        }
        originalAuctionList.addAll(_populateAuctionList(success.data));
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
        emit(AuctionListingLoadedState());
      },
    );
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<AuctionListingState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(AuctionListLoadingMoreState());
      await fetchAuctionListData(context, emit, isLoadMore: false);
      emit(AuctionListLoadedMoreState(currentPage: currentPage));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<AuctionListingState> emit) async {
    emit(AuctionListingLoadingState());
    paginationScrollController.pullToRefresh();
    await fetchAuctionListData(context, emit, isLoadMore: false);
    emit(AuctionListingLoadedState());
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<AuctionListingState> emit, List<FilterData> appliedFilterData) async {
    emit(AuctionListingLoadingState());
    paginationScrollController.pullToRefresh();
    filterData = appliedFilterData;
    await fetchAuctionListData(context, emit, isLoadMore: false);
    emit(AuctionListingLoadedState());
  }

  /// Populate auction list
  List<AuctionListModel> _populateAuctionList(List<AuctionDatum> dataList) {
    return dataList.map<AuctionListModel>((AuctionDatum data) {
      return AuctionListModel(
        id: data.auctionId,
        imageUrl: data.productImage,
        name: data.productDescription,
        skuNo: data.productSku,
        orderStatus: data.status,
        bidAmount: data.bidAmount?.setCurrency,
        bidPlacedOn: data.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
        type: data.type,
        productId: data.productId,
      );
    }).toList();
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response = await AppRepository(context).fetchAuctionListingFilterOptionList();
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
}
