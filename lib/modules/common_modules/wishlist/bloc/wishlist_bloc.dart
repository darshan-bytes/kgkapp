import 'package:kgk/kgk.dart';
import 'package:kgk/modules/common_modules/wishlist/model/wishlist_model.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<ProductDetailsModel> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();
  List<WishlistDatum> wishlistDataList = [];

  int currentPage = 1;
  int? totalNumberOfPages;
  int limit = 10;

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

  Future<void> onInitialWishlistEvent(InitialWishlistEvent event, Emitter<WishlistState> emit) async {
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
        add(LoadMoreWishlistEvent(event.context, currentPage));
      },
    );

    await fetchWishlistData(event.context, emit);
    refreshCompleter.complete(true);
    emit(WishlistDataFetchedState());
  }

  Future<void> fetchWishlistData(BuildContext context, Emitter<WishlistState> emit) async {
    await AppRepository(context).fetchWishList(limit: limit.toString(), page: currentPage.toString()).then((value) {
      value?.fold((l) {
        Utils.showMessage(l.message ?? "");
      }, (r) {
        r.totalRecords ??= 0;
        WishlistModel wishlistModel = r;
        totalNumberOfPages = (r.totalRecords! % limit == 0) ? (r.totalRecords ?? 0) ~/ limit : ((r.totalRecords ?? 0) ~/ limit) + 1;
        productList = [
          for (var element in wishlistModel.data)
            if (element.productData != null)

              /// In ProductDetails commodity need to set is Pending from backend
              ProductDetailsModel(
                productId: element.productId ?? '',
                imageUrl: element.productData!.multipleFinishedViewImage.isNotNullNorEmpty
                    ? element.productData!.multipleFinishedViewImage.first.imageUrl
                    : "",
                name: element.productData!.productDescription ?? "",
                originalPrice: element.productData!.discountPrice?.setCurrency,
                // commodity: element.productData?.commodity ?? "",
                isFavourite: element.productData?.isFavorite ?? true,
                wishlistId: element.productData?.wishlistId ?? "",
              )
        ];
      });
    });
  }

  Future<void> _onLoadMoreWishlistEvent(LoadMoreWishlistEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistLoadingMoreState());
    currentPage++;
    await fetchWishlistData(event.context, emit);
    paginationScrollController.isPageLoaded.complete(event.currentPage == totalNumberOfPages);
    emit(WishlistLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onWishlistPullToRefreshEvent(WishlistPullToRefreshEvent event, Emitter<WishlistState> emit) async {
    emit(WishlistReloadState());
    await Future.delayed(const Duration(seconds: 2));
    paginationScrollController.pullToRefresh();
    productList.clear();
    currentPage = 1;
    await fetchWishlistData(event.context, emit);
    refreshCompleter.complete(true);
    emit(WishlistDataFetchedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(WishlistPullToRefreshEvent(context));
    return refreshCompleter.future;
  }
}
