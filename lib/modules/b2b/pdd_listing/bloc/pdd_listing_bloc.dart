import 'package:kgk/kgk.dart';

part 'pdd_listing_event.dart';

part 'pdd_listing_state.dart';

class PddListingBloc extends Bloc<PddListingEvent, PddListingState> {
  bool isGrid = false;
  final TextEditingController presentationSearchController = TextEditingController();
  List<B2BCustomListingDataModel> presentationList = [];
  List<PddDataModel> pddList = [];

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
    on<PddListReviewStateEvent>(_onPddListReviewStateEvent);
    on<PddListSearchEvent>(_onPddListSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<PddListDeleteEvent>(_onPddListDeleteEvent);
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

  Future<void> _onPddListReviewStateEvent(PddListReviewStateEvent event, Emitter<PddListingState> emit) async {
    emit(PddListingReloadState());
    await apiCallForPresentationStatus(
      emit,
      context: event.context,
      presentationNumber: event.presentationNumber,
      isApproved: event.isApproved,
    );
    emit(PddListingLoadedState());
  }

  Future<void> apiCallForPresentationStatus(
    Emitter<PddListingState> emit, {
    required BuildContext context,
    required String presentationNumber,
    required bool isApproved,
  }) async {
    emit(PddListingReloadState());

    Map<String, dynamic> body = {ApiKey.presentationNumber: presentationNumber, ApiKey.status: ApiKey.approved};
    Either<ErrorResponse, CommonResponse>? response = await AppRepository(context).apiCallForPresentationStatus(body: body);
    response?.fold(
      (l) {
        if (l.code == 403) {
          Utils.showMessage(l.message);
        }
      },
      (r) {
        Presentation presentation = Presentation.fromJson(r.responseData);
        presentationList[presentationList.indexWhere((element) => element.strPresentationNumber == presentation.presentationNumber)]
            .status = getOrderStatus(orderStatus: presentation.status!);
        Utils.showMessage(r.message);
        emit(PddListingLoadedState());
      },
    );
    context.pop();
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
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (AdvanceFilterOptionModel success) {
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
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
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
      ApiKey.sort: {ApiKey.field: ApiKey.createdAt, ApiKey.dir: AppConst.sortValueDesc.toUpperCase()},
    });
    return query;
  }

  /// Fetch digital catalogue data
  Future<void> fetchPresentationList(
    BuildContext context,
    Emitter<PddListingState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
    String searchString = '',
  }) async {
    /// Build the query dynamically
    query = buildQuery(
      filterData: filterData,
      searchString: presentationSearchController.text,
      currentPage: gridPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<PddDataModel>>? response = await AppRepository(
      context,
    ).getPresentationFilters(body: query, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (PaginationData<PddDataModel> success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        List<PddDataModel> dataList = success.dataList ?? [];
        pddList.addAll(dataList);
        presentationList.addAll(_populateDigitalCatalogueList(dataList));
        gridPaginationScrollController.isPageLoaded.complete(gridPaginationScrollController.currentPage == totalNumberOfPages);
        emit(PddListingLoadedState());
      },
    );
  }

  ProjectStatus getOrderStatus({required String orderStatus}) {
    switch (orderStatus) {
      case "approved":
        return ProjectStatus.approved;
      case "pending":
        return ProjectStatus.pending;
      case "completed":
        return ProjectStatus.completed;
      case "cancelled":
        return ProjectStatus.cancelled;
      case "in_progress":
        return ProjectStatus.orangeInProgress;
      default:
        return ProjectStatus.pending;
    }
  }

  /// Populate digital catalogue list
  List<B2BCustomListingDataModel> _populateDigitalCatalogueList(List<PddDataModel> dataList) {
    return dataList.map((data) {
      String? formatName(UserIdDetails? details) {
        if (details == null || details.fullName.isNullOrEmpty) return null;
        return details.fullName;
      }

      return B2BCustomListingDataModel(
        id: data.id ?? '',
        strPresentationNumber: data.presentationNumber ?? '',
        strProject: data.totalProjects?.toString() ?? '0',
        strConceptName: data.conceptName ?? '',
        status: data.status != null ? getOrderStatus(orderStatus: data.status!) : null,
        strCreatedBy: formatName(data.createdByDetails),
        strCreatedByImageUrl: data.createdByDetails.profilePicUrl?.setMediaUrl ?? '',
        strCreatedOn: data.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
        strApprovedBy: formatName(data.approvedByDetails),
        strApprovedByImageUrl: data.approvedByDetails.profilePicUrl?.setMediaUrl ?? '',
        strConceptNumber: data.conceptNumber ?? '',
        strPresentationImageUrl: data.coverImage?.setMediaUrl ?? '',
        fields: generateB2BItemFields(data.assignedToDetails),
      );
    }).toList();
  }

  List<B2BItemField> generateB2BItemFields(List<UserIdDetails>? assignedToDetails) {
    if (assignedToDetails == null || assignedToDetails.isEmpty) {
      return [];
    }

    return assignedToDetails.map((detail) {
      String fullName = detail.fullName;
      String imageUrl = detail.profilePicUrl?.setMediaUrl ?? '';

      return B2BItemField(label: APPStrings.assignTo.tr, value: fullName, imageUrl: imageUrl);
    }).toList();
  }

  void _navigateToPreview(NavigateToPddPreviewEvent event, Emitter<PddListingState> emit) {
    final presentationNumber = presentationList[event.index].strPresentationNumber;
    event.context.pushNamed(AppRoutes.presentationPreviewPage, arguments: {RoutesData.presentationId: presentationNumber});
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

  Future<void> _onPddListDeleteEvent(PddListDeleteEvent event, Emitter<PddListingState> emit) async {
    emit(PddListingReloadState());
    Either<ErrorResponse, CommonResponse>? response = await AppRepository(
      event.context,
    ).deletePresentationByPresentationNumber(presentationNumber: event.presentationNumber);
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        presentationList.removeWhere((element) => element.strPresentationNumber == event.presentationNumber);
        event.context.pop();
        Utils.showMessage(r.message);
        emit(PddListingLoadedState());
      },
    );
  }
}
