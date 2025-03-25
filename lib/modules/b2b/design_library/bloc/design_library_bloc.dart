import 'package:kgk/kgk.dart';

part 'design_library_event.dart';

part 'design_library_state.dart';

class DesignLibraryBloc extends Bloc<DesignLibraryEvent, DesignLibraryState> {
  /// The type of user, defaults to B2C user.
  UserType userType = UserType.b2cUser;

  /// Determines if the view is in grid mode; defaults to true.
  bool isGrid = true;

  /// List to hold the design library data.
  List<B2BCustomListingDataModel> designLibraryList = [];

  /// The total number of pages for pagination.
  int? totalNumberOfPages;

  /// The total number of filtered records
  int? totalFilteredRecords;

  /// Controller for handling search input in the design library.
  final TextEditingController designSearchController = TextEditingController();

  /// Controller to manage pagination and loading of more items.
  final SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// Variables to hold the current sort key and value.
  String sortKey = AppConst.sortKeyNERPBS;
  String sortValue = AppConst.sortValueDesc;

  /// List to hold the available sort options.
  List<SortOptions> sortOptions = [];

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  DesignLibraryBloc() : super(const DesignLibraryInitial()) {
    on<DesignLibraryInitialEvent>(_onDesignLibraryInitialEvent);
    on<DesignLibraryLoadMoreEvent>(_onDesignLibraryLoadMoreEvent);
    on<DesignLibraryChangeListingTypeEvent>(_onDesignLibraryChangeListingTypeEvent);
    on<DesignLibraryPullToRefreshEvent>(_onDesignLibraryPullToRefresh);
    on<DesignLibrarySortEvent>(_onDesignLibrarySortEvent);
    on<DesignLibraryFilterEvent>(_onDesignLibraryFilterEvent);
  }

  /// Disposes resources when the bloc is closed.
  @override
  Future<void> close() {
    designSearchController.dispose();
    paginationScrollController.dispose();
    return super.close();
  }

  Future<void> _onDesignLibraryInitialEvent(DesignLibraryInitialEvent event, Emitter<DesignLibraryState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onDesignLibraryLoadMoreEvent(DesignLibraryLoadMoreEvent event, Emitter<DesignLibraryState> emit) async {
    await _handleLoadMore(emit: emit, context: event.context, currentPage: event.currentPage);
  }

  Future<void> _onDesignLibraryPullToRefresh(DesignLibraryPullToRefreshEvent event, Emitter<DesignLibraryState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onDesignLibraryChangeListingTypeEvent(DesignLibraryChangeListingTypeEvent event, Emitter<DesignLibraryState> emit) async {
    _handleChangeListingType(emit: emit, isGridValue: event.isGrid);
  }

  Future<void> _onDesignLibrarySortEvent(DesignLibrarySortEvent event, Emitter<DesignLibraryState> emit) async {
    await _handleApplySort(context: event.context, emit: emit, sortOption: event.sortData);
  }

  Future<void> _onDesignLibraryFilterEvent(DesignLibraryFilterEvent event, Emitter<DesignLibraryState> emit) async {
    await _handleApplyFilter(context: event.context, emit: emit, appliedFilterData: event.filterData);
  }

  /// Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<DesignLibraryState> emit) async {
    emit(DesignLibraryLoadingState());
    userType = BlocProvider.of<AppBloc>(context).userType;
    await _initializeSortOptions(context);
    BlocProvider.of<SortFilterBloc>(context).add(InitialSortFilterEvent(sortOptions: sortOptions));
    _initializePagination(context);
    await _loadFilterData(context: context, emit: emit);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await _callDesignLibraryApi(context: context, emit: emit);
    }
    emit(DesignLibraryLoadedState());
  }

