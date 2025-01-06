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

  /// This filterData is used to store the filter data
  List<FilterData> filterData = [];

  WatchlistBloc() : super(const WatchlistInitial()) {
    on<WatchlistInitialEvent>(_onWatchlistInitialEvent);
    on<WatchlistLoadMoreEvent>(_onWatchlistLoadMoreEvent);
    on<WatchlistPullToRefreshEvent>(_onWatchlistPullToRefresh);
    on<WatchListCloseEvent>(_onWatchListClose);
    on<WatchListSearchEvent>(_onWatchListSearch);
    on<WatchListDeleteEvent>(_onWatchListDelete);
    on<WatchListLoadFullListEvent>(_onWatchListLoadFullLis);
    on<WatchListFilterEvent>(_onWatchListFilter);
    on<WatchListUpdateItemEvent>(_onWatchListUpdateItemEvent);
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
    _fetchFilterData(event.context, emit);
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

  /// Build the filters dynamically
  Map<String, dynamic> buildFilters(List<FilterData> filterData) {
    Map<String, dynamic> filters = {};

    for (FilterData element in filterData) {
      switch (element.filterType) {
        case FilterType.dateRange:
          if (element.dateRange != null) {
            filters[element.code ?? ''] = [
              element.dateRange?.start.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD),
              element.dateRange?.end.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatYYYYMMDD)
            ];
          }
          break;
        case FilterType.checkbox:
          List<String?>? selectedCodes = element.secondaryFilterData?.where((e) => e.isSelected).map((e) => e.code).toList();
          if (selectedCodes != null && selectedCodes.isNotEmpty) {
            filters[element.code ?? ''] = selectedCodes.join(',');
          }
          break;

        default:
          break;
      }
    }

    return filters;
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
      filterQuery: buildFilters(filterData),
    );
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        r.totalRecords ??= 0;
        totalNumberOfPages = Utils.calculateTotalPages(r.filteredRecords, AppConst.pageLimit);
        List<WatchlistData> dataList = (r.dataList ?? []);
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

  void _onWatchListClose(WatchListCloseEvent event, Emitter<WatchlistState> emit) {
    clearBlocData();
    emit(const WatchlistInitial());
  }

  Future<void> _onWatchListSearch(WatchListSearchEvent event, Emitter<WatchlistState> emit) async {
    await pullToRefresh(context: event.context);
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
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
    }
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
        allWatchlistFull.complete((r.dataList ?? []));
      },
    );
  }

  void _onWatchListFilter(WatchListFilterEvent event, Emitter<WatchlistState> emit) {
    emit(const WatchlistLoadingState());
    paginationScrollController.pullToRefresh();
    watchlistDataList.clear();
    watchListingList.clear();
    filterData = event.filterData;
    fetchWatchlist(event.context, emit, false, paginationScrollController.currentPage);
    emit(const WatchlistLoadedState());
  }

  void _onWatchListUpdateItemEvent(WatchListUpdateItemEvent event, Emitter<WatchlistState> emit) {
    emit(const WatchlistLoadingState());
    if (event.isWatchlistDeleted == true) {
      emit(const WatchlistReloadState());
      watchlistDataList.removeAt(event.index);
      watchListingList.removeAt(event.index);
      emit(const WatchlistDeleteState());
    } else if (event.watchlistData != null) {
      watchlistDataList[event.index] = event.watchlistData!;
      watchListingList[event.index] = B2BCustomListingDataModel(
        id: event.watchlistData!.sId ?? "",
        strName: event.watchlistData!.name ?? "",
        status: event.watchlistData!.displayStatus,
        strFrom: event.watchlistData!.createdAt?.changeDateFormat(
            outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2, inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ),
        strTo: event.watchlistData!.expiresAt?.changeDateFormat(
            outputDateFormat: DateFormatter.dateFormatDDMMMYYYYHHMMA2, inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ),
        strNumberOfProduct: event.watchlistData?.products?.length.toString() ?? "0",
        strRemainingTime: ValueNotifier<String>(event.watchlistData!.duration?.displayDuration ?? ""),
      );
      emit(const WatchlistLoadedState());
    }
  }

  void _fetchFilterData(BuildContext context, Emitter<WatchlistState> emit) async {
    if (filterData.isEmpty) {
      await _setupFilters(context);
      BlocProvider.of<AdvanceSortFilterBloc>(context).add(AddAdvanceSortFilterDataEvent(filterOptionList: filterData, context: context));
    }
  }

  Future<void> _setupFilters(BuildContext context) async {
    Either<ErrorResponse, AdvanceFilterOptionModel>? response = await AppRepository(context).fetchWatchListingFilterOptionList();
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (AdvanceFilterOptionModel success) {
      filterData.clear();
      if (success.filters.isNotNullNorEmpty) {
        for (Filters filterOption in success.filters ?? <Filters>[]) {
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
}
