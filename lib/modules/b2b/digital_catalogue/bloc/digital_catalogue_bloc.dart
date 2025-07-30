import 'package:kgk/kgk.dart';

part 'digital_catalogue_event.dart';

part 'digital_catalogue_state.dart';

enum PopupMenuOption { share, remove }

class DigitalCatalogueBloc extends Bloc<DigitalCatalogueEvent, DigitalCatalogueState> {
  late AppBloc appBloc;

  /// This controller is used to control the search
  final TextEditingController searchController = TextEditingController();

  /// This list is used to show the digital catalogues in screen view
  List<DigitalCatalogueListingModel> digitalCatalogueList = [];

  /// paginationScrollController is used to control the pagination
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// totalNumberOfPages is used to store the total number of pages
  int? totalNumberOfPages;

  /// Focus node is used to control the focus
  FocusNode focusNode = FocusNode();

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  /// This modulePermission is used to store the module permission
  PermissionData? modulePermission;

  DigitalCatalogueBloc() : super(DigitalCatalogueInitial()) {
    on<DigitalCatalogueInitialEvent>(_onInitialDigitalCatalogueEvent);
    on<DigitalCatalogueLoadMoreEvent>(_onLoadMoreDigitalCatalogueEvent);
    on<DigitalCataloguePullToRefreshEvent>(_onDigitalCataloguePullToRefreshEvent);
    on<DigitalCatalogueSearchEvent>(_onDigitalCatalogueSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<DigitalCatalogueFilterEvent>(_onDigitalCatalogueFilterEvent);
    on<DeleteDigitalCatalogueEvent>(_onDeleteDigitalCatalogueEvent);
    on<DigitalCatalogueShareEvent>(_onDigitalCatalogueShareEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> _onInitialDigitalCatalogueEvent(DigitalCatalogueInitialEvent event, Emitter<DigitalCatalogueState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onLoadMoreDigitalCatalogueEvent(DigitalCatalogueLoadMoreEvent event, Emitter<DigitalCatalogueState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onDigitalCataloguePullToRefreshEvent(DigitalCataloguePullToRefreshEvent event, Emitter<DigitalCatalogueState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onDigitalCatalogueFilterEvent(DigitalCatalogueFilterEvent event, Emitter<DigitalCatalogueState> emit) async {
    await _handleApplyFilter(event.context, emit, event.filterData);
  }

  Future<void> _onDeleteDigitalCatalogueEvent(DeleteDigitalCatalogueEvent event, Emitter<DigitalCatalogueState> emit) async {
    await _handleDeleteDigitalCatalogue(event, emit);
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<DigitalCatalogueState> emit) async {
    appBloc = BlocProvider.of<AppBloc>(context);
    emit(DigitalCatalogueLoadingState());
    _fetchModulePermission();
    _initializePagination(context);
    _fetchFilterData(context, emit);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await fetchDigitalCatalogueList(context, emit, isLoadMore: false);
    }
    emit(DigitalCatalogueLoadedState());
  }

  void _fetchFilterData(BuildContext context, Emitter<DigitalCatalogueState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
    }
  }

  void _fetchModulePermission() {
    PermissionData? permission = Utils.getPermissionByModuleName(moduleName: ModuleKey.digitalCatalogue);
    if (permission != null) {
      modulePermission = permission;
    }
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(DigitalCatalogueLoadMoreEvent(context: context, currentPage: currentPage));
      },
    );
  }

  Future<void> _onDigitalCatalogueSearchEvent(DigitalCatalogueSearchEvent event, Emitter<DigitalCatalogueState> emit) async {
    emit(DigitalCatalogueLoadingState());
    paginationScrollController.pullToRefresh();
    digitalCatalogueList.clear();
    await fetchDigitalCatalogueList(event.context, emit, isLoadMore: false, searchString: searchController.text);
    if (searchController.text.isNotNullNorEmpty) focusNode.requestFocus();
    emit(DigitalCatalogueLoadedState());
  }

  /// Build the filters dynamically
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {ApiKey.dynamicObject: {}};

    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[ApiKey.dynamicObject]?[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD, isWithLanguage: false),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD, isWithLanguage: false),
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
  Future<void> fetchDigitalCatalogueList(
    BuildContext context,
    Emitter<DigitalCatalogueState> emit, {
    bool isLoadMore = false,
    Map<String, dynamic>? query,
    String searchString = '',
  }) async {
    /// Build the query dynamically
    query = buildQuery(
      filterData: filterData,
      searchString: searchString,
      currentPage: paginationScrollController.currentPage,
      pageLimit: AppConst.pageLimit,
    );

    Either<ErrorResponse, PaginationData<DigitalCatalogueDetails>>? response = await AppRepository(
      context,
    ).digitalCatalogueFilters(body: query, isLoadMore: isLoadMore);

    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (PaginationData<DigitalCatalogueDetails> success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        List<DigitalCatalogueDetails> dataList = success.dataList ?? [];
        digitalCatalogueList.addAll(_populateDigitalCatalogueList(dataList));
        paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
        emit(DigitalCatalogueLoadedState());
      },
    );
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<DigitalCatalogueState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(DigitalCatalogueLoadingMoreState());
      await fetchDigitalCatalogueList(context, emit, isLoadMore: false);
      emit(DigitalCatalogueLoadMoreState(currentPage: currentPage));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<DigitalCatalogueState> emit) async {
    emit(DigitalCatalogueLoadingState());
    paginationScrollController.pullToRefresh();
    digitalCatalogueList.clear();
    await fetchDigitalCatalogueList(context, emit, isLoadMore: false);
    emit(DigitalCatalogueLoadedState());
  }

