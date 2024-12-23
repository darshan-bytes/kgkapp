import 'package:kgk/kgk.dart';

part 'exhibition_listing_event.dart';

part 'exhibition_listing_state.dart';

class ExhibitionListingBloc extends Bloc<ExhibitionListingEvent, ExhibitionListingState> {
  final TextEditingController searchController = TextEditingController();

  List<ExhibitionListingModel> exhibitionCatalogueList = [];

  List<FilterData> filterData = [];

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  int? totalNumberOfPages;

  List<ExhibitionListingModel> exhibitionNameListing = [];

  /// Focus node is used to control the focus
  FocusNode focusNode = FocusNode();

  ExhibitionListingBloc() : super(ExhibitionListingInitialState()) {
    on<InitialExhibitionListingEvent>(_onInitialExhibitionListingEvent);
    on<LoadMoreExhibitionListingEvent>(_onLoadMoreExhibitionListingEvent);
    on<ExhibitionListingPullToRefreshEvent>(_onExhibitionListingPullToRefreshEvent);
    on<ExhibitionListingSearchEvent>(_onExhibitionListingSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<ExhibitionListingFilterEvent>(_onExhibitionListingFilterEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> _onInitialExhibitionListingEvent(InitialExhibitionListingEvent event, Emitter<ExhibitionListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onLoadMoreExhibitionListingEvent(LoadMoreExhibitionListingEvent event, Emitter<ExhibitionListingState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onExhibitionListingPullToRefreshEvent(
      ExhibitionListingPullToRefreshEvent event, Emitter<ExhibitionListingState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onExhibitionListingFilterEvent(ExhibitionListingFilterEvent event, Emitter<ExhibitionListingState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<ExhibitionListingState> emit) async {
    emit(ExhibitionListingLoadingState());
    _initializePagination(context);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchExhibitionListingData(context, emit, isLoadMore: false);
    }
    emit(ExhibitionListingLoadedState());
    await _fetchFilterData(context, emit);
  }

  Future<void> _fetchFilterData(BuildContext context, Emitter<ExhibitionListingState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context, emit);
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreExhibitionListingEvent(context: context, currentPage: currentPage));
      },
    );
  }

  Future<void> _onExhibitionListingSearchEvent(ExhibitionListingSearchEvent event, Emitter<ExhibitionListingState> emit) async {
    emit(ExhibitionListingReloadState());
    paginationScrollController.pullToRefresh();
    exhibitionCatalogueList.clear();
    await fetchExhibitionListingData(event.context, emit, isLoadMore: false);
    if (searchController.text.isNotNullNorEmpty) focusNode.requestFocus();
    emit(ExhibitionListingLoadedState());
  }

  /// Build the filters dynamically
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {ApiKey.dynamicObject: {}};
    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[ApiKey.dynamicObject]?[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD)
            ];
          }
          break;
        case FilterType.createdBySearch:
        case FilterType.checkbox:
          List<String?>? selectedCodes = element.secondaryFilterData?.where((e) => e.isSelected).map((e) => e.code).toList();
          if (selectedCodes != null && selectedCodes.isNotEmpty) {
            filters[ApiKey.dynamicObject]?[element.code ?? ''] = selectedCodes;
          }
          break;
        default:
          break;
      }
    }
    return filters;
  }

  Map<String, dynamic> buildQuery({
    required List<FilterData> filterData,
    required String searchString,
    required int currentPage,
    required int pageLimit,
  }) {
    Map<String, dynamic> query = {};
    query[ApiKey.filters] = buildFilters(filterData);

    query.addAll({
      ApiKey.pagination: {ApiKey.page: currentPage, ApiKey.limit: pageLimit},
      ApiKey.search: searchString,
      ApiKey.sort: {
        ApiKey.field: ApiKey.id,
        ApiKey.dir: AppConst.sortValueDesc.toUpperCase(),
      },
    });
    return query;
  }

  Future<void> fetchExhibitionListingData(BuildContext context, Emitter<ExhibitionListingState> emit,
      {bool isLoadMore = false, Map<String, dynamic>? query}) async {
    query = buildQuery(
      filterData: filterData,
      searchString: searchController.text,
      currentPage: paginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<ExhibitionListDataModel>>? response =
        await AppRepository(context).getExhibitionListing(body: query);

    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (PaginationData<ExhibitionListDataModel> success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      List<ExhibitionListDataModel> dataList = (success.dataList as List<ExhibitionListDataModel>?) ?? [];
      exhibitionCatalogueList.addAll(_populateExhibitionCatalogueList(dataList));
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(ExhibitionListingLoadedState());
    });
  }

  Future<void> _handleLoadMore(BuildContext context, Emitter<ExhibitionListingState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(ExhibitionListLoadingMoreState());
      await fetchExhibitionListingData(context, emit, isLoadMore: true);
      emit(ExhibitionListLoadMoreState(currentPage: currentPage));
    }
  }

  Future<void> _handlePullToRefresh(BuildContext context, Emitter<ExhibitionListingState> emit) async {
    emit(ExhibitionListingLoadingState());
    paginationScrollController.pullToRefresh();
    exhibitionCatalogueList.clear();
    await fetchExhibitionListingData(context, emit, isLoadMore: false);
    emit(ExhibitionListingLoadedState());
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<ExhibitionListingState> emit, List<FilterData> appliedFilterData) async {
    emit(ExhibitionListingLoadingState());
    paginationScrollController.pullToRefresh();
    exhibitionCatalogueList.clear();
    filterData = appliedFilterData;
    await fetchExhibitionListingData(context, emit, isLoadMore: false);
    emit(ExhibitionListingLoadedState());
  }

  List<ExhibitionListingModel> _populateExhibitionCatalogueList(List<ExhibitionListDataModel> dataList) {
    return dataList.map((data) {
      return ExhibitionListingModel(
          image: data.fileUrl?.setMediaUrl,
          name: data.name,
          author: data.description,
          date: data.fullDate,
          time: data.fullTime,
          status: data.status?.toUpperCamelCase,
          location: data.venue,
          onTap: () {},
          id: data.id.toString());
    }).toList();
  }

  Future<void> _setupFilters(BuildContext context, Emitter<ExhibitionListingState> emit) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).fetchExhibitionListingFilterOptionList();
    await response?.fold((l) {
      Utils.showMessage(l.message);
    }, (AdvanceFilterOptionModel success) async {
      filterData.clear();
      if (success.filters.isNotNullNorEmpty) {
        for (Filters filterOption in success.filters ?? []) {
          FilterData filter = FilterData(
            name: filterOption.title,
            code: filterOption.key,
            inputType: filterOption.type,
            filterType: filterOption.getFilterType(filterType: filterOption.type),
            secondaryFilterData: _getSecondaryFilterData(filterOption: filterOption),
          );
          filterData.add(filter);
        }
        emit(ExhibitionFilterListLoadedState());
      }
    });
  }

  List<SecondaryFilterData> _getSecondaryFilterData({required Filters filterOption}) {
    FilterType filterType = filterOption.getFilterType(filterType: filterOption.type);
    List<SecondaryFilterData> tempSecondaryData = [];
    if (filterType == FilterType.checkbox) {
      tempSecondaryData = filterOption.options?.map((option) => SecondaryFilterData(name: option.label, code: option.value)).toList() ?? [];
    }
    return tempSecondaryData;
  }
}
