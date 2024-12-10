import 'package:kgk/kgk.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  bool isInitialized = false;
  TextEditingController watchlistSearchController = TextEditingController();
  List<B2BCustomListingDataModel> watchListingList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();
  String searchQuery = '';

  int? totalNumberOfPages;

  List<WatchlistData> watchlistDataList = [];
  Completer<List<WatchlistData>> allWatchlistFull = Completer<List<WatchlistData>>();

  Timer? _debounce;

  WatchlistBloc() : super(const WatchlistInitial()) {
    on<WatchlistInitialEvent>(_onWatchlistInitialEvent);
    on<WatchlistLoadMoreEvent>(_onWatchlistLoadMoreEvent);
    on<WatchlistPullToRefreshEvent>(_onWatchlistPullToRefresh);
    on<WatchListCloseEvent>(_onWatchListClose);
    on<WatchListSearchEvent>(_onWatchListSearch);
    on<WatchListDeleteEvent>(_onWatchListDelete);
    on<WatchListLoadFullListEvent>(_onWatchListLoadFullLis);
  }

  @override
  Future<void> close() {
    clearBlocData();
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
    emit(const WatchlistLoadedState());
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
    emit(const WatchlistLoadedState());
  }

  Future<void> fetchWatchlist(BuildContext context, Emitter<WatchlistState> emit, bool? isLoadMore, int currentPage) async {
    if (isLoadMore == true) {
      emit(const WatchlistLoadingMoreState());
    } else {
      emit(const WatchlistLoadingState());
    }
    Either<ErrorResponse, PaginationData<WatchlistData>>? response = await AppRepository(context).getWatchList(
      page: currentPage.toString(),
      limit: AppConst.pageLimit.toString(),
      isLoadMore: isLoadMore ?? false,
      searchQuery: searchQuery,
    );
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        r.totalRecords ??= 0;
        totalNumberOfPages = Utils.calculateTotalPages(r.filteredRecords, AppConst.pageLimit);
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
              strFrom: e.createdAt?.changeDateFormat(
                  outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2, inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ),
              strTo: e.expiresAt?.changeDateFormat(
                  outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2, inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ),
              strNumberOfProduct: e.products?.length.toString() ?? "0",
              strRemainingTime: ValueNotifier<String>(e.duration?.displayDuration ?? ""),

              /// Below code is commented as it is currently not available in API
              // strConceptNumber: e.strConceptNumber ?? "",
              // strSalesman: e.strSales,
              // strSalesmanImageUrl: e.strSalesmanImageUrl,
            )));
        paginationScrollController.hasNextPage = currentPage < totalNumberOfPages!;
        paginationScrollController.isPageLoaded.complete(currentPage == totalNumberOfPages);
        if (currentPage == 1) {
          startTimerForDurationDecrement();
        }
      },
    );
  }

  void startTimerForDurationDecrement() {
    //TODO: Implement timer for decrementing the duration, Need to discuss with JD for the same
    // timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   for (int i = 0; i < watchlistDataList.length; i++) {
    //     if (watchlistDataList[i].duration?.seconds != null) {
    //       watchlistDataList[i].duration!.seconds = watchlistDataList[i].duration!.seconds! - 1;
    //       watchListingList[i].strRemainingTime.value = watchlistDataList[i].duration?.displayDuration ?? "";
    //     }
    //   }
    // });
  }

  Future<bool> pullToRefresh({required BuildContext context}) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    paginationScrollController.pullToRefresh();
    refreshCompleter = Completer<bool>();
    resetAllWatchlistFull();
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

  void _onWatchListClose(WatchListCloseEvent event, Emitter<WatchlistState> emit) {
    clearBlocData();
    emit(const WatchlistInitial());
  }

  FutureOr<void> _onWatchListSearch(WatchListSearchEvent event, Emitter<WatchlistState> emit) {
    pullToRefresh(context: event.context);
  }

  void searchListener(BuildContext context) {
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 300), () {
      searchQuery = watchlistSearchController.text;
      add(WatchListSearchEvent(searchQuery, context));
    });
  }

  void clearBlocData() {
    isInitialized = false;
    paginationScrollController.dispose();
    paginationScrollController = SmartPaginationScrollController();
    watchListingList.clear();
    watchlistDataList.clear();
    refreshCompleter = Completer<bool>();
    watchlistSearchController.clear();
    _debounce?.cancel();
  }

  Future<void> _onWatchListDelete(WatchListDeleteEvent event, Emitter<WatchlistState> emit) async {
    if (watchlistDataList.isEmpty || event.watchlistId == null) return;
    emit(const WatchlistReloadState());
    int index = watchlistDataList.indexWhere((element) => element.sId == event.watchlistId);
    Either<ErrorResponse, CommonResponse>? response = await AppRepository(event.context).deleteWatchList(watchlistDataList[index].sId!);
    await response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        event.context.pop();
        await Future.delayed(const Duration(milliseconds: 500));
        if (watchlistDataList.length == 1) {
          if (event.screenContext.mounted) {
            await pullToRefresh(context: event.screenContext);
          }
        } else if (watchlistDataList.length > 1) {
          watchlistDataList.removeAt(index);
          watchListingList.removeAt(index);
        }
        emit(const WatchlistDeleteState());
        if (r.message != null) {
          Utils.showMessage(r.message);
        }
      },
    );
  }

  void resetAllWatchlistFull() {
    allWatchlistFull = Completer<List<WatchlistData>>();
  }

  Future<void> _onWatchListLoadFullLis(WatchListLoadFullListEvent event, Emitter<WatchlistState> emit) async {
    if (allWatchlistFull.isCompleted) {
      allWatchlistFull = Completer<List<WatchlistData>>();
    }
    Either<ErrorResponse, PaginationData<WatchlistData>>? response = await AppRepository(event.context).getWatchList(
      page: "1",
      limit: AppConst.pageLimit.toString(),
      isLoadMore: false,
      isFullList: true,
    );
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        allWatchlistFull.complete((r.dataList ?? []) as List<WatchlistData>);
      },
    );
  }
}
