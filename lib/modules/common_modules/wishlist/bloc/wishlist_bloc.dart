import 'package:kgk/kgk.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<ProductDetails> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  WishlistBloc() : super(WishlistInitial()) {
    on<InitialWishlistEvent>(onInitialWishlistEvent);
    on<LoadMoreWishlistEvent>(_onLoadMoreWishlistEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void onInitialWishlistEvent(InitialWishlistEvent event, Emitter<WishlistState> emit) {
    emit(WishlistReloadState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreWishlistEvent(currentPage));
      },
    );
    productList.clear();

    List.generate(
      20,
      (index) => productList.add(
        ProductDetails(
          imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
          name: "Diamond Vine Ring in 18k Rose Gold",
          originalPrice: '\$5,000.00',
        ),
      ),
    );

    emit(WishlistDataFetchedState());
  }

  Future<void> _onLoadMoreWishlistEvent(LoadMoreWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    List.generate(
        20,
        (index) => productList.add(ProductDetails(
              imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
              name: "Diamond Vine Ring in 18k Rose Gold",
              originalPrice: '\$5,000.00',
            )));
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(WishlistLoadedMoreState(event.currentPage + 1));
  }
}
