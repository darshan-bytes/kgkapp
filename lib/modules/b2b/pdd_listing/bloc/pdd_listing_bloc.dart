import 'package:kgk/kgk.dart';

part 'pdd_listing_event.dart';

part 'pdd_listing_state.dart';

class PddListingBloc extends Bloc<PddListingEvent, PddListingState> {
  bool isGrid = true;
  final TextEditingController presentationSearchController = TextEditingController();
  List<B2BCustomListingDataModel> presentationList = [];

  //Pagination controller
  SmartPaginationScrollController gridPaginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  /// totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// Focus node is used to control the focus
  FocusNode focusNode = FocusNode();

  PddListingBloc() : super(PddListingInitial()) {
    on<InitialPddListingEvent>(_onInitialPresentationListEvent);
    on<PresentationChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<FilterPresentationEvent>(_onFilterPresentationEvent);
    on<NavigateToPddPreviewEvent>(_navigateToPreview);
    on<PddListLoadMoreEvent>(_onPddListLoadMoreEvent);
    on<PddListPullToRefreshEvent>(_onPddListPullToRefresh);
    on<PddListSearchEvent>(_onPddListSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
  }

  Future<void> _onInitialPresentationListEvent(InitialPddListingEvent event, Emitter<PddListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<PddListingState> emit) async {
    emit(PddListLoadingState());
    _initializePagination(context);
    _fetchFilterData(context, emit);
    if (totalNumberOfPages == null || gridPaginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchPresentationList(context, emit, isLoadMore: false);
    }
    emit(PddListingLoadedState());
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    gridPaginationScrollController.init(
      loadAction: (int currentPage) async {
        add(PddListLoadMoreEvent(currentPage, context));
      },
    );
  }

  Future<void> _onPddListSearchEvent(PddListSearchEvent event, Emitter<PddListingState> emit) async {
    emit(PddListLoadingState());
    gridPaginationScrollController.pullToRefresh();
    presentationList.clear();
    await fetchPresentationList(event.context, emit, isLoadMore: false, searchString: presentationSearchController.text);
    if (presentationSearchController.text.isNotNullNorEmpty) focusNode.requestFocus();
    emit(PddListingLoadedState());
  }

  void _fetchFilterData(BuildContext context, Emitter<PddListingState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);

      ///Here we will add the wishlist sort and filter data using this event in wishlist filter bloc
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).fetchPddListingFilterOptionList();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (AdvanceFilterOptionModel success) {
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

  void _onChangeListingTypeEvent(PresentationChangeListingTypeEvent event, Emitter<PddListingState> emit) {
    emit(PddListingReloadState());
    isGrid = event.isGrid;
    emit(PddListingChangeListingTypeState());
  }

  Future<void> _onFilterPresentationEvent(FilterPresentationEvent event, Emitter<PddListingState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<PddListingState> emit, List<FilterData> appliedFilterData) async {
    emit(PddListLoadingState());
    gridPaginationScrollController.pullToRefresh();
    presentationList.clear();
    filterData = appliedFilterData;
    await fetchPresentationList(context, emit, isLoadMore: false);
    emit(PddListingLoadedState());
  }

  void clearData() {
    isGrid = true;
    presentationSearchController.clear();
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

  /// Build the complete query dynamically
  Map<String, dynamic> buildQuery({
    required List<FilterData> filterData,
    required String searchString,
    required int currentPage,
    required int pageLimit,
  }) {
    Map<String, dynamic> query = {};
    query[ApiKey.filters] = buildFilters(filterData);

    /// Add pagination, search, and sorting parameters
    query.addAll({
      ApiKey.pagination: {ApiKey.page: currentPage, ApiKey.limit: pageLimit},
      ApiKey.search: searchString,
      ApiKey.sort: {
        ApiKey.field: ApiKey.id,
        ApiKey.dir: AppConst.sortValueAsc.toUpperCase(),
      },
    });
    return query;
  }

  /// Fetch digital catalogue data
  Future<void> fetchPresentationList(BuildContext context, Emitter<PddListingState> emit,
      {bool isLoadMore = false, Map<String, dynamic>? query, String searchString = ''}) async {
    /// Build the query dynamically
    query = buildQuery(
      filterData: filterData,
      searchString: presentationSearchController.text,
      currentPage: gridPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<PddDataModel>>? response =
        await AppRepository(context).getPresentationFilters(body: query, isLoadMore: isLoadMore);

    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (PaginationData<PddDataModel> success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      List<PddDataModel> dataList = success.dataList ?? [];
      presentationList.addAll(_populateDigitalCatalogueList(dataList));
      gridPaginationScrollController.isPageLoaded.complete(gridPaginationScrollController.currentPage == totalNumberOfPages);
      emit(PddListingLoadedState());
    });
  }

  /// Populate digital catalogue list
  List<B2BCustomListingDataModel> _populateDigitalCatalogueList(List<PddDataModel> dataList) {
    return dataList.map((data) {
      return B2BCustomListingDataModel(
        id: data.sId ?? '',
        strPresentationNumber: data.presentationNumber ?? '',
        strProject: data.totalProjects.toString(),
        strConceptName: data.conceptName ?? '',
        status: data.projectStatus,
        strCreatedBy: data.createdByDetails?.fullName ?? '',
        strCreatedByImageUrl: data.createdByDetails?.profilePicUrl?.setMediaUrl ?? '',
        strCreatedOn: data.createdAt?.changeDateFormat(
            inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ, outputDateFormat: DateFormatter.dateFormatDDMMMYYYY),
        strAssignTo: data.assignedToDetails?.first.fullName,
        strAssignToImageUrl: data.assignedToDetails?.first.profilePicUrl?.setMediaUrl ?? '',
        strApprovedBy: data.approvedByDetails?.fullName ?? '',
        strApprovedByImageUrl: data.approvedByDetails?.profilePicUrl?.setMediaUrl ?? '',
        strConceptNumber: data.conceptNumber ?? "",
        strPresentationImageUrl: data.image,
      );
    }).toList();
  }

  void _navigateToPreview(NavigateToPddPreviewEvent event, Emitter<PddListingState> emit) {
    final presentationNumber = presentationList[event.index].strPresentationNumber;
    event.context.pushNamed(AppRoutes.presentationPreviewPage, arguments: {
      RoutesData.presentationId: presentationNumber,
    });
  }

  Future<void> _onPddListLoadMoreEvent(PddListLoadMoreEvent event, Emitter<PddListingState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onPddListPullToRefresh(PddListPullToRefreshEvent event, Emitter<PddListingState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<PddListingState> emit) async {
    emit(PddListLoadingState());
    gridPaginationScrollController.pullToRefresh();
    presentationList.clear();
    await fetchPresentationList(context, emit, isLoadMore: false);
    emit(PddListingLoadedState());
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<PddListingState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(PddListLoadingMoreState());
      await fetchPresentationList(context, emit, isLoadMore: false);
      emit(PddListLoadedMoreState(currentPage));
    }
  }
}
