import 'package:kgk/kgk.dart';

part 'sku_library_event.dart';

part 'sku_library_state.dart';

class SkuLibraryBloc extends Bloc<SkuLibraryEvent, SkuLibraryState> {
  late AppBloc _appBloc;

  /// The type of user, defaults to B2C user.
  UserType userType = UserType.b2cUser;

  /// Determines if the view is in grid mode; defaults to true.
  bool isGrid = true;

  /// List to hold the SKU library data.
  List<B2BCustomListingDataModel> skuLibraryList = [];

  /// The total number of pages for pagination.
  int? totalNumberOfPages;

  /// Controller for handling search input in the SKU library.
  final TextEditingController skuSearchController = TextEditingController();

  /// Controller to manage pagination and loading of more items.
  final SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// Variables to hold the current sort key and value.
  String sortKey = AppConst.sortKeyNERPBS;
  String sortValue = AppConst.sortValueDesc;

  /// List to hold the available sort options.
  List<SortOptions> sortOptions = [];

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  SkuLibraryBloc() : super(const SkuLibraryInitial()) {
    on<SkuLibraryInitialEvent>(_onSkuLibraryInitialEvent);
    on<SkuLibraryLoadMoreEvent>(_onSkuLibraryLoadMoreEvent);
    on<SkuLibraryChangeListingTypeEvent>(_onSkuLibraryChangeListingTypeEvent);
    on<SkuLibraryPullToRefreshEvent>(_onSkuLibraryPullToRefresh);
    on<SkuLibrarySortEvent>(_onSkuLibrarySortEvent);
    on<SkuLibraryFilterEvent>(_onSkuLibraryFilterEvent);
  }

  /// Disposes resources when the bloc is closed.
  @override
  Future<void> close() {
    skuSearchController.dispose();
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> _onSkuLibraryInitialEvent(SkuLibraryInitialEvent event, Emitter<SkuLibraryState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onSkuLibraryLoadMoreEvent(SkuLibraryLoadMoreEvent event, Emitter<SkuLibraryState> emit) async {
    await _handleLoadMore(emit: emit, context: event.context, currentPage: event.currentPage);
  }

  Future<void> _onSkuLibraryPullToRefresh(SkuLibraryPullToRefreshEvent event, Emitter<SkuLibraryState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onSkuLibraryChangeListingTypeEvent(SkuLibraryChangeListingTypeEvent event, Emitter<SkuLibraryState> emit) async {
    _handleChangeListingType(emit: emit, isGridValue: event.isGrid);
  }

  Future<void> _onSkuLibrarySortEvent(SkuLibrarySortEvent event, Emitter<SkuLibraryState> emit) async {
    await _handleApplySort(context: event.context, emit: emit, sortOption: event.sortData);
  }

  Future<void> _onSkuLibraryFilterEvent(SkuLibraryFilterEvent event, Emitter<SkuLibraryState> emit) async {
    await _handleApplyFilter(context: event.context, emit: emit, appliedFilterData: event.filterData);
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<SkuLibraryState> emit) async {
    emit(SkuLibraryLoadingState());
    _appBloc = BlocProvider.of<AppBloc>(context);
    userType = _appBloc.userType;
    await _initializeSortOptions(context);
    BlocProvider.of<SortFilterBloc>(context).add(InitialSortFilterEvent(sortOptions: sortOptions));
    _initializePagination(context);
    await _loadFilterData(context: context, emit: emit);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await _callSkuLibraryApi(context: context, emit: emit);
    }
    emit(SkuLibraryLoadedState());
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(SkuLibraryLoadMoreEvent(context: context, currentPage: currentPage));
      },
    );
  }

  /// Initialize sort options
  Future<void> _initializeSortOptions(BuildContext context) async {
    List<SortOptions> sortOptionsList = await StorageManager().getSortingList(Commodity.skuLibrary.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
    }
  }

