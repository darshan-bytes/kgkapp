import 'package:kgk/kgk.dart';

part 'watchlist_event.dart';

part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  TextEditingController watchlistSearchController = TextEditingController();
  List<B2BCustomListingDataModel> watchListingList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  WatchlistBloc() : super(WatchlistInitial()) {
    on<WatchlistInitialEvent>(_onWatchlistInitialEvent);
    on<WatchlistLoadMoreEvent>(_onWatchlistLoadMoreEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void _onWatchlistInitialEvent(WatchlistInitialEvent event, Emitter<WatchlistState> emit) async {
    emit(WatchlistReloadState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(WatchlistLoadMoreEvent(currentPage));
      },
    );
    watchListingList = _generateWatchList();
    emit(WatchlistLoadedState());
  }

  void _onWatchlistLoadMoreEvent(WatchlistLoadMoreEvent event, Emitter<WatchlistState> emit) async {
    emit(const WatchlistLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    watchListingList.addAll(_generateWatchList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(WatchlistLoadedMoreState(currentPage: event.currentPage + 1));
  }

  static List<B2BCustomListingDataModel> _generateWatchList() {
    return List.generate(10, (index) {
      return B2BCustomListingDataModel(
        id: index.toString(),
        strName: "Watchlist Name",
        status: ProjectStatus.active,
        strConceptNumber: "PRJ-171604",
        strSalesman: "John Samanta",
        strSalesmanImageUrl: "https://i.ibb.co/hy6pH4g/Frame-3977.png",
        strFrom: "17/03/23 06:00 PM",
        strTo: "24/03/23 06:00 PM",
        strNumberOfProduct: "5",
        strRemainingTime: "20h : 30m : 15s",
      );
    });
  }
}
