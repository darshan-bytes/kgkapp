import 'package:kgk/kgk.dart';

part 'watchlist_details_event.dart';

part 'watchlist_details_state.dart';

class WatchlistDetailsBloc extends Bloc<WatchlistDetailsEvent, WatchlistDetailsState> {
  bool isWatchlistUpdated = false;
  WatchlistData watchlistDetailsModel = WatchlistData();

  List<ProductDetailsModel> _productList = [];
  List<ProductDetailsModel> productList = [];

  String get watchlistName => watchlistDetailsModel.name ?? '';

  final TextEditingController searchController = TextEditingController();

  WatchlistDetailsBloc() : super(const WatchlistDetailsInitial()) {
    on<WatchlistDetailsInitialEvent>(_onWatchlistDetailsInitialEvent);
    on<WatchlistDetailsEditProductEvent>(_onWatchlistDetailsEditProductEvent);
    on<WatchlistDetailsSearchEvent>(_onWatchlistDetailsSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<WatchlistDetailsDeleteEvent>(_onWatchlistDetailsDeleteEvent);
  }

  Future<void> _onWatchlistDetailsInitialEvent(WatchlistDetailsInitialEvent event, Emitter<WatchlistDetailsState> emit) async {
    emit(const WatchlistDetailsReload());
    if (!event.isInBackground) {
      emit(const WatchlistDetailsLoading());
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
          _productList = List.from(productList);
          emit(const WatchlistDetailsLoaded());
        },
      );

      emit(const WatchlistDetailsLoaded());
    }
  }

  List<ProductDetailsModel> _generateProductList() {
    return List.generate(
      watchlistDetailsModel.products?.length ?? 0,
      (index) {
        WatchlistProducts product = watchlistDetailsModel.products![index];
        switch (product.displayCommodity) {
          case Commodity.jewellery:
            return ProductDetailsModel(
                suid: product.jewelleryData?.suid ?? "",
                productId: product.productId,
                imageUrl: product.jewelleryData?.multipleFinishedViewImage.isNotNullNorEmpty == true
                    ? product.jewelleryData!.multipleFinishedViewImage[0].imageUrl
                    : "",
                name: product.jewelleryData?.productDescription,
                discountPrice: product.jewelleryData?.discountPrice?.setCurrency,
                originalPrice: product.jewelleryData?.finalPrice?.setCurrency,
                discountPercentageString: (product.jewelleryData?.discountPercentage ?? 0) > 0
                    ? APPStrings.percentageOffInterpolating.tr.interpolate([product.jewelleryData?.discountPercentage])
                    : null,
                company: product.jewelleryData?.brandName,
                productSku: product.jewelleryData?.contractNoSkuNo,
                commodity: product.displayCommodity,
                cts: product.jewelleryData?.crt,
                gms: product.jewelleryData?.gms,
                isFavourite: product.jewelleryData?.isFavorite ?? false,
                wishlistId: product.jewelleryData?.wishlistID,
                title: product.jewelleryData?.contractNoSkuNo ?? '',
                subTitle: product.jewelleryData?.productDescription ?? '',
                kgkCollectionName: product.jewelleryData?.kgkCollection ?? "\n",
                businessCategoryName: product.jewelleryData?.businessCategoryName ?? "\n",
                brandName: product.jewelleryData?.brandName,
                colorsCode: [
                  product.jewelleryData?.metalColor1HexCode ?? "",
                  product.jewelleryData?.metalColor2HexCode ?? "",
                  product.jewelleryData?.metalColor3HexCode ?? "",
                ]);
          case Commodity.gemstone:
            return ProductDetailsModel(
              productId: product.productId,
              imageUrl: product.gemstoneData?.image.isNotNullNorEmpty == true ? product.gemstoneData!.image[0].url : "",
              name: product.gemstoneData?.rmDescription,
              originalPrice: product.gemstoneData?.finalPrice,
              productSku: product.gemstoneData?.lotCode,
              lotCode: product.gemstoneData?.lotCode,
              discountPrice: (product.gemstoneData?.discountPrice ?? 0).toString(),
              discountPercentageString: (product.gemstoneData?.discountPercentage != null && product.gemstoneData!.discountPercentage! > 0)
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
              discountPercentageString: (product.diamondData?.discountPercentage != null && product.diamondData!.discountPercentage! > 0)
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
      isWatchlistUpdated = true;
      add(WatchlistDetailsInitialEvent(event.context, isInBackground: true));
    }
  }

  void _onWatchlistDetailsSearchEvent(WatchlistDetailsSearchEvent event, Emitter<WatchlistDetailsState> emit) {
    emit(const WatchlistDetailsLoading());
    if (event.searchQuery.isEmpty) {
      productList = _productList;
    } else {
      productList.clear();
      productList.addAll(
          _productList.where((element) => element.name!.toLowerCase().trim().contains(event.searchQuery.toLowerCase().trim())).toList());
    }
    emit(const WatchlistDetailsLoaded());
  }

  Future<void> _onWatchlistDetailsDeleteEvent(WatchlistDetailsDeleteEvent event, Emitter<WatchlistDetailsState> emit) async {
    if (watchlistDetailsModel.sId.isNullOrEmpty) return;
    Either<ErrorResponse, CommonResponse>? response = await AppRepository(event.context).deleteWatchList(watchlistDetailsModel.sId!);
    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (data) {
        Utils.showMessage(data.message);

        event.context.pop();
        event.screenContext.pop(arguments: {
          RoutesData.isWatchlistDeleted: true,
          RoutesData.watchlistData: watchlistDetailsModel,
        });
      },
    );
  }

  void handleBack(BuildContext context, {required bool needToPop}) {
    if (needToPop) {
      context.pop(arguments: {
        RoutesData.isWatchlistUpdated: isWatchlistUpdated,
        RoutesData.watchlistData: watchlistDetailsModel,
      });
    }
  }
}
