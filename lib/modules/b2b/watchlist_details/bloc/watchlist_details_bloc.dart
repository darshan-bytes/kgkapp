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

  Duration get watchlistRemainTime => watchlistDetailsModel.expiresAt?.difference(DateTime.now()) ?? Duration.zero;

  Timer? timer;

  WatchlistDetailsBloc() : super(const WatchlistDetailsInitial()) {
    on<WatchlistDetailsInitialEvent>(_onWatchlistDetailsInitialEvent);
    on<WatchlistDetailsEditProductEvent>(_onWatchlistDetailsEditProductEvent);
    on<WatchlistDetailsSearchEvent>(_onWatchlistDetailsSearchEvent, transformer: BlocEventDeBouncer.debounceTransformer());
    on<WatchlistDetailsDeleteEvent>(_onWatchlistDetailsDeleteEvent);
    on<WatchlistDetailsTimerEvent>(_onWatchlistDetailsTimerEvent);
  }

  @override
  Future<void> close() async {
    timer?.cancel();
    return super.close();
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
          startTimer();
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
              suid: product.gemstoneData?.suid,
              productId: product.gemstoneData?.id,
              imageUrl: product.gemstoneData?.image.isNotNullNorEmpty == true ? product.gemstoneData?.image.first.url : null,
              name: product.gemstoneData?.rmDescription ?? "",
              ctsOrGms: product.gemstoneData?.ctsOrGms,
              rappaportPrice: product.gemstoneData?.rappaportPrice,
              priceCts: product.gemstoneData?.priceCts,
              originalPrice: product.gemstoneData?.finalPrice?.toString().setCurrency,
              offerPrice: product.gemstoneData?.finalPrice?.toString().setCurrency,
              finalPrice: product.gemstoneData?.discountPrice?.toString().setCurrency,
              lotCode: product.gemstoneData?.lotCode,
              shape: product.gemstoneData?.shape,
              fluorescence: product.gemstoneData?.fluorescence,
              labs: product.gemstoneData?.labs,
              lsp: product.gemstoneData?.lsp?.toString(),
              color: product.gemstoneData?.color,
              clarity: product.gemstoneData?.clarity,
              cut: product.gemstoneData?.cut,
              certificateFile: product.gemstoneData?.certificateFile,
              openDnaUrl: product.gemstoneData?.openDnaUrl,
              commodity: Commodity.gemstone,
              isFavourite: product.gemstoneData?.isFavorite ?? false,
              wishlistId: product.gemstoneData?.wishlistID,
              title: product.gemstoneData?.lotCode ?? "",
              subTitle: product.gemstoneData?.rmDescription ?? "",
            );

          case Commodity.diamond:
          default:
            return ProductDetailsModel(
              suid: product.diamondData?.suid,
              productId: product.diamondData?.id,
              imageUrl: product.diamondData?.image.isNotNullNorEmpty == true ? product.diamondData?.image.first.url : null,
              name: product.diamondData?.rmDescription ?? "",
              ctsOrGms: product.diamondData?.ctsOrGms,
              rappaportPrice: product.diamondData?.rappaportPrice,
              priceCts: product.diamondData?.priceCts,
              originalPrice: product.diamondData?.finalPrice?.toString().setCurrency,
              offerPrice: product.diamondData?.finalPrice?.toString().setCurrency,
              finalPrice: product.diamondData?.discountPrice?.toString().setCurrency,
              lotCode: product.diamondData?.lotCode,
              productSku: product.diamondData?.lotCode,
              shape: product.diamondData?.shape,
              fluorescence: product.diamondData?.fluorescence,
              labs: product.diamondData?.labs,
              lsp: product.diamondData?.lsp,
              color: product.diamondData?.color,
              clarity: product.diamondData?.clarity,
              cut: product.diamondData?.cut,
              certificateFile: product.diamondData?.certificateFile,
              openDnaUrl: product.diamondData?.openDnaUrl,
              commodity: Commodity.diamond,
              company: product.diamondData?.id,
              isFavourite: product.diamondData?.isFavorite ?? false,
              wishlistId: product.diamondData?.wishlistID,
              title: product.diamondData?.lotCode ?? "",
              subTitle: product.diamondData?.rmDescription ?? "",
              isForAuction: product.diamondData?.isAuction ?? false,
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

  Future<void> _onWatchlistDetailsTimerEvent(WatchlistDetailsTimerEvent event, Emitter<WatchlistDetailsState> emit) async {
    emit(const WatchlistDetailsReload());
    emit(const WatchlistDetailsTimerState());
  }

  void handleBack(BuildContext context, {required bool needToPop}) {
    if (needToPop) {
      context.pop(arguments: {
        RoutesData.isWatchlistUpdated: isWatchlistUpdated,
        RoutesData.watchlistData: watchlistDetailsModel,
      });
    }
  }

  void startTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (watchlistDetailsModel.expiresAt != null) {
        if (watchlistDetailsModel.expiresAt?.isAfter(DateTime.now()) == true) {
          add(WatchlistDetailsTimerEvent());
        } else {
          timer?.cancel();
        }
      }
    });
  }
}
