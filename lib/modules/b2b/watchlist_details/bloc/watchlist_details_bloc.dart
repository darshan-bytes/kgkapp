import 'package:kgk/kgk.dart';

part 'watchlist_details_event.dart';

part 'watchlist_details_state.dart';

class WatchlistDetailsBloc extends Bloc<WatchlistDetailsEvent, WatchlistDetailsState> {
  WatchlistDetailsModel watchlistDetailsModel = WatchlistDetailsModel();

  List<ProductDetails> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  String get watchlistName => watchlistDetailsModel.name ?? '';

  final TextEditingController searchController = TextEditingController();

  WatchlistDetailsBloc() : super(const WatchlistDetailsInitial()) {
    on<WatchlistDetailsInitialEvent>(_onWatchlistDetailsInitialEvent);
    on<WatchlistDetailsLoadMoreEvent>(_onWatchlistDetailsLoadMoreEvent);
  }

  void _onWatchlistDetailsInitialEvent(WatchlistDetailsInitialEvent event, Emitter<WatchlistDetailsState> emit) {
    emit(const WatchlistDetailsLoading());
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(WatchlistDetailsLoadMoreEvent(currentPage: currentPage));
      },
    );
    int watchlistId = event.context.routesData?[RoutesData.watchlistId]?.toString().toInt ?? 0;
    watchlistDetailsModel = WatchlistDetailsModel(
      id: watchlistId,
      name: "Watchlist name ${watchlistId + 1}",
      remainingTime: "20hrs : 30mins : 15secs",
      watchlistFromDate: "24/03/2023, 06:00 PM",
      watchlistToDate: "31/03/2023, 06:00 PM",
      watchlistStatus: watchlistId.remainder(2) == 0 ? "active" : "in_active",
    );
    productList = _generateProductList(length: 20);
    emit(const WatchlistDetailsLoaded());
  }

  Future<void> _onWatchlistDetailsLoadMoreEvent(WatchlistDetailsLoadMoreEvent event, Emitter<WatchlistDetailsState> emit) async {
    emit(const WatchlistProductLoadingMore());
    await Future.delayed(const Duration(seconds: 2));
    productList.addAll(_generateProductList());
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(WatchlistProductLoadedMore(event.currentPage));
  }

  @override
  Future<void> close() async {
    paginationScrollController.dispose();
    super.close();
  }

  List<ProductDetails> _generateProductList({int? length}) {
    return List.generate(
      length ?? 10,
      (index) => ProductDetails(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
        company: index % 2 == 0 ? "Martin Flyer" : "Tiffany & Co.",
        productSku: index % 2 == 0 ? "ABCD123456" : "ABCD123456XYZ",
        isOutOfStock: index.remainder(2) == 0,
      ),
    );
  }
}
