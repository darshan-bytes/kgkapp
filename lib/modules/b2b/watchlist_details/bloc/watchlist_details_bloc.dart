import 'package:kgk/kgk.dart';

part 'watchlist_details_event.dart';

part 'watchlist_details_state.dart';

class WatchlistDetailsBloc extends Bloc<WatchlistDetailsEvent, WatchlistDetailsState> {
  WatchlistData watchlistDetailsModel = WatchlistData();

  List<ProductDetailsModel> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  String get watchlistName => watchlistDetailsModel.name ?? '';

  final TextEditingController searchController = TextEditingController();

  WatchlistDetailsBloc() : super(const WatchlistDetailsInitial()) {
    on<WatchlistDetailsInitialEvent>(_onWatchlistDetailsInitialEvent);
    on<WatchlistDetailsLoadMoreEvent>(_onWatchlistDetailsLoadMoreEvent);
    on<WatchlistDetailsEditProductEvent>(_onWatchlistDetailsEditProductEvent);
  }

  Future<void> _onWatchlistDetailsInitialEvent(WatchlistDetailsInitialEvent event, Emitter<WatchlistDetailsState> emit) async {
    emit(const WatchlistDetailsReload());
    if (!event.isInBackground) {
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
    }
    String watchlistId = event.context.routesData?[RoutesData.watchlistId] ?? "";
    if (watchlistId.isNotEmpty) {
      Either<ErrorResponse, WatchlistData>? response =
          await AppRepository(event.context).getWatchListById(watchlistId, isInBackground: event.isInBackground);
      response?.fold(
        (error) {
          event.context.pop();
          Utils.showMessage(error.message);
        },
        (data) {
          watchlistDetailsModel = data;
          productList = _generateProductList();
          emit(const WatchlistDetailsLoaded());
        },
      );

      emit(const WatchlistDetailsLoaded());
    }
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

  List<ProductDetailsModel> _generateProductList() {
    return List.generate(
      watchlistDetailsModel.products?.length ?? 0,
      (index) {
        WatchlistProducts product = watchlistDetailsModel.products![index];
        switch (product.displayCommodity) {
          case Commodity.jewellery:
            return ProductDetailsModel(
              productId: product.productId,
              imageUrl: product.jewelleryData?.multipleFinishedViewImage.isNotNullNorEmpty == true
                  ? product.jewelleryData!.multipleFinishedViewImage[0].imageUrl
                  : "",
              name: product.jewelleryData?.productDescription,
              originalPrice: product.jewelleryData?.finalPrice,
              company: product.jewelleryData?.brandName,
              productSku: product.jewelleryData?.contractNoSkuNo,
              discountPrice: product.jewelleryData?.discountPrice,
              discountPercentage: (product.jewelleryData?.discountPercentage != null && product.jewelleryData!.discountPercentage! > 0)
                  ? product.jewelleryData?.discountPercentage?.toString()
                  : null,
              commodity: product.displayCommodity,
            );
          case Commodity.gemstone:
            return ProductDetailsModel(
              productId: product.productId,
              imageUrl: product.gemstoneData?.image.isNotNullNorEmpty == true ? product.gemstoneData!.image[0].url : "",
              name: product.gemstoneData?.rmDescription,
              originalPrice: product.gemstoneData?.finalPrice,
              productSku: product.gemstoneData?.lotCode,
              lotCode: product.gemstoneData?.lotCode,
              discountPrice: (product.gemstoneData?.discountPrice ?? 0).toString(),
              discountPercentage: (product.gemstoneData?.discountPercentage != null && product.gemstoneData!.discountPercentage! > 0)
                  ? product.gemstoneData?.discountPercentage?.toString()
                  : null,
              commodity: product.displayCommodity,
            );
          case Commodity.diamond:
          default:
            return ProductDetailsModel(
              productId: product.productId,
              imageUrl: product.diamondData?.image.isNotNullNorEmpty == true ? product.diamondData!.image[0].url : "",
              name: product.diamondData?.rmDescription,
              originalPrice: product.diamondData?.finalPrice,
              productSku: product.diamondData?.lotCode,
              lotCode: product.diamondData?.lotCode,
              discountPrice: product.diamondData?.discountPrice,
              discountPercentage: (product.diamondData?.discountPercentage != null && product.diamondData!.discountPercentage! > 0)
                  ? product.diamondData?.discountPercentage?.toString()
                  : null,
              commodity: product.displayCommodity,
            );
        }
      },
    );
  }

  Future<void> _onWatchlistDetailsEditProductEvent(WatchlistDetailsEditProductEvent event, Emitter<WatchlistDetailsState> emit) async {
    if (state is! WatchlistDetailsLoaded) return;
    if (event.actionType == WatchlistActionType.edit) {
      BlocProvider.of<AddToWatchlistBloc>(event.context)
          .add(AddToWatchlistInitialEvent.edit(productList[event.index], event.context, watchlistDetailsModel));
    } else {
      BlocProvider.of<AddToWatchlistBloc>(event.context)
          .add(AddToWatchlistInitialEvent.remove(productList[event.index], event.context, watchlistDetailsModel));
    }
    final result = await Utils.showSmartModalBottomSheet(
      context: event.context,
      enableDrag: false,
      useRootNavigator: true,
      builder: (context) => const AddWatchlistScreen(),
    );

    if (result?[RoutesData.isWatchlistUpdated] == true) {
      add(WatchlistDetailsInitialEvent(event.context, isInBackground: true));
    }
  }
}
