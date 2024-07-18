import 'package:kgk/kgk.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<ProductDetails> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  WishlistBloc() : super(WishlistInitial()) {
    on<InitialWishlistEvent>(onInitialWishlistEvent);
    on<LoadMoreWishlistEvent>(_onLoadMoreWishlistEvent);
    on<WishlistPullToRefreshEvent>(_onWishlistPullToRefreshEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void onInitialWishlistEvent(InitialWishlistEvent event, Emitter<WishlistState> emit) {
    emit(WishlistReloadState());
    if (paginationScrollController.isInitialised) {
      paginationScrollController.dispose();
      paginationScrollController = SmartPaginationScrollController();
    }
    if (refreshCompleter.isCompleted) {
      refreshCompleter = Completer<bool>();
    }
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreWishlistEvent(currentPage));
      },
    );

    productList = List.generate(
      20,
      (index) => ProductDetails(
        imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
        name: "Diamond Vine Ring in 18k Rose Gold",
        originalPrice: '\$5,000.00',
      ),
    );
    refreshCompleter.complete(true);
    emit(WishlistDataFetchedState());
  }

  Future<void> _onLoadMoreWishlistEvent(LoadMoreWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    productList.addAll(List.generate(
        20,
        (index) => ProductDetails(
              imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
              name: "Diamond Vine Ring in 18k Rose Gold",
              originalPrice: '\$5,000.00',
            )));
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(WishlistLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onWishlistPullToRefreshEvent(WishlistPullToRefreshEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistReloadState());
    await Future.delayed(const Duration(seconds: 2));
    paginationScrollController.pullToRefresh();
    productList = List.generate(
        20,
        (index) => ProductDetails(
              imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
              name: "Diamond Vine Ring in 18k Rose Gold",
              originalPrice: '\$5,000.00',
            ));
    refreshCompleter.complete(true);
    emit(WishlistDataFetchedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const WishlistPullToRefreshEvent());
    return refreshCompleter.future;
  }
}