  /// Fetches data from the SKU library API.
  Future<void> _callSkuLibraryApi({required BuildContext context, required Emitter<SkuLibraryState> emit}) async {
    final Map<String, dynamic> params = {
      ApiKey.limit: AppConst.pageLimit,
      ApiKey.page: paginationScrollController.currentPage,
      ApiKey.sortKey: sortKey,
      ApiKey.sortValue: sortValue,
    };

    Either<ErrorResponse, PaginationData<SkuLibraryListItemDataModel>>? response = await AppRepository(
      context,
    ).getSkuLibraryList(query: params);

    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (success) {
        totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
        final localList = success.dataList ?? [];
        skuLibraryList.addAll(localList.map((e) => convertToB2BCustomListingDataModel(sourceModel: e)).toList());
      },
    );
    paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
    emit(const SkuLibraryLoadedState());
  }

  /// Converts API response data to the custom listing data model.
  B2BCustomListingDataModel convertToB2BCustomListingDataModel({required SkuLibraryListItemDataModel sourceModel}) {
    return B2BCustomListingDataModel(
      id: sourceModel.suid,
      strDesignListingImageUrl:
          (sourceModel.multipleFinishedViewImage).isNotNullNorEmpty ? sourceModel.multipleFinishedViewImage.firstOrNull?.imageUrl : '',
      strDesignNumber: sourceModel.contractNumber,
      strDbfNumber: sourceModel.productDescription,
      strCarats: sourceModel.crt.isNotNullNorEmpty ? "${sourceModel.crt} ${APPStrings.crt.tr}" : null,
      strGrams: sourceModel.gms.isNotNullNorEmpty ? "${sourceModel.gms} ${APPStrings.grms.tr}" : null,
      tagImagePath: getTagImagePath(sourceModel),
    );
  }

  /// Handles loading more items in the SKU library.
  Future<void> _handleLoadMore({required BuildContext context, required Emitter<SkuLibraryState> emit, required int currentPage}) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(SkuLibraryLoadingMoreState());
      await _callSkuLibraryApi(context: context, emit: emit);
      emit(SkuLibraryLoadedMoreState(currentPage: currentPage));
    }
  }

  /// Handles changing the listing view type (grid or list).
  void _handleChangeListingType({required Emitter<SkuLibraryState> emit, required bool isGridValue}) async {
    emit(const SkuLibraryReloadState());
    isGrid = isGridValue;
    emit(const SkuLibraryChangeListingTypeState());
  }

  /// Handles pull-to-refresh functionality to reload data.
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<SkuLibraryState> emit) async {
    emit(const SkuLibraryLoadingState());
    paginationScrollController.pullToRefresh();
    skuLibraryList.clear();
    await _callSkuLibraryApi(context: context, emit: emit);
    emit(const SkuLibraryLoadedState());
  }

  /// Handles applying a filter to the SKU library.
  Future<void> _handleApplyFilter({
    required BuildContext context,
    required Emitter<SkuLibraryState> emit,
    required List<FilterData> appliedFilterData,
  }) async {
    emit(const SkuLibraryLoadingState());
    paginationScrollController.pullToRefresh();
    skuLibraryList.clear();
    filterData = appliedFilterData;
    await _callSkuLibraryApi(context: context, emit: emit);
    emit(const SkuLibraryLoadedState());
  }

  Future<void> _loadFilterData({required BuildContext context, required Emitter<SkuLibraryState> emit}) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
    }
  }

  /// Handles applying a sort to the SKU library.
  Future<void> _handleApplySort({
    required BuildContext context,
    required Emitter<SkuLibraryState> emit,
    required SortOptions sortOption,
  }) async {
    sortKey = sortOption.sortKey ?? "";
    sortValue = sortOption.sortValue ?? "";
    await _handlePullToRefresh(context, emit);
  }

  Future<void> onTapSortOption(BuildContext context) async {
    final result = await Utils.showSmartModalBottomSheet(context: context, builder: (context) => SortScreen(sortData: sortOptions));

    if (result != null) {
      add(SkuLibrarySortEvent(context: context, sortData: result[RoutesData.sortData]));
    }
  }

  Future<void> _setupFilters(BuildContext context) async {
    final List<FilterOptionModel> tempFilterData = await BlocProvider.of<AppBloc>(
      context,
    ).getFilterOptionList(context, AppConst.skuLibrary);
    filterData.clear();
    for (FilterOptionModel filterOption in tempFilterData) {
      FilterData filter = FilterData(
        name: filterOption.name,
        code: filterOption.slug,
        inputType: filterOption.inputType,
        filterType: filterOption.filterType,
        subFilterCodes: filterOption.data.map((e) => e.toString()).join(','),
        secondaryFilterData: [],
      );
      if (!filterOption.fromCommon) {
        filter.secondaryFilterData = filterOption.data.map((e) => SecondaryFilterData(name: e.toString(), code: e.toString())).toList();
      } else if (filterOption.filterType == FilterType.boolean) {
        filter.secondaryFilterData = [SecondaryFilterData(name: filterOption.name)];
      }
      if (filter.filterType == FilterType.range && filterOption.data.isNotEmpty) {
        filter.minMaxValues = SfRangeValues(0, filterOption.data.lastOrNull?.toString().toDouble ?? 0);
      }
      filterData.add(filter);
    }
  }

  String getTagImagePath(SkuLibraryListItemDataModel sourceModel) {
    String tagImagePath = '';
    final String languageCode = _appBloc.locale.languageCode;
    if (sourceModel.exclusive?.toLowerCase() == 'yes') {
      tagImagePath = AppImages.icExclusiveLabel(languageCode);
    }
    return tagImagePath;
  }
}
