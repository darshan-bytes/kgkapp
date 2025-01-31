import 'package:kgk/kgk.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  UserType userType = UserType.b2cUser;
  String productId = '';
  String productName = '';
  ProductDetailsModel? productDetails;
  DiamondDataModel? diamondData;
  GemstoneDatum? gemstoneData;
  bool isCustomisation = false;
  String? the3DFile;
  String? videoUrl;
  bool isAddedToCart = false;
  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;
  final CarouselSliderController controller = CarouselSliderController();
  final ScrollController youMayLikeScrollController = ScrollController();
  final ScrollController recentViewScrollController = ScrollController();

  List<String> imgList = [];
  int current = 0;
  bool isCompare = false;

  bool isErrorInLoadingData = false;

  /// Auction related variables
  String startingBidPrice = '';
  bool isBidPlaced = false;
  bool isMyBidPlaced = false;
  Timer? _timer;
  AuctionDataModel? auctionDataModel;
  Duration auctionEndDuration = Duration.zero;
  final GlobalKey targetKey = GlobalKey();
  List<Map<String, dynamic>> recentBidList = [];
  final TextEditingController bidAmountController = TextEditingController();
  String? bidAmountError;

  /// Timer title getter
  String _timerTitle = APPStrings.auctionEndIn.tr;

  String get timerTitle => "$_timerTitle  :";

  /// Timer title value getter
  String _timerValue = '';

  String get timerValue => _timerValue;

  List<ProductCustomizationOptions> productCustomizations = [
    ProductCustomizationOptions(
      id: '1',
      name: APPStrings.diamondShape.tr,
      type: ProductCustomizationType.image.value,
      selectedValue: ProductCustomizationOptionValues(id: '1', value: 'Round', image: 'https://i.ibb.co/0t0HyMp/Frame-1410088948.png'),
      values: [
        ProductCustomizationOptionValues(id: '1', value: 'Round', image: 'https://i.ibb.co/0t0HyMp/Frame-1410088948.png'),
        ProductCustomizationOptionValues(id: '2', value: 'Princess', image: 'https://i.ibb.co/Czxfjrr/Frame-1410088948-2.png'),
        ProductCustomizationOptionValues(id: '3', value: 'Emerald', image: 'https://i.ibb.co/HGKZm5K/Frame-1410088948-6.png'),
        ProductCustomizationOptionValues(id: '4', value: 'Asscher', image: 'https://i.ibb.co/52XHw1d/Frame-1410088948-4.png'),
        ProductCustomizationOptionValues(id: '5', value: 'Oval', image: 'https://i.ibb.co/80xk2MK/Frame-1410088948-5.png'),
      ],
    ),
    ProductCustomizationOptions(
      id: '2',
      name: APPStrings.metal.tr,
      type: ProductCustomizationType.metal.value,
      selectedValue: ProductCustomizationOptionValues(id: '1', value: 'White Gold', image: 'https://i.ibb.co/Zzd66J6/Ellipse-117.png'),
      values: [
        ProductCustomizationOptionValues(id: '1', value: 'White Gold', image: 'https://i.ibb.co/Zzd66J6/Ellipse-117.png'),
        ProductCustomizationOptionValues(id: '2', value: 'Rose Gold', image: 'https://i.ibb.co/DYMS4xm/Ellipse-117-1.png'),
        ProductCustomizationOptionValues(id: '3', value: 'Yellow Gold', image: 'https://i.ibb.co/XsKxFtz/Ellipse-117-2.png'),
        ProductCustomizationOptionValues(id: '4', value: 'Silver', image: 'https://i.ibb.co/wJmc5Vq/Ellipse-117-3.png'),
        ProductCustomizationOptionValues(id: '5', value: 'Platinum', image: 'https://i.ibb.co/QbPWvNs/Ellipse-117-4.png'),
      ],
    ),
    ProductCustomizationOptions(
      id: '3',
      name: APPStrings.metalKaratage.tr,
      type: ProductCustomizationType.metalKaratage.value,
      selectedValue: ProductCustomizationOptionValues(id: '1', value: '5'),
      values: [
        ProductCustomizationOptionValues(id: '1', value: '5'),
        ProductCustomizationOptionValues(id: '2', value: '18K'),
        ProductCustomizationOptionValues(id: '3', value: '22K'),
      ],
    ),
    ProductCustomizationOptions(
      id: '4',
      name: APPStrings.diamondQuality.tr,
      type: ProductCustomizationType.diamondQuality.value,
      selectedValue: ProductCustomizationOptionValues(id: '1', value: 'Standard', image: 'https://i.ibb.co/RbD0fvW/Truck.png'),
      values: [
        ProductCustomizationOptionValues(id: '1', value: 'Standard', image: 'https://i.ibb.co/RbD0fvW/Truck.png'),
        ProductCustomizationOptionValues(id: '2', value: 'Standard - 2', image: 'https://i.ibb.co/1qqDcCR/Truck-1.png'),
        ProductCustomizationOptionValues(id: '3', value: 'Standard - 3', image: 'https://i.ibb.co/X2SdMK4/Truck-2.png'),
      ],
    ),
    ProductCustomizationOptions(
      id: '5',
      name: APPStrings.ringSize.tr,
      type: ProductCustomizationType.ringSize.value,
      selectedValue: ProductCustomizationOptionValues(id: '1', value: '5.5'),
      values: [
        ProductCustomizationOptionValues(id: '1', value: '5.5'),
        ProductCustomizationOptionValues(id: '2', value: '6'),
        ProductCustomizationOptionValues(id: '3', value: '6.5'),
        ProductCustomizationOptionValues(id: '4', value: '7'),
        ProductCustomizationOptionValues(id: '5', value: '7.5'),
        ProductCustomizationOptionValues(id: '6', value: '8'),
        ProductCustomizationOptionValues(id: '7', value: '8.5'),
        ProductCustomizationOptionValues(id: '8', value: '9'),
        ProductCustomizationOptionValues(id: '9', value: '9.5'),
        ProductCustomizationOptionValues(id: '10', value: '10'),
      ],
    ),
  ];

  bool isRingDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> ringDetailsKey = GlobalKey();
  bool isDiamondDetailsOpen = false;
  bool isGemstoneDetailsOpen = false;
  GlobalKey<SmartExpansionTileState> diamondDetailsKey = GlobalKey();
  GlobalKey<SmartExpansionTileState> gemstoneDetailsKey = GlobalKey();

  List<ProductDetailsModel> suggestedProductList = [];
  List<JewelleryDataModel> jewelleryDatumListAPI = [];
  List<DiamondDataModel> diamondDatumListAPI = [];
  List<GemstoneDatum> gemstoneDatumListAPI = [];

  List<ProductDetailsModel> recentlyViewedProductList = [];

  List<ReviewDataModel> reviewList = [];

  bool userReviewSubmitted = false;

  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;
  StreamSubscription<CompareProductState>? compareProductStream;

  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<ToggleCompareProductEvent>(_onToggleCompareProduct);
    on<ProductCustomizationChangeEvent>(_onOnProductCustomizationChange);
    on<RingDetailsToggleEvent>(_onRingDetailsToggleEvent);
    on<ProductDiamondDetailsToggleEvent>(_onProductDiamondDetailsToggleEvent);
    on<GemstoneDetailsToggleEvent>(_onGemstoneDetailsToggleEvent);
    on<ProductDetailsSuggestedLoadedEvent>(_onProductDetailsSuggestedLoadedEvent);
    on<ProductDetailsReviewsLoadedEvent>(_onProductDetailsReviewsLoadedEvent);
    on<ProductDetailsWriteReviewEvent>(_onProductDetailsWriteReviewEvent);
    on<ProductDetailsAuctionStartTimerEvent>(_onStartTimer);
    on<ProductDetailsAuctionUpdateTimerEvent>(_onUpdateTimer);
    on<ProductDetailsAuctionTimerCompletedEvent>(_onAuctionTimerCompletedEvent);
    on<ProductDetailsAuctionPlaceBidEvent>(_onPlaceBidEvent);
    on<ProductDetailsPlaceBidFieldChangeEvent>(_onProductDetailsPlaceBidFieldChangeEvent);
  }

  @override
  Future<void> close() async {
    wishlistUpdaterServiceStream?.cancel();
    compareProductStream?.cancel();
    _timer?.cancel();
    super.close();
  }

  Future<void> _onLoadProductDetails(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoadingState());

    /// initializing compare product stream
    initCompareProductChangesStream(event.context);

    /// assigning current userType
    userType = BlocProvider.of<AppBloc>(event.context).userType;

    /// assigning current screen identifier
    getScreenIdentifier(event.context);

    /// assigning product id
    productId = event.context.routesData?[RoutesData.productId] ?? '--';
    if (productId.isEmpty || productId == '--') return;

    /// loading product details
    await _loadProductDetails(event, emit);

    /// initializing wishlist updater service
    _initWishlistUpdaterServiceBloc(event.context);

    /// initializing wishlist updater service
    _initWishlistUpdaterServiceBloc(event.context);
  }

  Future<void> _loadProductDetails(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    _clearProductData();

    switch (screenIdentifier) {
      case ScreenIdentifier.productForDiamonds:
        await _handleDiamondProduct(event, emit);
        break;
      case ScreenIdentifier.productForGemstones:
        await _handleGemstoneProduct(event, emit);
        break;
      case ScreenIdentifier.productForRing:
        await _handleRingProduct(event, emit);
        break;
      default:
        break;
    }

    /// set up customizations
    _setupCustomizations(context: event.context);
  }

  void _clearProductData() {
    productCustomizations.clear();
    imgList.clear();
    suggestedProductList.clear();
    recentlyViewedProductList.clear();
  }

  Future<void> _handleDiamondProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    await StorageManager().setRecentlyViewedDiamonds(productId);
    await getDiamondsDetails(event.context, productId);
    _emitLoadedStateIfAvailable(event, emit);
    await _getDiamondAuctionDetails(event.context, emit);
    getTimerText(state);
    await getDiamondYouMayLike(event.context, productId);
    await getDiamondsRecentlyViewed(event.context, productId);
  }

  Future<void> _handleGemstoneProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    await StorageManager().setRecentlyViewedGemstones(productId);
    await getGemstoneDetails(event.context, productId);
    _emitLoadedStateIfAvailable(event, emit);
    await getGemstoneYouMayLike(event.context, productId);
    await getGemstoneRecentlyViewed(event.context, productId);
  }

  Future<void> _handleRingProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoadingState());
    await StorageManager().setRecentlyViewedJewellery(productId);
    await getProductDetails(event.context, productId);
    _emitLoadedStateIfAvailable(event, emit);
    await productReviewsFilter(event.context, productId, emit);
    await getProductYouMayLike(event.context, productId);
    await getProductRecentlyViewed(event.context, productId);
  }

  void _emitLoadedStateIfAvailable(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) {
    if (productDetails != null) {
      isCompare = BlocProvider.of<CompareProductBloc>(event.context).productIdList.contains(productDetails!.productId);
      emit(ProductDetailsLoadedState(productDetails!));
    }
  }

  void _setupCustomizations({required BuildContext context}) {
    isCustomisation = context.routesData?[RoutesData.isCustomisationPage] ?? false;
    if (isCustomisation) {
      productCustomizations.insert(
        0,
        ProductCustomizationOptions(
          id: productCustomizations.length.toString(),
          name: APPStrings.head.tr,
          type: ProductCustomizationType.head.value,
          selectedValue:
              ProductCustomizationOptionValues(id: '1', value: 'Four Prong', image: 'https://i.ibb.co/0t0HyMp/Frame-1410088948.png'),
          values: [
            ProductCustomizationOptionValues(id: '1', value: 'Four Prong', image: 'https://i.ibb.co/Sv3GQ6D/image-329.png'),
            ProductCustomizationOptionValues(id: '2', value: 'Four Prong', image: 'https://i.ibb.co/Sv3GQ6D/image-329.png'),
            ProductCustomizationOptionValues(id: '3', value: 'Four Prong', image: 'https://i.ibb.co/Sv3GQ6D/image-329.png'),
            ProductCustomizationOptionValues(id: '4', value: 'Four Prong', image: 'https://i.ibb.co/Sv3GQ6D/image-329.png'),
            ProductCustomizationOptionValues(id: '5', value: 'Four Prong', image: 'https://i.ibb.co/Sv3GQ6D/image-329.png'),
          ],
        ),
      );
    }
  }

  Future<void> getDiamondsDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, DiamondDataModel>? response = await AppRepository(context).getDiamondDetailById(productId);
    response?.fold(
      (error) {
        isErrorInLoadingData = true;
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        diamondData = data;
        if (diamondData != null) {
          isErrorInLoadingData = false;
          bool isDiscounted =
              diamondData!.discountPercentage != null && (diamondData!.discountPercentage is num) && diamondData!.discountPercentage > 0;
          isAddedToCart = diamondData!.isAddedToCart;
          productName = diamondData!.rmDescription ?? '';
          imgList = diamondData!.image.map((e) => e.url ?? '').toList();
          productDetails = ProductDetailsModel(
            productId: productId,
            suid: diamondData!.suid,
            name: productName,
            offerPrice: isDiscounted ? diamondData!.discountPrice?.setCurrency : null,
            originalPrice: diamondData!.finalPrice?.setCurrency,
            discountPercentageString:
                isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([diamondData!.discountPercentage]) : null,
            productSku: diamondData!.lotCode,
            reviewCount: diamondData!.reviewCount,
            rating: diamondData!.rating,
            commodity: Commodity.diamond,
            isFavourite: diamondData?.isFavorite ?? false,
            wishlistId: diamondData?.wishlistID,
            stoneElements: diamondData?.components,
            auctionId: diamondData?.auctionId,
          );
        }
      },
    );
  }

  Future<void> getGemstoneDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, GemstoneDatum>? response = await AppRepository(context).getGemstoneDetailById(productId);
    response?.fold(
      (error) {
        isErrorInLoadingData = true;
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        gemstoneData = data;
        if (gemstoneData != null) {
          isErrorInLoadingData = false;
          bool isDiscounted = gemstoneData!.discountPercentage != null &&
              (gemstoneData?.discountPercentage is num) &&
              (gemstoneData?.discountPercentage ?? 0) > 0;
          isAddedToCart = gemstoneData!.isAddedToCart;
          productName = gemstoneData?.rmDescription ?? '';
          if (gemstoneData?.image.isNotEmpty ?? false) {
            imgList = gemstoneData!.image.map((e) => e.url ?? '').toList();
          }
          productDetails = ProductDetailsModel(
            productId: productId,
            suid: gemstoneData!.suid,
            name: productName,
            offerPrice: isDiscounted ? (gemstoneData!.discountPrice ?? 0).toString().setCurrency : null,
            originalPrice: gemstoneData!.finalPrice?.setCurrency,
            discountPercentageString:
                isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([gemstoneData?.discountPercentage]) : null,
            productSku: gemstoneData?.lotCode,
            reviewCount: gemstoneData?.reviewCount,
            rating: gemstoneData?.rating?.toDouble(),
            shape: gemstoneData?.shape,
            productQuality: CartProductQuality(name: gemstoneData?.quality),
            color: gemstoneData?.color,
            clarity: gemstoneData?.clarity,
            commodity: Commodity.gemstone,
            isFavourite: gemstoneData?.isFavorite ?? false,
            wishlistId: gemstoneData?.wishlistID,
            stoneElements: gemstoneData?.components,
            isAddedToCart: gemstoneData?.isAddedToCart ?? false,
          );
        }
      },
    );
  }

  Future<void> getDiamondYouMayLike(BuildContext context, String productId) async {
    Either<ErrorResponse, DiamondListingModel>? response = await AppRepository(context)
        .getDiamondYouMayLike(productId, limit: AppConst.pageLimit10.toString(), page: AppConst.page1.toString(), isShowLoader: false);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        if (data.data.isNotEmpty) {
          diamondDatumListAPI = data.data;
          suggestedProductList = diamondDatumListAPI.map((e) {
            bool isDiscounted = e.discountPercentage != null && (e.discountPercentage is num) && e.discountPercentage > 0;
            return ProductDetailsModel(
              suid: e.suid ?? '',
              productId: e.suid ?? '',
              name: e.rmDescription ?? '',
              imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
              offerPrice: isDiscounted ? e.discountPrice?.setCurrency : null,
              originalPrice: e.finalPrice?.setCurrency,
              discountPercentageString: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([e.discountPercentage]) : null,
              productSku: e.lotCode,
              reviewCount: e.reviewCount,
              rating: e.rating?.toDouble(),
              commodity: Commodity.diamond,
              isFavourite: e.isFavorite,
              wishlistId: e.wishlistID,
              title: e.suid,
              subTitle: e.rmDescription,
              isAddedToCart: e.isAddedToCart,
            );
          }).toList();
          add(const ProductDetailsSuggestedLoadedEvent());
        }
      },
    );
  }

  Future<void> getGemstoneYouMayLike(BuildContext context, String productId) async {
    final Either<ErrorResponse, GemstoneListingModel>? response = await AppRepository(context)
        .getGemstoneYouMayLike(productId, page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());

    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message!);
        }
      },
      (data) {
        if (data.data.isEmpty) return;
        gemstoneDatumListAPI = data.data;
        suggestedProductList = data.data.map((e) {
          final bool isDiscounted = e.discountPercentage != null && (e.discountPercentage is num) && (e.discountPercentage ?? 0) > 0;

          return ProductDetailsModel(
            suid: e.suid ?? '',
            productId: e.suid ?? '',
            name: e.rmDescription ?? '',
            imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
            offerPrice: isDiscounted ? (e.discountPrice ?? 0).toString().setCurrency : null,
            originalPrice: e.finalPrice?.setCurrency,
            discountPercentageString: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([e.discountPercentage]) : null,
            productSku: e.lotCode,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            commodity: Commodity.gemstone,
            isFavourite: e.isFavorite,
            wishlistId: e.wishlistID,
            title: e.suid,
            subTitle: e.rmDescription,
            isAddedToCart: e.isAddedToCart,
          );
        }).toList();

        add(const ProductDetailsSuggestedLoadedEvent());
      },
    );
  }

  Future<void> getProductYouMayLike(BuildContext context, String productId) async {
    Either<ErrorResponse, JewelleryListingModel>? response = await AppRepository(context)
        .getJewelleryYouMayLike(productId, page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        jewelleryDatumListAPI = data.data;
        suggestedProductList = data.data.map((item) {
          bool isDiscounted = item.discountPercentage != null && (item.discountPercentage! > 0);
          return ProductDetailsModel(
            suid: item.suid ?? "",
            imageUrl: item.multipleFinishedViewImage.isNotNullNorEmpty ? item.multipleFinishedViewImage[0].imageUrl : "",
            name: item.productDescription ?? "",
            originalPrice: item.finalPrice?.toString().setCurrency,
            offerPrice: item.discountPrice?.toString().setCurrency,
            finalPrice: item.discountPrice?.toString().setCurrency,
            discountPercentageString: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([item.discountPercentage]) : null,
            productId: item.suid ?? "",
            commodity: Commodity.jewellery,
            isFavourite: item.isFavorite,
            wishlistId: item.wishlistID,
            productSku: item.contractNoSkuNo,
            title: item.contractNoSkuNo ?? '',
            subTitle: item.productDescription ?? '',
            kgkCollectionName: item.kgkCollection ?? "\n",
            businessCategoryName: item.businessCategoryName ?? "\n",
            cts: item.crt,
            gms: item.gms,
            brandName: item.brandName,
            reviewCount: item.reviewCount,
            rating: item.rating?.toDouble(),
            colorsCode: [
              item.metalColor1HexCode ?? "",
              item.metalColor2HexCode ?? "",
              item.metalColor3HexCode ?? "",
            ],
            isAddedToCart: item.isAddedToCart,
          );
        }).toList();
        if (!isClosed) {
          add(const ProductDetailsSuggestedLoadedEvent());
        }
      },
    );
  }

  Future<void> getProductDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, JewelleryDataModel>? response = await AppRepository(context).getProductDetailById(productId, isLoadingShow: true);
    response?.fold(
      (error) {
        isErrorInLoadingData = true;
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (JewelleryDataModel jewelleryData) {
        isErrorInLoadingData = false;
        isAddedToCart = jewelleryData.isAddedToCart;
        productName = jewelleryData.productDescription ?? '';
        bool isDiscounted = jewelleryData.discountPercentage != null && (jewelleryData.discountPercentage! > 0);

        imgList = [];
        for (var element in jewelleryData.multipleFinishedViewImage) {
          for (var e in element.multiAngleUrl) {
            if (element.imageAvailable?.toLowerCase() == ApiKey.yes) {
              if (e.url.isNotNullNorEmpty) {
                imgList.add(e.url!);
              }
            }
          }
        }

        the3DFile = jewelleryData.multipleFinishedViewImage.firstWhereOrNull((element) => element.the3DFile.isNotNullNorEmpty)?.the3DFile;
        videoUrl = jewelleryData.multipleFinishedViewImage.firstWhereOrNull((element) => element.videoUrl.isNotNullNorEmpty)?.videoUrl;

        productDetails = ProductDetailsModel(
          productId: productId,
          suid: jewelleryData.suid,
          name: productName,
          offerPrice: isDiscounted ? jewelleryData.discountPrice?.setCurrency : null,
          originalPrice: jewelleryData.finalPrice?.setCurrency,
          discountPercentageString:
              isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([jewelleryData.discountPercentage]) : null,
          productSku: jewelleryData.contractNoSkuNo,
          reviewCount: jewelleryData.reviewCount,
          rating: jewelleryData.rating?.toDouble(),
          brandName: jewelleryData.brandName,
          imageUrl: jewelleryData.multipleFinishedViewImage.isEmpty ? '' : jewelleryData.multipleFinishedViewImage[0].imageUrl ?? '',
          commodity: Commodity.jewellery,
          isFavourite: jewelleryData.isFavorite,
          wishlistId: jewelleryData.wishlistID,
          components: jewelleryData.components,
        );
      },
    );
  }

  Future<void> productReviewsFilter(BuildContext context, String productId, Emitter<ProductDetailsState> emit) async {
    emit(const ReloadProductDetailsState());

    // Here requested 6 reviews only for the first page. if the list's length is less than 6, then it will show the available reviews. or if the length is greater than 5, then it will show the view all reviews button.
    Either<ErrorResponse, ProductReviewWrapperModel>? response =
        await AppRepository(context).productReviewsFilter(productId, query: {ApiKey.limit: "6", ApiKey.page: "1"}, isLoadMore: false);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        userReviewSubmitted = data.userReviewSubmitted;
        reviewList = (data.dataList)?.map((e) {
              return ReviewDataModel(
                id: e.id,
                userName: e.userIdDetails?.fullName ?? '',
                date: e.createdAt?.changeDateFormat(
                        inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ, outputDateFormat: DateFormatter.dateFormatDDMMYYYY) ??
                    '',
                rating: e.rating ?? 0,
                title: e.title ?? '',
                review: e.description ?? '',
                images: e.displayImage ?? [],
              );
            }).toList() ??
            [];
        if (!isClosed) {
          add(const ProductDetailsReviewsLoadedEvent());
        }
      },
    );
    emit(const ProductDetailsRecentlyViewedLoadedState());
  }

  Future<void> getProductRecentlyViewed(BuildContext context, String productId) async {
    Either<ErrorResponse, JewelleryListingModel>? response =
        await AppRepository(context).getRecentlyViewedProductList(page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        recentlyViewedProductList = data.data.map((e) {
          return ProductDetailsModel(
            suid: e.suid ?? '',
            productId: e.id,
            name: e.productDescription ?? '',
            imageUrl: e.multipleFinishedViewImage.isNotEmpty ? (e.multipleFinishedViewImage.first.imageUrl ?? '') : '',
            originalPrice: e.finalPrice?.toString().setCurrency,
            offerPrice: e.discountPrice?.toString().setCurrency,
            finalPrice: e.discountPrice?.toString().setCurrency,
            discountPercentageString: e.discountEXT,
            productSku: e.contractNoSkuNo,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            isFavourite: e.isFavorite,
            wishlistId: e.wishlistID,
            commodity: Commodity.jewellery,
            subTitle: e.productDescription ?? '',
            title: e.contractNoSkuNo ?? '',
            kgkCollectionName: e.kgkCollection ?? "\n",
            businessCategoryName: e.businessCategoryName ?? "\n",
            cts: e.crtEXT,
            gms: e.gms,
            brandName: e.brandName,
            colorsCode: [
              e.metalColor1HexCode ?? "",
              e.metalColor2HexCode ?? "",
              e.metalColor3HexCode ?? "",
            ],
            isAddedToCart: e.isAddedToCart,
          );
        }).toList();
        add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  Future<void> getDiamondsRecentlyViewed(BuildContext context, String productId) async {
    Either<ErrorResponse, DiamondListingModel>? response = await AppRepository(context)
        .getDiamondRecentlyViewedProductList(page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        recentlyViewedProductList = data.data.map((e) {
          return ProductDetailsModel(
            productId: e.suid ?? '',
            name: e.rmDescription ?? '',
            imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
            originalPrice: e.finalPrice?.toString().setCurrency,
            offerPrice: e.discountPrice?.toString().setCurrency,
            finalPrice: e.discountPrice?.toString().setCurrency,
            discountPercentageString: e.discountEXT,
            productSku: e.lotCode,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            commodity: Commodity.diamond,
            isFavourite: e.isFavorite,
            wishlistId: e.wishlistID,
            subTitle: e.rmDescription ?? '',
            title: e.lotCode ?? '',
          );
        }).toList();
        add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  Future<void> getGemstoneRecentlyViewed(BuildContext context, String productId) async {
    Either<ErrorResponse, GemstoneListingModel>? response = await AppRepository(context)
        .getGemstoneRecentlyViewedProductList(page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        recentlyViewedProductList = data.data.map((e) {
          return ProductDetailsModel(
            productId: e.suid ?? '',
            name: e.rmDescription ?? '',
            imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
            originalPrice: e.finalPrice?.toString().setCurrency,
            offerPrice: e.discountPrice?.toString().setCurrency,
            finalPrice: e.discountPrice?.toString().setCurrency,
            discountPercentageString: e.discountEXT,
            productSku: e.lotCode,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            commodity: Commodity.gemstone,
            isFavourite: e.isFavorite,
            wishlistId: e.wishlistID,
            title: e.suid,
            subTitle: e.rmDescription,
          );
        }).toList();
        if (!isClosed) {
          add(const ProductDetailsReviewsLoadedEvent());
        }
      },
    );
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
  }

  void _onToggleCompareProduct(ToggleCompareProductEvent event, Emitter<ProductDetailsState> emit) {
    try {
      if (productDetails == null) return;
      if (event.context != null) {
        if (!isCompare) {
          BlocProvider.of<CompareProductBloc>(event.context!).add(CompareProductAddProductEvent(
            context: event.context!,
            product: productDetails!,
          ));
        } else {
          BlocProvider.of<CompareProductBloc>(event.context!).add(CompareProductRemoveProductEvent(
            context: event.context!,
            productId: productDetails?.productId ?? '',
          ));
        }
      } else if (event.isCompare != null) {
        isCompare = event.isCompare!;
        emit(ProductCompareToggleState(isCompare));
      }
    } catch (e) {
      printWrapped("Error in _onToggleCompareProduct: $e");
    }
  }

  void _onOnProductCustomizationChange(ProductCustomizationChangeEvent event, Emitter<ProductDetailsState> emit) {
    int oldChildIndex = productCustomizations[event.index].selectedValue != null
        ? (productCustomizations[event.index].values?.indexOf(productCustomizations[event.index].selectedValue!) ?? 0)
        : -1;
    productCustomizations[event.index].selectedValue = productCustomizations[event.index].values?[event.childIndex];
    emit(ProductCustomizationChangeState(event.index, event.childIndex, oldChildIndex));
  }

  void _onRingDetailsToggleEvent(RingDetailsToggleEvent event, Emitter<ProductDetailsState> emit) {
    isRingDetailsOpen = !isRingDetailsOpen;
    emit(RingDetailsToggleState(isRingDetailsOpen));
  }

  void _onProductDiamondDetailsToggleEvent(ProductDiamondDetailsToggleEvent event, Emitter<ProductDetailsState> emit) {
    isDiamondDetailsOpen = !isDiamondDetailsOpen;
    emit(ProductDiamondDetailsToggleState(isDiamondDetailsOpen));
  }

  void _onGemstoneDetailsToggleEvent(GemstoneDetailsToggleEvent event, Emitter<ProductDetailsState> emit) {
    isGemstoneDetailsOpen = !isGemstoneDetailsOpen;
    emit(GemstoneDetailsToggleState(isGemstoneDetailsOpen));
  }

  void _onProductDetailsSuggestedLoadedEvent(ProductDetailsSuggestedLoadedEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsSuggestedLoadedState(suggestedProductList));
  }

  void _onProductDetailsReviewsLoadedEvent(ProductDetailsReviewsLoadedEvent event, Emitter<ProductDetailsState> emit) {
    emit(const ReloadProductDetailsState());
    emit(const ProductDetailsRecentlyViewedLoadedState());
  }

  Future<void> _onProductDetailsWriteReviewEvent(ProductDetailsWriteReviewEvent event, Emitter<ProductDetailsState> emit) async {
    final BuildContext context = event.context;

    /// First check if the user is logged in or not
    if (StorageManager().getIsSkipLogin()) {
      bool isApproved = false;
      await Utils.showLoginRequiredDialog(
        context,
        onApproved: () {
          isApproved = true;
        },
      );
      if (!isApproved) {
        return;
      }
      await _onLoadProductDetails(LoadProductDetailsEvent(context), emit);
      if (userReviewSubmitted) {
        return;
      }
    }
    context.pushNamed(AppRoutes.writeReviewPage, arguments: {
      RoutesData.productId: productDetails?.productId,
      RoutesData.commodity: productDetails?.commodity,
    });
  }

  void navigateBasedOnScreenIdentifierForViewAllSuggestedProducts(BuildContext context,
      {required String productNavigation, String productId = ''}) {
    switch (screenIdentifier) {
      case ScreenIdentifier.productForRing:
        context.pushNamed(AppRoutes.productListGridPage, arguments: {
          RoutesData.isPageFor: ScreenIdentifier.productForRing,
          RoutesData.productId: productId,
          RoutesData.productNavigation: productNavigation,
        });
        break;
      case ScreenIdentifier.productForGemstones:
      case ScreenIdentifier.productForDiamonds:
        context.pushNamed(AppRoutes.stoneListingPage, arguments: {
          RoutesData.isPageFor: screenIdentifier,
          RoutesData.productId: productDetails?.productId,
          RoutesData.productNavigation: productNavigation,
        });
        break;
      default:
        break;
    }
  }

  // Initialize the WishlistUpdaterService
  void _initWishlistUpdaterServiceBloc(BuildContext context) {
    final wishlistUpdaterServiceBloc = BlocProvider.of<WishlistUpdaterServiceBloc>(context);
    wishlistUpdaterServiceStream = wishlistUpdaterServiceBloc.stream.listen(_handleWishlistUpdate);
  }

// Handle wishlist update events
  void _handleWishlistUpdate(WishlistUpdaterServiceState state) {
    if (state is WishListUpdateProductState) {
      try {
        _updateProductDetails(state.productId, state.wishlistId);
        _updateProductList(state);
        _updateRecentlyViewedList(state);
      } catch (e) {
        printWrapped(e.toString());
      }
    }
  }

// Update the appropriate product list based on the screen identifier
  void _updateProductList(WishListUpdateProductState state) {
    List<dynamic> targetList;
    switch (screenIdentifier) {
      case ScreenIdentifier.productForRing:
        targetList = jewelleryDatumListAPI;
        break;
      case ScreenIdentifier.productForDiamonds:
        targetList = diamondDatumListAPI;
        break;
      case ScreenIdentifier.productForGemstones:
        targetList = gemstoneDatumListAPI;
        break;
      default:
        return; // Exit if no matching screen identifier
    }

    final index = targetList.indexWhere((element) => element.id == state.productId);
    if (index != -1) {
      _updateProductDetails(targetList[index], state.wishlistId);
      _updateSuggestedProductList(index, targetList[index]);
    }
  }

// Update product details based on wishlist status
  void _updateProductDetails(String productId, String wishlistId) {
    if (productId == productDetails?.productId) {
      productDetails?.isFavourite = wishlistId.isNotEmpty;
      productDetails?.wishlistId = wishlistId;
    }
  }

// Update the suggested product list
  void _updateSuggestedProductList(int index, dynamic product) {
    suggestedProductList[index].isFavourite = product.isFavorite;
    suggestedProductList[index].wishlistId = product.wishlistID.isNotNullNorEmpty ? product.wishlistID : null;
  }

// Update the recently viewed product list
  void _updateRecentlyViewedList(WishListUpdateProductState state) {
    final recentlyIndex = recentlyViewedProductList.indexWhere((element) => element.productId == state.productId);
    if (recentlyIndex != -1) {
      final product = recentlyViewedProductList[recentlyIndex];
      product.wishlistId = state.wishlistId;
      product.isFavourite = state.wishlistId.isNotEmpty;
    }
  }

  // Copy link
  Future<void> onTapCopyLink({required BuildContext context}) async {
    context.pop();
    await Clipboard.setData(const ClipboardData(text: "https://dev.kgk.magnetoinfotech.com")).then(
      (value) {
        Utils.showMessage(APPStrings.textCopied.tr);
      },
    );
  }

  // Share link
  Future<void> onTapShareLink({required BuildContext context}) async {
    context.pop();
    await Share.share("https://dev.kgk.magnetoinfotech.com");
  }

  void initCompareProductChangesStream(BuildContext context) {
    compareProductStream = BlocProvider.of<CompareProductBloc>(context).stream.listen((state) {
      if (state is CompareProductAddedState) {
        if (state.productIdList.contains(productDetails?.productId)) {
          isCompare = true;
        } else {
          isCompare = false;
        }
        if (!isClosed) {
          add(ToggleCompareProductEvent(isCompare: isCompare));
        }
      }
    });
  }

  void onTapFullImage({required BuildContext context, required int currentIndex}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.transparent,
          child: ProductPhotoViewGallery(imageUrls: imgList, initialIndex: currentIndex),
        );
      },
    );
  }

  void handleBagButtonClick(BuildContext context) {
    if (productDetails == null) return;
    if (!isAddedToCart) {
      BlocProvider.of<AppBloc>(context).onTapBag(context, productDetails: productDetails!);
      isAddedToCart = true;
    } else {
      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
      context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
    }
  }

  void onTap360Image(BuildContext context) {
    if (the3DFile.isNullOrEmpty) return;
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                ModelViewer(
                  backgroundColor: Colors.white,
                  src: the3DFile ?? '',
                  alt: productName,
                  autoRotate: true,
                  cameraControls: true,
                ),
                PositionedDirectional(
                  top: 16.h,
                  start: 16.w,
                  child: SmartImage(
                    path: AppImages.icCross,
                    color: Colors.black,
                    onTap: () {
                      context.pop();
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _getDiamondAuctionDetails(BuildContext context, Emitter<ProductDetailsState> emit) async {
    if (productDetails != null && (productDetails?.auctionId).isNotNullNorEmpty) {
      emit(ProductDetailsAuctionLoadingState());
      Either<ErrorResponse, AuctionDataModel>? response = await AppRepository(context).getAuctionDetails(id: productDetails!.auctionId!);
      await response?.fold((error) => Utils.showMessage(error.message), (data) {
        /// assign auction data
        auctionDataModel = data;
        startingBidPrice = data.startingPrice?.setCurrency ?? '';
        isBidPlaced = data.showPlaceBid ?? false;
        isMyBidPlaced = data.bids.any((bid) => bid.isMyBid == true);
        recentBidList = data.bids.map((bid) {
          return {
            AppConst.dateTimeKey: bid.createdAt?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMM),
            AppConst.priceKey: bid.bidAmount?.setCurrency,
            AppConst.isMyBidKey: bid.isMyBid,
          };
        }).toList();
        auctionEndDuration = DateTime.parse(data.endDate.toString()).difference(DateTime.now());
        add(const ProductDetailsAuctionStartTimerEvent());
      });
      emit(const ProductDetailsAuctionPlaceBidState());
    }
  }

  void _onStartTimer(ProductDetailsAuctionStartTimerEvent event, Emitter<ProductDetailsState> emit) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (auctionEndDuration.compareTo(const Duration(days: 0, hours: 0, minutes: 0, seconds: 0)) > 0) {
        auctionEndDuration -= const Duration(seconds: 1);
        add(ProductDetailsAuctionUpdateTimerEvent(auctionEndDuration));
      } else {
        _timer?.cancel();
        auctionEndDuration = const Duration(days: 0, hours: 0, minutes: 0, seconds: 0);
        add(ProductDetailsAuctionTimerCompletedEvent());
      }
    });
  }

  /// Update Timer
  void _onUpdateTimer(ProductDetailsAuctionUpdateTimerEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsAuctionTimerUpdateState(event.duration));
  }

  /// Timer Completed
  void _onAuctionTimerCompletedEvent(ProductDetailsAuctionTimerCompletedEvent event, Emitter<ProductDetailsState> emit) {
    emit(const ProductDetailsAuctionTimerCompletedState());
  }

  /// Place bid
  Future<void> _onPlaceBidEvent(ProductDetailsAuctionPlaceBidEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoadingState());
    if (_validatePlaceBidEvent(emit)) {
      await createBidForAuction(event.context, emit);
      emit(const ProductDetailsAuctionPlaceBidState());
    }
  }

  /// Create bid for auction
  Future<void> createBidForAuction(BuildContext context, Emitter<ProductDetailsState> emit) async {
    if (productDetails?.auctionId == null) return;
    Map<String, dynamic> body = {ApiKey.auctionId: int.parse(productDetails!.auctionId!), ApiKey.bidAmount: bidAmountController.text};
    Either<ErrorResponse, CommonResponse<dynamic>>? response = await AppRepository(context).createBidForAuction(body);
    await response?.fold((error) async {
      Utils.showMessage(error.message);
    }, (data) async {
      isBidPlaced = true;
      Utils.showMessage(data.message);
      bidAmountController.clear();
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
      );
    });
    await _getDiamondAuctionDetails(context, emit);
  }

  bool _validatePlaceBidEvent(Emitter<ProductDetailsState> emit) {
    bool isValidate = true;
    double? bidAmount = double.tryParse(bidAmountController.text.trim());
    double minBidPrice = auctionDataModel?.startingPriceToDouble ?? 0.0;
    if (bidAmountController.text.trim().isEmpty) {
      bidAmountError = APPStrings.errorBidAmountRequired.tr;
      emit(BidAmountFieldErrorState(fieldType: FieldTypeValidationEnum.bidAmount));
      isValidate = false;
    } else if (bidAmount == null || bidAmount <= minBidPrice) {
      bidAmountError = APPStrings.errorBidAmountGreaterThan.tr;
      emit(BidAmountFieldErrorState(fieldType: FieldTypeValidationEnum.bidAmount));
      isValidate = false;
    }
    return isValidate;
  }

  void _onProductDetailsPlaceBidFieldChangeEvent(ProductDetailsPlaceBidFieldChangeEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsAuctionLoadingState());
    switch (event.fieldType) {
      case FieldTypeValidationEnum.bidAmount:
        bidAmountError = null;
        break;
      default:
        break;
    }
    emit(BidAmountFieldErrorState(fieldType: event.fieldType));
  }

  void getTimerText(ProductDetailsState state) {
    if (auctionDataModel != null && auctionDataModel!.status == "NOT_STARTED") {
      _timerTitle = APPStrings.auctionWillStartOn.tr;
      _timerValue = auctionDataModel!.startDate?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYY) ?? "";
    } else if (state is ProductDetailsAuctionTimerUpdateState) {
      _timerValue = Utils.formatDuration(state.duration);
    } else if (state is AuctionTimerCompletedState) {
      _timerValue = APPStrings.auctionHasEnded.tr;
    } else {
      _timerValue = APPStrings.loading.tr;
    }
  }
}
