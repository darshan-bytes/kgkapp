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

  String get timerTitle => _timerTitle;

  /// Timer title value getter
  String _timerValue = '';

  String get timerValue => _timerValue;

  List<ProductCustomizeDataDatum> productCustomizations = [];

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
  ProductReviewModel? myReview;

  bool userReviewSubmitted = false;

  bool get isShowEditReview => myReview != null && (myReview!.status == AppConst.pending || myReview!.status == AppConst.rejected);

  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;
  StreamSubscription<CompareProductState>? compareProductStream;

  ProductCustomizeData? productCustomizeData;

  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<ToggleCompareProductEvent>(_onToggleCompareProduct);
    on<ProductCustomizationChangeEvent>(_onOnProductCustomizationChange);
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
    on<ProductDetailsAddInquiryEvent>(_onProductDetailsAddInquiryEvent);
    on<ProductDetailsAddToCartEvent>(_onProductDetailsAddToCartEvent);
    on<ProductDetailsGetCustomizationNameEvent>(
      _onProductDetailsGetCustomizationName,
      transformer: BlocEventDeBouncer.debounceTransformer(),
    );
  }

  bool get canCompare =>
      !isCustomisation &&
      (screenIdentifier == ScreenIdentifier.productForRing ||
          screenIdentifier == ScreenIdentifier.productForDiamonds ||
          screenIdentifier == ScreenIdentifier.productForGemstones);

  bool get canAddToWishlist =>
      screenIdentifier == ScreenIdentifier.productForRing ||
      screenIdentifier == ScreenIdentifier.productForDiamonds ||
      screenIdentifier == ScreenIdentifier.productForGemstones;

  bool get hasComponents =>
      screenIdentifier == ScreenIdentifier.productForRing ||
      screenIdentifier == ScreenIdentifier.productForGemstones ||
      screenIdentifier == ScreenIdentifier.productForLibraryDesign ||
      screenIdentifier == ScreenIdentifier.productForLibraryCAD ||
      screenIdentifier == ScreenIdentifier.productForLibraryStyle ||
      screenIdentifier == ScreenIdentifier.productForLibrarySKU;

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
  }

  Future<void> _loadProductDetails(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    _clearProductData();
    if (isClosed) return;
    if (!isCustomisation) {
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
        case ScreenIdentifier.productForLibraryDesign:
          await _handleDesignLibraryProduct(event, emit);
          break;
        case ScreenIdentifier.productForLibraryCAD:
        case ScreenIdentifier.productForLibraryStyle:
          await _handleCadLibraryProduct(event, emit);
          break;
        case ScreenIdentifier.productForLibrarySKU:
          await _handleSkuLibraryProduct(event, emit);
          break;
        default:
          break;
      }
    } else {
      /// set up customizations
      await getCustomizationData(event, productId, emit);
    }
    if (isClosed) return;
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
    await getDiamondsRecentlyViewed(event.context, productId);
    await getDiamondYouMayLike(event.context, productId);
  }

  Future<void> _handleGemstoneProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    await StorageManager().setRecentlyViewedGemstones(productId);
    if (isClosed) return;
    await getGemstoneDetails(event.context, productId);
    _emitLoadedStateIfAvailable(event, emit);
    await getGemstoneRecentlyViewed(event.context, productId);
    await getGemstoneYouMayLike(event.context, productId);
  }

  Future<void> _handleRingProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoadingState());
    if (isClosed) return;
    await StorageManager().setRecentlyViewedJewellery(productId);
    if (isClosed) return;
    await getProductDetails(event.context, productId);
    if (isClosed) return;
    _emitLoadedStateIfAvailable(event, emit);
    await productReviewsFilter(event.context, productId, emit);
    await getProductRecentlyViewed(event.context, productId);
    await getProductYouMayLike(event.context, productId);
  }

  Future<void> _handleDesignLibraryProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoadingState());
    if (isClosed) return;
    await getDesignLibraryDetails(event.context, productId);
    if (isClosed) return;
    _emitLoadedStateIfAvailable(event, emit);
  }

  Future<void> _handleCadLibraryProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (isClosed) return;
    emit(ProductDetailsLoadingState());
    await getCadOrStyleLibraryDetails(event.context, productId);
    _emitLoadedStateIfAvailable(event, emit);
  }

  Future<void> _handleSkuLibraryProduct(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    emit(ProductDetailsLoadingState());
    await getSkuLibraryDetails(event.context, productId);
    _emitLoadedStateIfAvailable(event, emit);
  }

  void _emitLoadedStateIfAvailable(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) {
    if (productDetails != null) {
      isCompare = BlocProvider.of<CompareProductBloc>(event.context).productIdList.contains(productDetails!.productId);
      emit(ProductDetailsLoadedState(productDetails!));
    }
  }

  void _setupCustomizations({required BuildContext context}) {
    productCustomizations = productCustomizeData?.data ?? [];
    if (productCustomizeData?.productCustomizeDataDefault != null) {
      Map<String, dynamic> productCustomizeDataDefaultMap = productCustomizeData!.productCustomizeDataDefault ?? {};
      for (int i = 0; i < productCustomizations.length; i++) {
        ProductCustomizeDataDatum productCustomizeDataDatum = productCustomizations[i];
        List<ProductCustomizationOptions> data = productCustomizeDataDatum.data;

        for (int i = 0; i < data.length; i++) {
          ProductCustomizationOptions productCustomizationOptions = data[i];
          if (productCustomizationOptions.variants.isNotEmpty) {
            for (int v0 = 0; v0 < productCustomizationOptions.variants.length; v0++) {
              Variant variant = productCustomizationOptions.variants[v0];
              variant.selectedVariantDatum = variant.data.firstWhereOrNull((element) => element.isDefault?.toLowerCase() == 'yes');
              productCustomizationOptions.variants[v0] = variant;
            }
          }
        }

        // Select Default Value
        productCustomizeDataDatum.selectedValue = productCustomizeDataDatum.data.firstWhereOrNull(
          (element) => element.code == productCustomizeDataDefaultMap[productCustomizeDataDatum.slug],
        );
      }

      add(ProductDetailsGetCustomizationNameEvent(context: context));
    }
  }

  Future<void> getDiamondsDetails(BuildContext context, String productId) async {
    if (isClosed) return;
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

          /// Below line is commented because the3DFile is not available in the response.
          // the3DFile = diamondData?.image.firstWhereOrNull((element) => element.the3DFile.isNotNullNorEmpty)?.the3DFile;
          videoUrl = diamondData?.video;
          isAddedToCart = diamondData!.isAddedToCart;
          productName = diamondData!.rmDescription ?? '';
          imgList = diamondData!.image.map((e) => e.url ?? '').toList();
          productDetails = Utils.convertDiamondDataModelToProductDetailsModel(diamond: diamondData!);
        }
      },
    );
  }

  Future<void> getGemstoneDetails(BuildContext context, String productId) async {
    if (isClosed) return;
    Either<ErrorResponse, GemstoneDatum>? response = await AppRepository(context).getGemstoneDetailById(productId);
    response?.fold(
      (error) {
        isErrorInLoadingData = true;
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        if (isClosed) return;
        gemstoneData = data;
        if (gemstoneData != null) {
          isErrorInLoadingData = false;
          isAddedToCart = gemstoneData!.isAddedToCart;
          productName = gemstoneData?.rmDescription ?? '';
          if (gemstoneData?.image.isNotEmpty ?? false) {
            imgList = gemstoneData!.image.map((e) => e.url ?? '').toList();
          }
          productDetails = Utils.convertGemstoneDatumToProductDetailsModel(gemstone: gemstoneData!);
        }
      },
    );
  }

  Future<void> getDiamondYouMayLike(BuildContext context, String productId) async {
    if (isClosed) return;
    Either<ErrorResponse, DiamondListingModel>? response = await AppRepository(
      context,
    ).getDiamondYouMayLike(productId, limit: AppConst.pageLimit10.toString(), page: AppConst.page1.toString(), isShowLoader: false);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) Utils.showMessage(error.message);
      },
      (data) {
        if (data.data.isNotEmpty) {
          diamondDatumListAPI = data.data;
          suggestedProductList =
              diamondDatumListAPI.map((diamond) => Utils.convertDiamondDataModelToProductDetailsModel(diamond: diamond)).toList();
          if (!isClosed) add(const ProductDetailsSuggestedLoadedEvent());
        }
      },
    );
  }

  Future<void> getGemstoneYouMayLike(BuildContext context, String productId) async {
    if (isClosed) return;
    final Either<ErrorResponse, GemstoneListingModel>? response = await AppRepository(
      context,
    ).getGemstoneYouMayLike(productId, page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());

    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) Utils.showMessage(error.message!);
      },
      (data) {
        if (data.data.isEmpty) return;
        gemstoneDatumListAPI = data.data;
        suggestedProductList = data.data.map((gemstone) => Utils.convertGemstoneDatumToProductDetailsModel(gemstone: gemstone)).toList();
        add(const ProductDetailsSuggestedLoadedEvent());
      },
    );
  }

  Future<void> getProductYouMayLike(BuildContext context, String productId) async {
    if (isClosed) return;
    Either<ErrorResponse, JewelleryListingModel>? response = await AppRepository(
      context,
    ).getJewelleryYouMayLike(productId, page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) Utils.showMessage(error.message);
      },
      (data) {
        if (isClosed) return;
        jewelleryDatumListAPI = data.data;
        suggestedProductList =
            data.data.map((jewellery) => Utils.convertJewelleryDataModelToProductDetailsModel(jewellery: jewellery)).toList();
        if (!isClosed) add(const ProductDetailsSuggestedLoadedEvent());
      },
    );
  }

  Future<void> getProductDetails(BuildContext context, String productId) async {
    if (isClosed) return;
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
        imgList = [];
        // This image value logic is handled in extension methods.
        imgList = jewelleryData.imageListEXT;
        the3DFile = jewelleryData.multipleFinishedViewImage.firstWhereOrNull((element) => element.the3DFile.isNotNullNorEmpty)?.the3DFile;
        videoUrl = jewelleryData.multipleFinishedViewImage.firstWhereOrNull((element) => element.videoUrl.isNotNullNorEmpty)?.videoUrl;
        productDetails = Utils.convertJewelleryDataModelToProductDetailsModel(jewellery: jewelleryData);
      },
    );
  }

  Future<void> getDesignLibraryDetails(BuildContext context, String productId) async {
    try {
      if (isClosed) return;
      Either<ErrorResponse, DesignLibraryListItemDataModel>? response = await AppRepository(context).designLibraryDetails(id: productId);
      response?.fold(
        (error) {
          isErrorInLoadingData = true;
          if (error.message.isNotNullNorEmpty) {
            Utils.showMessage(error.message);
          }
        },
        (DesignLibraryListItemDataModel designLibraryData) {
          if (isClosed) return;
          isErrorInLoadingData = false;
          isAddedToCart = designLibraryData.isAddedToCart;
          productName = designLibraryData.productDescription ?? '';

          imgList = [];
          for (MultipleFinishedViewImage element in (designLibraryData.multipleFinishedViewImage ?? [])) {
            if (element.multiAngleUrl.isNotNullNorEmpty) {
              for (var multiAngleUrl in element.multiAngleUrl) {
                imgList.add(multiAngleUrl.url ?? '');
              }
            }
          }
          if (imgList.isEmpty) imgList.add('');
          productDetails = ProductDetailsModel(
            productId: designLibraryData.suid,
            suid: designLibraryData.suid,
            name: productName,
            jewelleryType: designLibraryData.jewelleryType,
            productSku: designLibraryData.contractNoSkuNo,
            imageUrl:
                designLibraryData.multipleFinishedViewImage.isNullOrEmpty
                    ? ''
                    : designLibraryData.multipleFinishedViewImage?[0].imageUrl ?? '',
            commodity: Commodity.designLibrary,
            components: designLibraryData.components,
          );
        },
      );
    } catch (e) {
      debugPrint("Error in getDesignLibraryDetails: $e");
    }
  }

  Future<void> getCadOrStyleLibraryDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, CadLibraryListItemDataModel>? response;
    try {
      if (screenIdentifier == ScreenIdentifier.productForLibraryCAD) {
        response = await AppRepository(context).cadLibraryDetails(id: productId);
      } else if (screenIdentifier == ScreenIdentifier.productForLibraryStyle) {
        response = await AppRepository(context).styleLibraryDetails(id: productId);
      }

      response?.fold(
        (error) {
          isErrorInLoadingData = true;
          if (error.message.isNotNullNorEmpty) {
            Utils.showMessage(error.message);
          }
        },
        (CadLibraryListItemDataModel designLibraryData) {
          if (isClosed) return;
          isErrorInLoadingData = false;
          isAddedToCart = designLibraryData.isAddedToCart;
          productName = designLibraryData.productDescription ?? '';

          imgList = [];
          for (MultipleFinishedViewImage element in (designLibraryData.multipleFinishedViewImage ?? [])) {
            if (element.multiAngleUrl.isNotNullNorEmpty) {
              for (var multiAngleUrl in element.multiAngleUrl) {
                imgList.add(multiAngleUrl.url ?? '');
              }
            }
          }
          if (imgList.isEmpty) imgList.add('');
          productDetails = ProductDetailsModel(
            productId: designLibraryData.suid,
            suid: designLibraryData.suid,
            name: productName,
            jewelleryType: designLibraryData.jewelleryType,
            productSku: designLibraryData.contractNoSkuNo,
            imageUrl:
                designLibraryData.multipleFinishedViewImage.isNullOrEmpty
                    ? ''
                    : designLibraryData.multipleFinishedViewImage?[0].imageUrl ?? '',
            components: designLibraryData.components,
            commodity: screenIdentifier == ScreenIdentifier.productForLibraryCAD ? Commodity.cadLibrary : Commodity.styleLibrary,
          );
        },
      );
    } catch (e) {
      debugPrint("Error in getDesignLibraryDetails: $e");
    }
  }

  Future<void> getSkuLibraryDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, SkuLibraryListItemDataModel>? response;
    try {
      response = await AppRepository(context).skuLibraryDetails(id: productId);

      response?.fold(
        (error) {
          isErrorInLoadingData = true;
          if (error.message.isNotNullNorEmpty) {
            Utils.showMessage(error.message);
          }
        },
        (SkuLibraryListItemDataModel skuLibraryData) {
          isErrorInLoadingData = false;
          isAddedToCart = skuLibraryData.isAddedToCart;
          productName = skuLibraryData.productDescription ?? '';
          imgList = [];
          for (MultipleFinishedViewImage element in (skuLibraryData.multipleFinishedViewImage)) {
            imgList.add(element.imageUrl ?? '');
            if (element.multiAngleUrl.isNotNullNorEmpty) {
              for (var multiAngleUrl in element.multiAngleUrl) {
                imgList.add(multiAngleUrl.url ?? '');
              }
            }
          }
          if (imgList.isEmpty) imgList.add('');
          productDetails = ProductDetailsModel(
            productId: skuLibraryData.suid,
            suid: skuLibraryData.suid,
            name: productName,
            jewelleryType: skuLibraryData.jewelleryType,
            productSku: skuLibraryData.skuNo,
            imageUrl:
                skuLibraryData.multipleFinishedViewImage.isNullOrEmpty ? '' : skuLibraryData.multipleFinishedViewImage[0].imageUrl ?? '',
            components: skuLibraryData.components,
            commodity: Commodity.skuLibrary,
          );
        },
      );
    } catch (e) {
      debugPrint("Error in getDesignLibraryDetails: $e");
    }
  }

  Future<void> productReviewsFilter(
    BuildContext context,
    String productId,
    Emitter<ProductDetailsState> emit, {
    bool isLoadMore = false,
  }) async {
    if (isClosed) return;
    emit(const ReloadProductDetailsState());
    Map<String, String> query = {ApiKey.productId_: productId, ApiKey.limit: "6", ApiKey.page: "1", ApiKey.status: AppConst.accepted};
    // Here requested 6 reviews only for the first page. if the list's length is less than 6, then it will show the available reviews. or if the length is greater than 5, then it will show the view all reviews button.
    Either<ErrorResponse, ProductReviewWrapperModel>? response = await AppRepository(
      context,
    ).productReviewsFilter(query: query, isLoadMore: isLoadMore);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        if (isClosed) return;
        userReviewSubmitted = data.userReviewSubmitted;
        myReview = data.myReview;
        if (myReview != null) {
          data.dataList?.removeWhere((element) => element.id == myReview?.id);
          data.dataList?.insert(0, myReview!);
        }
        reviewList =
            (data.dataList)?.map((e) {
              return ReviewDataModel(
                id: e.id,
                userName: e.userIdDetails?.fullName ?? '',
                date:
                    e.createdAt?.changeDateFormat(
                      inputDateFormat: DateFormatter.dateFormatYYYYMMDDTHHMMSSMMMZ,
                      outputDateFormat: DateFormatter.dateFormatDDMMYYYY,
                    ) ??
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
    if (isClosed) return;
    Either<ErrorResponse, JewelleryListingModel>? response = await AppRepository(
      context,
    ).getRecentlyViewedProductList(page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) Utils.showMessage(error.message);
      },
      (JewelleryListingModel jewelleryListingModel) {
        if (isClosed) return;
        recentlyViewedProductList =
            jewelleryListingModel.data
                .map((jewellery) => Utils.convertJewelleryDataModelToProductDetailsModel(jewellery: jewellery))
                .toList();
        if (!isClosed) add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  Future<void> getDiamondsRecentlyViewed(BuildContext context, String productId) async {
    if (isClosed) return;
    Either<ErrorResponse, DiamondListingModel>? response = await AppRepository(
      context,
    ).getDiamondRecentlyViewedProductList(page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) Utils.showMessage(error.message);
      },
      (DiamondListingModel diamondDataModel) {
        recentlyViewedProductList =
            diamondDataModel.data.map((diamond) => Utils.convertDiamondDataModelToProductDetailsModel(diamond: diamond)).toList();
        if (!isClosed) add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  Future<void> getGemstoneRecentlyViewed(BuildContext context, String productId) async {
    if (isClosed) return;
    Either<ErrorResponse, GemstoneListingModel>? response = await AppRepository(
      context,
    ).getGemstoneRecentlyViewedProductList(page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString());
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) Utils.showMessage(error.message);
      },
      (GemstoneListingModel gemstoneDataModel) {
        recentlyViewedProductList =
            gemstoneDataModel.data.map((gemstone) => Utils.convertGemstoneDatumToProductDetailsModel(gemstone: gemstone)).toList();
        if (!isClosed) add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
    isCustomisation = context.mounted ? (context.routesData?[RoutesData.isCustomisationPage] ?? false) : false;
  }

  Future<void> _onToggleCompareProduct(ToggleCompareProductEvent event, Emitter<ProductDetailsState> emit) async {
    if (isClosed) return;
    Completer<bool>? completer;
    try {
      if (productDetails == null) return;
      if (event.context != null) {
        if (!isCompare) {
          completer = Completer<bool>();
          BlocProvider.of<CompareProductBloc>(event.context!).add(
            CompareProductAddProductEvent(
              context: event.context!,
              product: productDetails!,
              onProductAdded: () {
                isCompare = true;
                emit(ProductCompareToggleState(isCompare));
                completer?.complete(true);
              },
            ),
          );
        } else {
          isCompare = false;
          BlocProvider.of<CompareProductBloc>(
            event.context!,
          ).add(CompareProductRemoveProductEvent(context: event.context!, productId: productDetails?.suid ?? ''));
        }
        emit(ProductCompareToggleState(isCompare));
      } else if (event.isCompare != null) {
        isCompare = event.isCompare!;
        emit(ProductCompareToggleState(isCompare));
      }
      if (completer != null) {
        await completer.future;
      }
    } catch (e) {
      printWrapped("Error in _onToggleCompareProduct: $e");
    }
  }

  void _onOnProductCustomizationChange(ProductCustomizationChangeEvent event, Emitter<ProductDetailsState> emit) {
    int oldChildIndex = 0;
    if (event.isVariant) {
      oldChildIndex =
          productCustomizations[event.index].selectedValue?.variants[event.childIndex].selectedVariantDatum != null
              ? (productCustomizations[event.index].selectedValue!.variants[event.childIndex].data.indexOf(
                (productCustomizations[event.index].selectedValue!.variants[event.childIndex].selectedVariantDatum!),
              ))
              : -1;
      productCustomizations[event.index].selectedValue?.variants[event.childIndex].selectedVariantDatum =
          productCustomizations[event.index].selectedValue?.variants[event.childIndex].data[event.selectedVariantIndex ?? 0];
    } else {
      oldChildIndex =
          productCustomizations[event.index].selectedValue != null
              ? (productCustomizations[event.index].data.indexOf(productCustomizations[event.index].selectedValue!))
              : -1;
      productCustomizations[event.index].selectedValue = productCustomizations[event.index].data[event.childIndex];
    }
    emit(ProductCustomizationChangeState(event.index, event.childIndex, oldChildIndex, event.isVariant));
    add(ProductDetailsGetCustomizationNameEvent(context: event.context));
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
    await context
        .pushNamed(
          AppRoutes.writeReviewPage,
          arguments: {
            RoutesData.productId: productDetails?.productId,
            RoutesData.commodity: productDetails?.commodity,
            RoutesData.myReview: myReview,
          },
        )
        .then((val) async {
          if (val != null && val[RoutesData.isEdited] == true) {
            await productReviewsFilter(context, productId, emit, isLoadMore: true);
          }
        });
  }

  void navigateBasedOnScreenIdentifierForViewAllSuggestedProducts(
    BuildContext context, {
    required String productNavigation,
    String productId = '',
  }) {
    switch (screenIdentifier) {
      case ScreenIdentifier.productForRing:
        context.pushNamed(
          AppRoutes.productListGridPage,
          arguments: {
            RoutesData.isPageFor: ScreenIdentifier.productForRing,
            RoutesData.productId: productId,
            RoutesData.productNavigation: productNavigation,
          },
        );
        break;
      case ScreenIdentifier.productForGemstones:
      case ScreenIdentifier.productForDiamonds:
        context.pushNamed(
          AppRoutes.stoneListingPage,
          arguments: {
            RoutesData.isPageFor: screenIdentifier,
            RoutesData.productId: productDetails?.productId,
            RoutesData.productNavigation: productNavigation,
          },
        );
        break;
      default:
        break;
    }
  }

  // Initialize the WishlistUpdaterService
  void _initWishlistUpdaterServiceBloc(BuildContext context) {
    try {
      final wishlistUpdaterServiceBloc = BlocProvider.of<WishlistUpdaterServiceBloc>(context);
      wishlistUpdaterServiceStream = wishlistUpdaterServiceBloc.stream.listen(_handleWishlistUpdate);
    } catch (e) {
      debugPrint('Error in _initWishlistUpdaterServiceBloc: $e');
    }
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
    if (productId == productDetails?.suid) {
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

  void initCompareProductChangesStream(BuildContext context) {
    compareProductStream = BlocProvider.of<CompareProductBloc>(context).stream.listen((state) {
      if (state is CompareProductAddedState) {
        if (state.productIdList.contains(productDetails?.suid)) {
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

  Future<void> handleBagButtonClick(BuildContext context, Emitter<ProductDetailsState> emit) async {
    if (productDetails == null) return;
    emit(ProductDetailsReload());
    if (!isAddedToCart) {
      if (isCustomisation) {
        await _onProductDetailsAddToBagCustomizationEvent(context, emit);
      } else {
        Completer<void> completer = Completer<void>();
        BlocProvider.of<AppBloc>(context).onTapBag(
          context,
          productDetails: productDetails!,
          onProductAdded: () {
            isAddedToCart = true;
            productDetails?.isAddedToCart = true;
            emit(ProductDetailsLoadedState(productDetails!));
            completer.complete();
          },
        );
        await completer.future;
      }
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
                ModelViewer(backgroundColor: Colors.white, src: the3DFile ?? '', alt: productName, autoRotate: true, cameraControls: true),
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
    if (isClosed) return;
    if (productDetails != null && (productDetails?.auctionId).isNotNullNorEmpty) {
      emit(ProductDetailsAuctionLoadingState());
      Either<ErrorResponse, AuctionDataModel>? response = await AppRepository(context).getAuctionDetails(id: productDetails!.auctionId!);
      await response?.fold((error) => Utils.showMessage(error.message), (data) {
        /// assign auction data
        auctionDataModel = data;
        startingBidPrice = data.startingPrice?.setCurrency ?? '';
        isBidPlaced = data.showPlaceBid ?? false;
        isMyBidPlaced = data.bids.any((bid) => bid.isMyBid == true);
        recentBidList =
            data.bids.map((bid) {
              return {
                AppConst.dateTimeKey: bid.createdAt?.toLocal().dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMYYYYHHMMA),
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
    await response?.fold(
      (error) async {
        Utils.showMessage(error.message);
      },
      (data) async {
        isBidPlaced = true;
        Utils.showMessage(data.message);
        bidAmountController.clear();
        Scrollable.ensureVisible(targetKey.currentContext!, duration: const Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
      },
    );
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

  //_onProductDetailsAddInquiryEvent
  Future<void> _onProductDetailsAddInquiryEvent(ProductDetailsAddInquiryEvent event, Emitter<ProductDetailsState> emit) async {}

  void getTimerText(ProductDetailsState state) {
    if (auctionDataModel != null && auctionDataModel!.status == "NOT_STARTED") {
      _timerTitle = APPStrings.auctionWillStartOn.tr;
      _timerValue = auctionDataModel!.startDate?.dateToStringFormat(outputDateFormat: DateFormatter.dateFormatDDMMMYYYY) ?? "";
    } else if (state is ProductDetailsAuctionTimerUpdateState) {
      _timerValue = Utils.formatDuration(state.duration);
    } else if (state is ProductDetailsAuctionTimerCompletedState) {
      _timerValue = APPStrings.auctionHasEnded.tr;
    } else {
      _timerValue = APPStrings.loading.tr;
    }
  }

  void handleVideoTap(BuildContext context) {
    if (videoUrl.isNullOrEmpty) return;

    if (productDetails?.commodity == Commodity.jewellery) {
      showDialog(
        context: context,
        builder: (context) {
          return ProductVideoWidget(path: videoUrl!);
        },
      );
    } else if (productDetails?.commodity == Commodity.diamond) {
      context.pushNamed(
        AppRoutes.cmsWebViewPage,
        arguments: {RoutesData.cmsPageData: CmsWebViewDataModel(url: videoUrl, showLoader: true)},
      );
    }
  }

  Future<void> _onProductDetailsAddToCartEvent(ProductDetailsAddToCartEvent event, Emitter<ProductDetailsState> emit) async {
    await handleBagButtonClick(event.context, emit);
  }

  Future<void> getCustomizationData(LoadProductDetailsEvent event, String productId, Emitter<ProductDetailsState> emit) async {
    if (isClosed || productId.isEmpty) return;
    Either<ErrorResponse, ProductCustomizeData>? response = await AppRepository(event.context).getCustomization(id: productId);
    response?.fold(
      (error) {
        isErrorInLoadingData = true;
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message);
        }
      },
      (data) {
        if (isClosed) return;
        isErrorInLoadingData = false;
        productCustomizeData = data;

        _setupCustomizations(context: event.context);
        emit(ProductDetailsLoadedState(ProductDetailsModel()));
      },
    );
  }

  Future<void> _onProductDetailsGetCustomizationName(
    ProductDetailsGetCustomizationNameEvent event,
    Emitter<ProductDetailsState> emit,
  ) async {
    await _getCustomizationName(event.context, productId, emit);
  }

  Future<void> _getCustomizationName(BuildContext context, String productId, Emitter<ProductDetailsState> emit) async {
    if (isClosed || productId.isEmpty) return;
    final Map<String, dynamic> body = {ApiKey.suid: productId};

    for (final customization in productCustomizations) {
      if (customization.selectedValue != null) {
        body[customization.slug ?? ''] = customization.selectedValue?.code;
        if (customization.selectedValue!.variants.isNotEmpty) {
          for (final variantData in customization.selectedValue!.variants) {
            if (variantData.selectedVariantDatum != null) {
              body[variantData.slug ?? ''] = variantData.selectedVariantDatum?.code;
            }
          }
        }
      }
    }

    Either<ErrorResponse, ProductCustomizeData>? response = await AppRepository(context).getCustomizationName(body: body);
    response?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (data) {
        if (isClosed) return;
        isErrorInLoadingData = false;
        productName = data.name ?? '';

        try {
          if (data.applicable.isNotEmpty) {
            data.applicable.forEach((key, value) {
              int index = productCustomizations.indexWhere((element) => element.slug == key);
              if (index != -1) {
                ProductCustomizeDataDatum productCustomizeDataDatum = productCustomizations[index];
                for (int i = 0; i < productCustomizeDataDatum.data.length; i++) {
                  productCustomizeDataDatum.data[i].isApplicable = (value).contains(productCustomizeDataDatum.data[i].code);
                }
                productCustomizations[index] = productCustomizeDataDatum;
              }
            });
          }
        } catch (e) {
          debugPrint("Error in _getCustomizationName: $e");
        }

        productDetails = ProductDetailsModel(
          productId: productId,
          name: productName,
          commodity: Commodity.customization,
          originalPrice: data.price,
        );
        emit(ProductDetailsLoadedState(productDetails!));
      },
    );
  }

  // Customization product Add to bag
  Future<void> _onProductDetailsAddToBagCustomizationEvent(BuildContext context, Emitter<ProductDetailsState> emit) async {
    final MyBagBloc myBagBloc = BlocProvider.of<MyBagBloc>(context);
    final String bagId = StorageManager.instance.getBagId() ?? '';
    if (myBagBloc.commodity != Commodity.customization) {
      bool isConfirm = false;
      await Utils.showSmartModalBottomSheet(
        context: context,
        builder: (thisContext) {
          return ConfirmationDialog(
            title: APPStrings.differentCommoditiesSelected.tr,
            message: APPStrings.cantAddProductFromDifferentCommodities.tr,
            onDeniedText: APPStrings.cancel.tr,
            onApprovedText: APPStrings.strContinue.tr,
            onDenied: () {
              isConfirm = false;
              thisContext.pop();
            },
            onApproved: () {
              isConfirm = true;
              thisContext.pop();
            },
          );
        },
      );
      if (!isConfirm) return;

      Map<String, dynamic> body = {ApiKey.id: bagId};

      await AppRepository(context).deleteBag(body: body);
      await StorageManager().clearBagData();
    }
    if (isClosed || bagId.isEmpty) return;
    final Map<String, dynamic> body = {ApiKey.suid: productId, ApiKey.id: bagId, ApiKey.quantity: 1};

    final Map<String, dynamic> customizationData = {};
    for (final customization in productCustomizations) {
      if (customization.selectedValue != null) {
        customizationData[customization.slug ?? ''] = customization.selectedValue?.code;
        if (customization.selectedValue!.variants.isNotEmpty) {
          for (final variantData in customization.selectedValue!.variants) {
            if (variantData.selectedVariantDatum != null) {
              customizationData[variantData.slug ?? ''] = variantData.selectedVariantDatum?.code;
            }
          }
        }
      }
    }

    body[ApiKey.customizationData] = jsonEncode(customizationData);
    final Either<ErrorResponse, BagListDataModel>? result = await AppRepository(context).getCustomizationBag(body: body);

    result?.fold(
      (error) {
        Utils.showMessage(error.message);
      },
      (data) {
        if (isClosed) return;
        isAddedToCart = true;
        productDetails?.isAddedToCart = true;
        emit(ProductDetailsLoadedState(productDetails!));
      },
    );
  }
}
