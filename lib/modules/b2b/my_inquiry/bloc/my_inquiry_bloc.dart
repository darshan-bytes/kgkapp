import 'package:kgk/kgk.dart';

part 'my_inquiry_event.dart';

part 'my_inquiry_state.dart';

class MyInquiryBloc extends Bloc<MyInquiryEvent, MyInquiryState> {
  //Pagination controller
  SmartPaginationScrollController smartPaginationScrollController = SmartPaginationScrollController();

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  /// totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  List<B2BCustomListingDataModel> myInquiryList = [];

  bool isInitialized = false;

  MyInquiryBloc() : super(MyInquiryInitial()) {
    on<MyInquiryInitialEvent>(_onMyInquiryInitialEvent);
    on<MyInquiryUpdateEvent>(_onMyInquiryUpdateEvent);
    on<MyInquiryRemoveEvent>(_onMyInquiryRemoveEvent);
    on<FilterMyInquiryEvent>(_onFilterMyInquiryEvent);
  }

  /// This function is used to handle the initial event of the bloc
  Future<void> _onMyInquiryInitialEvent(MyInquiryInitialEvent event, Emitter<MyInquiryState> emit) async {
    if (isInitialized) return;
    emit(MyInquiryReloadState());
    isInitialized = true;

    _initializePagination(event.context);
    _fetchFilterData(event.context, emit);
    if (totalNumberOfPages == null || smartPaginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchMyInquiries(event.context, emit);
    }
    emit(MyInquiryLoadedState());
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    smartPaginationScrollController.init(
      loadAction: (int currentPage) async {
        add(MyInquiryLoadMoreEvent(currentPage, context));
      },
    );
  }

  /// Fetch filter data
  void _fetchFilterData(BuildContext context, Emitter<MyInquiryState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);

      ///Here we will add the wishlist sort and filter data using this event in wishlist filter bloc
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  /// Setup filters
  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).fetchMyInquiryFilterOptionList();
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

  /// Fetch my inquiries from server and populate the list
  /// [isLoadMore] is used to check if the list is to be loaded more or not
  /// [query] is used to pass the query parameters to the server
  Future<void> fetchMyInquiries(
    BuildContext context,
    Emitter<MyInquiryState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
    String searchString = '',
  }) async {
    /// Build the query dynamically
    query = buildQuery(
      filterData: filterData,
      searchString: searchString,
      currentPage: smartPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<MyInquiriesModel>>? response = await AppRepository(
      context,
    ).fetchMyInquiries(body: query, isLoadMore: isLoadMore);
    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (PaginationData<MyInquiriesModel> success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        List<MyInquiriesModel> dataList = success.dataList ?? [];
        myInquiryList.addAll(_populateMyInquiryList(dataList));
        smartPaginationScrollController.isPageLoaded.complete(smartPaginationScrollController.currentPage == totalNumberOfPages);
      },
    );
  }

  /// Populate digital catalogue list
  List<B2BCustomListingDataModel> _populateMyInquiryList(List<MyInquiriesModel> dataList) {
    return dataList.map((data) {
      return B2BCustomListingDataModel(
        strInquiryId: data.id ?? '',
        strType: data.inquiryType ?? '',
        strProduct: data.commodity ?? '',
        strName: data.name ?? '',
        strEmail: data.email ?? '',
        strCreatedOn: data.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2) ?? '',
        status: data.status != null ? getOrderStatus(orderStatus: data.status!) : null,
        fields: generateB2BItemFields(data.assignedToDetails),
      );
    }).toList();
  }

  /// Get order status
  ProjectStatus getOrderStatus({required String orderStatus}) {
    switch (orderStatus.toLowerCase()) {
      case "new":
        return ProjectStatus.newStatus;
      case "open":
        return ProjectStatus.open;
      case "progress":
        return ProjectStatus.progress;
      case "close":
        return ProjectStatus.close;
      default:
        return ProjectStatus.pending;
    }
  }

  /// Generate B2B item fields
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
      ApiKey.sort: {ApiKey.field: ApiKey.id, ApiKey.dir: AppConst.sortValueAsc.toUpperCase()},
    });
    return query;
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

  //_onMyInquiryUpdateEvent
  Future<void> _onMyInquiryUpdateEvent(MyInquiryUpdateEvent event, Emitter<MyInquiryState> emit) async {
    emit(MyInquiryReloadState());
    myInquiryList.clear();
    smartPaginationScrollController.pullToRefresh();
    await fetchMyInquiries(event.context, emit);
    emit(MyInquiryLoadedState());
    smartPaginationScrollController.isPageLoaded.complete(false);
  }

  //_onMyInquiryRemoveEvent
  Future<void> _onMyInquiryRemoveEvent(MyInquiryRemoveEvent event, Emitter<MyInquiryState> emit) async {
    emit(MyInquiryReloadState());

    /// Show confirmation dialog
    await showConfirmationDialog(
      context: event.context,
      title: APPStrings.makeAnInquiry.tr,
      message: APPStrings.removeInquiryMsg.tr,
      index: event.index,
    );
    emit(MyInquiryLoadedState());
  }

  /// showConfirmationDialog
  Future<void> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String message,
    required int index,
  }) async {
    await Utils.showSmartModalBottomSheet(
      context: context,
      builder: (mainContext) {
        return ConfirmationDialog(
          title: title,
          message: message,
          onDeniedText: APPStrings.cancel.tr,
          onApprovedText: APPStrings.remove.tr,
          onDenied: () {
            mainContext.pop();
          },
          onApproved: () async {
            await removeInquiry(context, index, myInquiryList, smartPaginationScrollController);
          },
        );
      },
    );
  }

  /// Clear data
  void clearData() {
    myInquiryList.clear();
    smartPaginationScrollController.pullToRefresh();
    // smartPaginationScrollController.isPageLoaded.complete(false);
  }

  Future<void> removeInquiry(
    BuildContext context,
    int index,
    List<B2BCustomListingDataModel> myInquiryList,
    SmartPaginationScrollController smartPaginationScrollController,
  ) async {
    if (myInquiryList.isEmpty) return;

    context.pop();

    final ids = [myInquiryList[index].strInquiryId ?? ''];
    final params = {ApiKey.ids: ids};

    try {
      final response = await AppRepository(context).removeMyInquiry(body: params);
      response?.fold((error) => Utils.showMessage(error.message), (success) {
        Utils.showMessage(success.message);
        add(MyInquiryUpdateEvent(context));
      });
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }

  Future<void> _onFilterMyInquiryEvent(FilterMyInquiryEvent event, Emitter<MyInquiryState> emit) async {
    emit(MyInquiryReloadState());
    filterData = event.filterData;
    smartPaginationScrollController.pullToRefresh();
    await fetchMyInquiries(event.context, emit, isLoadMore: true);
  }
}
