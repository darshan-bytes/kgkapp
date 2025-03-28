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
  }

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

  void _fetchFilterData(BuildContext context, Emitter<MyInquiryState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);

      ///Here we will add the wishlist sort and filter data using this event in wishlist filter bloc
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    // ToDo : Get My Inquiery Filter Api Call
    response = await AppRepository(context).fetchMyInquiryFilterOptionList();
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

        print('Filter Data : ${filterData.length}');
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

  Future<void> fetchMyInquiries(BuildContext context, Emitter<MyInquiryState> emit,
      {bool isLoadMore = false, Map<String, dynamic>? query, String searchString = ''}) async {
    /// Build the query dynamically
    query = buildQuery(
      filterData: filterData,
      searchString: searchString,
      currentPage: smartPaginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<MyInquiriesModel>>? response =
        await AppRepository(context).fetchMyInquiries(body: query, isLoadMore: isLoadMore);
    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (PaginationData<MyInquiriesModel> success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      List<MyInquiriesModel> dataList = success.dataList ?? [];
      myInquiryList.addAll(_populateMyInquiryList(dataList));
      smartPaginationScrollController.isPageLoaded.complete(smartPaginationScrollController.currentPage == totalNumberOfPages);
      emit(MyInquiryLoadedState());
    });
  }

  /// Populate digital catalogue list
  List<B2BCustomListingDataModel> _populateMyInquiryList(List<MyInquiriesModel> dataList) {
    return dataList.map((data) {
      return B2BCustomListingDataModel(
        strInquiryId: data.id ?? '',
        strType: data.inquiryType ?? '',
        strProduct: data.commodity ?? '',
        strCreatedOn: data.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA) ?? '',
        status: data.status != null ? getOrderStatus(orderStatus: data.status!) : null,
        fields: generateB2BItemFields(data.assignedToDetails),
      );
    }).toList();
  }

  ProjectStatus getOrderStatus({required String orderStatus}) {
    switch (orderStatus) {
      case "approved":
        return ProjectStatus.approval;
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
      String imageUrl = detail.profilePic ?? '';

      return B2BItemField(
        label: APPStrings.assignTo.tr,
        value: fullName,
        imageUrl: imageUrl,
      );
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
      ApiKey.sort: {
        ApiKey.field: ApiKey.id,
        ApiKey.dir: AppConst.sortValueAsc.toUpperCase(),
      },
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
}
