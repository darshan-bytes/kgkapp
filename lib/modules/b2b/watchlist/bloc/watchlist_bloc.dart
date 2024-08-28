import 'package:kgk/kgk.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  bool isInitialized = false;
  TextEditingController watchlistSearchController = TextEditingController();
  List<B2BCustomListingDataModel> watchListingList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  int? totalNumberOfPages;
  int limit = 10;

  List<WatchlistData> watchlistDataList = [];

  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchlistInitialEvent>(_onWatchlistInitialEvent);
    on<WatchlistLoadMoreEvent>(_onWatchlistLoadMoreEvent);
    on<WatchlistPullToRefreshEvent>(_onWatchlistPullToRefresh);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void _onWatchlistInitialEvent(WatchlistInitialEvent event, Emitter<WatchlistState> emit) async {
    if (isInitialized) return;
    isInitialized = true;
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }

    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    emit(const WatchlistReloadState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(WatchlistLoadMoreEvent(currentPage, event.context));
      },
    );
    watchListingList.clear();
    await fetchWatchlist(event.context, emit, false, 1);
    refreshCompleter.complete(true);
    emit(WatchlistLoadedState());
  }

  void _onWatchlistLoadMoreEvent(WatchlistLoadMoreEvent event, Emitter<WatchlistState> emit) async {
    emit(const WatchlistLoadingMoreState());
    await fetchWatchlist(event.context, emit, true, event.currentPage);
    emit(WatchlistLoadedMoreState(currentPage: event.currentPage + 1));
  }

  Future<void> _onWatchlistPullToRefresh(WatchlistPullToRefreshEvent event, Emitter<WatchlistState> emit) async {
    emit(const WatchlistReloadState());
    paginationScrollController.pullToRefresh();
    watchListingList.clear();
    watchlistDataList.clear();
    await fetchWatchlist(event.context, emit, false, 1);
    refreshCompleter.complete(true);
    emit(WatchlistLoadedState());
  }

  Future<void> fetchWatchlist(BuildContext context, Emitter<WatchlistState> emit, bool? isLoadMore, int currentPage) async {
    if (isLoadMore == true) {
      emit(const WatchlistLoadingMoreState());
    }
    Either<ErrorResponse, PaginationData<WatchlistData>>? response = await AppRepository(context).getWatchList(
      page: currentPage.toString(),
      limit: limit.toString(),
      isLoadMore: isLoadMore ?? false,
    );
    response?.fold(
      (l) {
        Utils.showMessage(l.message ?? "");
      },
      (r) {
        r.totalRecords ??= 0;
        totalNumberOfPages = (r.totalRecords! % limit == 0) ? (r.totalRecords ?? 0) ~/ limit : ((r.totalRecords ?? 0) ~/ limit) + 1;
        List<WatchlistData> dataList = (r.dataList ?? []) as List<WatchlistData>;
        if (currentPage == 1) {
          watchlistDataList.clear();
          watchListingList.clear();
        }
        watchlistDataList.addAll(dataList);

        watchListingList.addAll(dataList.map((e) => B2BCustomListingDataModel(
              id: e.sId ?? "",
              strName: e.name ?? "",
              status: e.displayStatus,
              strFrom: e.createdAt,
              strTo: e.expiresAt,
              strNumberOfProduct: e.products?.length.toString() ?? "0",
              strRemainingTime: e.duration?.displayDuration ?? "",

              /// Below code is commented as it is currently not available in API
              // strConceptNumber: e.strConceptNumber ?? "",
              // strSalesman: e.strSales,
              // strSalesmanImageUrl: e.strSalesmanImageUrl,
            )));
        paginationScrollController.hasNextPage = currentPage < totalNumberOfPages!;
        paginationScrollController.isPageLoaded.complete(currentPage == totalNumberOfPages);
      },
    );
  }

  Future<bool> pullToRefresh({required BuildContext context}) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(WatchlistPullToRefreshEvent(context: context));
    bool result = await refreshCompleter.future;
    return result;
  }

  Future<void> createNewWatchlist(BuildContext context) async {
    BlocProvider.of<EditWatchlistBloc>(context).add(const EditWatchlistInitialEvent(isEdit: false));
    final result = await Utils.showSmartModalBottomSheet(
      context: context,
      enableDrag: false,
      builder: (context) => const EditWatchlistScreen(),
    );

    if (result?[RoutesData.isWatchlistCreated] == true) {
      pullToRefresh(context: context);
    }
  }
}
