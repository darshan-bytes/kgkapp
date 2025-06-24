import 'package:kgk/kgk.dart';

part 'concept_list_event.dart';

part 'concept_list_state.dart';

class ConceptListBloc extends Bloc<ConceptListEvent, ConceptListState> {
  /// This searchController is used to store the search text
  TextEditingController searchController = TextEditingController();

  /// This conceptModelList is used to store the concept model list
  List<ConceptModel> conceptModelList = [];
  List<B2BCustomListingDataModel> conceptList = [];

  /// This paginationScrollController is used to handle the pagination
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// This totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  ConceptListBloc() : super(ConceptListInitial()) {
    on<ConceptListInitialEvent>(_onConceptListInitialEvent);
    on<ConceptListLoadMoreEvent>(_onConceptListLoadMoreEvent);
    on<ConceptListPullToRefreshEvent>(_onConceptListingPullToRefresh);
    on<ConceptListFilterEvent>(_onConceptListingFilterEvent);
    on<ConceptListSearchEvent>(_onConceptListSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void _onConceptListInitialEvent(ConceptListInitialEvent event, Emitter<ConceptListState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onConceptListLoadMoreEvent(ConceptListLoadMoreEvent event, Emitter<ConceptListState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onConceptListingFilterEvent(ConceptListFilterEvent event, Emitter<ConceptListState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  Future<void> _onConceptListingPullToRefresh(ConceptListPullToRefreshEvent event, Emitter<ConceptListState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<ConceptListState> emit, List<FilterData> appliedFilterData) async {
    emit(ConceptListLoadingState());
    paginationScrollController.pullToRefresh();
    conceptList.clear();
    filterData = appliedFilterData;
    await apiCallForConceptList(context, emit, isLoadMore: false);
    emit(ConceptListLoadedState());
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<ConceptListState> emit) async {
    emit(ConceptListLoadingState());
    _initializePagination(context);
    _fetchFilterData(context, emit);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await apiCallForConceptList(context, emit, isLoadMore: true);
    }
    emit(const ConceptListLoadedState());
  }

  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ConceptListLoadMoreEvent(context, currentPage));
      },
    );
  }

  void _fetchFilterData(BuildContext context, Emitter<ConceptListState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);

      ///Here we will add the wishlist sort and filter data using this event in wishlist filter bloc
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
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

  Future<void> apiCallForConceptList(
    BuildContext context,
    Emitter<ConceptListState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
    String? searchString,
  }) async {
    query = buildQuery(
      filterData: filterData,
      searchString: searchString ?? searchController.text.trim(),
      currentPage: paginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<ConceptModel>>? response = await AppRepository(
      context,
    ).getConceptList(body: query, isShowLoader: isLoadMore);

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (PaginationData<ConceptModel> success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        List<ConceptModel> dataList = success.dataList ?? [];
        conceptList.addAll(_generateB2BListingModel(dataList));
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
        emit(ConceptListLoadedState());
      },
    );
  }

  Future<void> _onConceptListSearchEvent(ConceptListSearchEvent event, Emitter<ConceptListState> emit) async {
    emit(ConceptListLoadingState());
    paginationScrollController.pullToRefresh();
    conceptList.clear();
    await apiCallForConceptList(event.context, emit, isLoadMore: false);
    emit(ConceptListLoadedState());
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<ConceptListState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(ConceptListLoadingState());
      await apiCallForConceptList(context, emit, isLoadMore: false);
      emit(ConceptListLoadedMoreState(currentPage));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<ConceptListState> emit) async {
    emit(ConceptListLoadingState());
    paginationScrollController.pullToRefresh();
    conceptList.clear();
    await apiCallForConceptList(context, emit, isLoadMore: true);
    emit(ConceptListLoadedState());
  }

  List<B2BCustomListingDataModel> _generateB2BListingModel(List<ConceptModel> conceptModelList) {
    return conceptModelList.map((concept) {
      // Use map and spread operator for cleaner list transformation
      List<String> dummy = concept.files.map((file) => file['path'].toString().setMediaUrl).toList();
      return B2BCustomListingDataModel(
        id: concept.id,
        strConceptNumber: concept.conceptNumber,
        strPresentation: concept.presentationCount.toString(),
        strConceptName: concept.conceptName,
        status: concept.status != null ? getOrderStatus(orderStatus: concept.status!) : null,
        fields: generateB2BItemFields(concept.assignedToDetails),
        strCreatedBy: concept.createdByDetails?.fullName,
        strCreatedByImageUrl: concept.createdByDetails?.profilePicUrl?.setMediaUrl,
        strCreatedOn: concept.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
        strPresentationNumber: concept.presentationCount.toString(),
        strConceptBy: concept.conceptCustomerIdDetails?.userType?.capitalizeFirst,
        strName: concept.conceptCustomerIdDetails?.fullName,
        strDescription: concept.description ?? '',
        descriptionImageList: dummy,
        presentationList: concept.presentation,
        strRevisedDate: concept.receivedAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYY),
      );
    }).toList();
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

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).getConceptFilterList();
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

  Future<void> handleViewAllPresentationTap(BuildContext context, int index) async {
    final result = await context.pushNamed(
      AppRoutes.presentationPage,
      arguments: {RoutesData.presentationList: conceptList[index].presentationList},
    );

    if (result != null && result[RoutesData.isNeedToReloadListOnBack] == true && context.mounted) {
      add(ConceptListPullToRefreshEvent(context: context));
    }
  }
}
