import 'package:kgk/kgk.dart';

part 'collection_event.dart';

part 'collection_state.dart';

class CollectionBloc extends Bloc<CollectionEvent, CollectionState> {
  /// List of collection master data.
  List<CollectionDataItemsModel> collectionMasterList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// TabController for managing tabs in the UI.
  late TabController tabController;

  /// List of tabs, dynamically populated with months.
  final List<CollectionMonthTab> tabs = <CollectionMonthTab>[];

  /// Completer for refreshing the collection data.
  Completer<bool> refreshCompleter = Completer<bool>();

  /// Total number of pages for pagination.
  int? totalNumberOfPages;

  /// Variables for storing the currently selected month and year.
  int currentMonth = DateTime.now().month;
  int currentYear = DateTime.now().year;
  DateTime selectedDate = DateTime.now();

  /// Constructor for the CollectionBloc.
  CollectionBloc() : super(CollectionInitial()) {
    on<CollectionInitialEvent>(_onInitialEvent);
    on<ChangeCollectionTabsEvent>(_onChangeCollectionTabsEvent);
    on<CollectionListLoadMoreEvent>(_onCollectionListLoadMore);
    on<CollectionListPullToRefreshEvent>(_onCollectionListPullToRefresh);
  }

  /// Handles the CollectionInitialEvent to initialize the collection.
  Future<void> _onInitialEvent(CollectionInitialEvent event, Emitter<CollectionState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// Handles the ChangeCollectionTabsEvent, used for tab selection.
  Future<void> _onChangeCollectionTabsEvent(ChangeCollectionTabsEvent event, Emitter<CollectionState> emit) async {
    await _handleTabSelection(event.context, event.index, emit);
  }

  Future<void> _onCollectionListLoadMore(CollectionListLoadMoreEvent event, Emitter<CollectionState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onCollectionListPullToRefresh(CollectionListPullToRefreshEvent event, Emitter<CollectionState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  /// Initializes the CollectionBloc: generates tabs, initializes pagination, and calls API to load collection data.
  Future<void> _initializeBloc(BuildContext context, Emitter<CollectionState> emit) async {
    emit(CollectionReloadState());
    _initializeTabs();
    _initializePagination(context);
    await _callCollectionListingApi(context: context, isLoadMore: true);
    emit(CollectionMasterListLoadedState());
  }

  /// Initializes month tabs for the last 12 months.
  void _initializeTabs() {
    tabs.clear();
    final currentDate = DateTime.now();
    for (int i = 0; i < AppConst.noOfMonths; i++) {
      final monthDate = currentDate.addMonth(-i);
      tabs.add(
        CollectionMonthTab(
          month: monthDate.month,
          year: monthDate.year,
          child: MonthTabWidget(monthDate: monthDate),
        ),
      );
    }
  }

  /// Initializes pagination for loading more collection data when scrolling.
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(CollectionListLoadMoreEvent(currentPage, context));
      },
    );
  }

  /// Calls the API to fetch the collection master list.
  Future<void> _callCollectionListingApi({required BuildContext context, bool isLoadMore = false}) async {
    if (paginationScrollController.isPageLoaded.isCompleted) {
      paginationScrollController.isPageLoaded = Completer<bool>();
    }

    final Map<String, dynamic> params = {
      ApiKey.page: paginationScrollController.currentPage,
      ApiKey.limit: AppConst.pageLimit,
      ApiKey.month: currentMonth,
      ApiKey.year: currentYear
    };

    Either<ErrorResponse, PaginationData<CollectionDataItemsModel>>? response =
        await AppRepository(context).collectionMasterList(body: params, isLoadMore: isLoadMore);
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (PaginationData<CollectionDataItemsModel> success) {
      if (success.dataList != null) {
        totalNumberOfPages = Utils.calculateTotalPages(success.totalRecords, AppConst.pageLimit);
        final localList = (success.dataList as List<CollectionDataItemsModel>?) ?? [];
        collectionMasterList.addAll(localList);
      }
    });
    if (!paginationScrollController.isPageLoaded.isCompleted) {
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
    }
  }

  Future<void> _handleLoadMore(BuildContext context, Emitter<CollectionState> emit, int currentPage) async {
    emit(CollectionListLoadingMoreState());
    await _callCollectionListingApi(context: context);
    emit(CollectionListLoadedMoreState(currentPage + 1));
  }

  Future<void> _handlePullToRefresh(BuildContext context, Emitter<CollectionState> emit) async {
    emit(CollectionLoadingState());
    final refreshCompleter = Completer<bool>();
    paginationScrollController.pullToRefresh();
    collectionMasterList.clear();
    await _callCollectionListingApi(context: context);
    refreshCompleter.complete(true);
    emit(CollectionMasterListLoadedState());
  }

  Future<void> _handleTabSelection(BuildContext context, int index, Emitter<CollectionState> emit) async {
    /// Check if the selected tab is the same as the current one
    if (tabs[index].month == currentMonth && tabs[index].year == currentYear) return;

    /// Proceed only if the tab selection is different
    emit(CollectionLoadingState());
    paginationScrollController.pullToRefresh();
    collectionMasterList.clear();
    currentMonth = tabs[index].month;
    currentYear = tabs[index].year;
    await _callCollectionListingApi(context: context);
    emit(CollectionMasterListLoadedState());
  }

  /// Navigates to the Jewellery Listing screen with the selected collection name.
  void navigateToJewelleryListingScreen({required String collectionName, required BuildContext context}) {
    context.pushNamed(AppRoutes.productListGridPage,
        arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing, RoutesData.collectionName: collectionName});
  }

  /// Disposes the pagination scroll controller when the bloc is closed.
  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }
}