  Future<void> _handleApplyFilter(BuildContext context, Emitter<DigitalCatalogueState> emit, List<FilterData> appliedFilterData) async {
    emit(DigitalCatalogueLoadingState());
    paginationScrollController.pullToRefresh();
    digitalCatalogueList.clear();
    filterData = appliedFilterData;
    await fetchDigitalCatalogueList(context, emit, isLoadMore: false);
    emit(DigitalCatalogueLoadedState());
  }

  /// Handle delete digital catalogue
  Future<void> _handleDeleteDigitalCatalogue(DeleteDigitalCatalogueEvent event, Emitter<DigitalCatalogueState> emit) async {
    emit(DigitalCatalogueLoadingState());
    Either<ErrorResponse, CommonResponse>? response = await AppRepository(
      event.context,
    ).deleteDigitalCatalogue(catalogueId: event.catalogueId);
    await response?.fold(
      (error) async {
        Utils.showMessage(error.message);
      },
      (success) {
        if (success.message.isNotNullNorEmpty) {
          Utils.showMessage(success.message);
        }
        digitalCatalogueList.removeWhere((element) => element.id == event.catalogueId);
      },
    );
    emit(DigitalCatalogueLoadedState());
  }

  /// Populate digital catalogue list
  List<DigitalCatalogueListingModel> _populateDigitalCatalogueList(List<DigitalCatalogueDetails> dataList) {
    return dataList.map((data) {
      return DigitalCatalogueListingModel(
        id: data.id,
        name: data.name,
        description: data.cscCode,
        image: data.catalogueCoverImage?.setMediaUrl,
        productCount: data.products.length.toString(),
        date: data.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
        status: ProjectStatus.values.firstWhereOrNull((e) => e.value == data.status?.toLowerCase()),
        isCreatedByMe: data.createdByDetails?.userAccountId?.toString() == StorageManager.instance.getUserId(),
      );
    }).toList();
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response;
    response = await AppRepository(context).fetchDigitalCatalogueFilterOptionList();
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

  Future<void> _onDigitalCatalogueShareEvent(DigitalCatalogueShareEvent event, Emitter<DigitalCatalogueState> emit) async {
    BuildContext context = event.context;
    DigitalCatalogueListingModel digitalCatalogue = digitalCatalogueList[event.index];
    String? link = await BlocProvider.of<AppBloc>(
      context,
    ).handleShareCatalogue(context: context, productDetails: digitalCatalogue, isShowLoading: true);
    if (link != null) {
      Utils.showSmartModalBottomSheet(
        context: context,
        enableDrag: false,
        builder:
            (sheetContext) => ShareOptionSheet(
              title: APPStrings.share.tr,
              onTapQrCode: () async {
                sheetContext.pop();
                Utils.showQrCodeDialog(context: context, data: link);
              },
              onTapCopy: () async {
                await Clipboard.setData(ClipboardData(text: link));
                Utils.showMessage(APPStrings.textCopied.tr);
              },
              onTapOther: () async {
                Utils.onTapShareLink(context: sheetContext, link: link, title: digitalCatalogue.name, imageUrl: digitalCatalogue.image);
              },
            ),
      );
    } else {
      Utils.showMessage(APPStrings.failedToCreateSharingLink.tr);
    }
  }
}