  /// Initialize pagination
  void _initializePagination(BuildContext context) {
    /// Initializes the pagination controller with a load action.
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(DesignLibraryLoadMoreEvent(context: context, currentPage: currentPage));
      },
    );
  }

  /// Initialize sort options
  Future<void> _initializeSortOptions(BuildContext context) async {
    List<SortOptions> sortOptionsList = await StorageManager().getSortingList(Commodity.designLibrary.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
    }
  }

  /// Fetches data from the design library API.
  Future<void> _callDesignLibraryApi({required BuildContext context, required Emitter<DesignLibraryState> emit}) async {
    final Map<String, dynamic> params = {
      ApiKey.limit: AppConst.pageLimit,
      ApiKey.page: paginationScrollController.currentPage,
      ApiKey.sortKey: sortKey,
      ApiKey.sortValue: sortValue,
    };

    /// Makes the API request and handles the response.
    Either<ErrorResponse, PaginationData<DesignLibraryListItemDataModel>>? response =
        await AppRepository(context).getDesignLibraryList(query: params);

    response?.fold((error) {
      if (error.message.isNotNullNorEmpty) {
        Utils.showMessage(error.message);
      }
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);

      /// Show the total number of records in the UI side
      totalFilteredRecords = success.filteredRecords;
      final localList = success.dataList ?? [];
      designLibraryList.addAll(localList.map((e) => convertToB2BCustomListingDataModel(sourceModel: e)).toList());
    });
    paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
    emit(const DesignLibraryLoadedState());
  }

  /// Converts API response data to the custom listing data model.
  B2BCustomListingDataModel convertToB2BCustomListingDataModel({required DesignLibraryListItemDataModel sourceModel}) {
    return B2BCustomListingDataModel(
      id: sourceModel.suid,
      strDesignListingImageUrl: (sourceModel.images).isNotNullNorEmpty ? sourceModel.images?.first : '',
      strDesignNumber: sourceModel.contractNoSkuNo ?? "",
      strDbfNumber: sourceModel.designDescription,
    );
  }

  /// Handles loading more items in the design library.
  Future<void> _handleLoadMore({required BuildContext context, required Emitter<DesignLibraryState> emit, required int currentPage}) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(DesignLibraryLoadingMoreState());
      await _callDesignLibraryApi(context: context, emit: emit);
      emit(DesignLibraryLoadedMoreState(currentPage: currentPage));
    }
  }

  /// Handles changing the listing view type (grid or list).
  void _handleChangeListingType({required Emitter<DesignLibraryState> emit, required bool isGridValue}) async {
    emit(const DesignLibraryReloadState());
    isGrid = isGridValue;
    emit(const DesignLibraryChangeListingTypeState());
  }

  /// Handles pull-to-refresh functionality to reload data.
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<DesignLibraryState> emit) async {
    emit(const DesignLibraryLoadingState());
    paginationScrollController.pullToRefresh();
    designLibraryList.clear();
    await _callDesignLibraryApi(context: context, emit: emit);
    emit(const DesignLibraryLoadedState());
  }

  /// Handles applying a filter to the design library.
  Future<void> _handleApplyFilter(
      {required BuildContext context, required Emitter<DesignLibraryState> emit, required List<FilterData> appliedFilterData}) async {
    emit(const DesignLibraryLoadingState());
    paginationScrollController.pullToRefresh();
    designLibraryList.clear();
    filterData = appliedFilterData;
    await _callDesignLibraryApi(context: context, emit: emit);
    emit(const DesignLibraryLoadedState());
  }

  Future<void> _loadFilterData({required BuildContext context, required Emitter<DesignLibraryState> emit}) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
    }
  }

  /// Handles applying a sort to the design library.
  Future<void> _handleApplySort({
    required BuildContext context,
    required Emitter<DesignLibraryState> emit,
    required SortOptions sortOption,
  }) async {
    sortKey = sortOption.sortKey ?? "";
    sortValue = sortOption.sortValue ?? "";
    await _handlePullToRefresh(context, emit);
  }

  Future<void> onTapSortOption(BuildContext context) async {
    final result = await Utils.showSmartModalBottomSheet(
      context: context,
      builder: (context) => SortScreen(sortData: sortOptions),
    );

    if (result != null) {
      add(DesignLibrarySortEvent(context: context, sortData: result[RoutesData.sortData]));
    }
  }

  Future<void> _setupFilters(BuildContext context) async {
    final List<FilterOptionModel> tempFilterData =
        await BlocProvider.of<AppBloc>(context).getFilterOptionList(context, AppConst.designLibrary);
    filterData.clear();
    for (FilterOptionModel filterOption in tempFilterData) {
      if (filterOption.data.isNotEmpty) {
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
          if (filterOption.data.isNotEmpty && filterOption.data.any((element) => element?.toString().toLowerCase() == 'yes')) {
            filter.secondaryFilterData = [SecondaryFilterData(name: filterOption.name)];
          } else {
            continue;
          }
        } else if (filter.filterType == FilterType.range && filterOption.data.isNotEmpty) {
          filter.minMaxValues = SfRangeValues(0, filterOption.data.lastOrNull?.toString().toDouble ?? 0);
        }
        filterData.add(filter);
      }
    }
  }
}
