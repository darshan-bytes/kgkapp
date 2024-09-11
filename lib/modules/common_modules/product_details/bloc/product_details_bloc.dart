import 'package:kgk/kgk.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  bool isInitialized = false;

  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  String productName = '';
  ProductDetailsModel? productDetails;
  DiamondDataModel? diamondData;
  GemstoneDatum? gemstoneData;
  bool isCustomisation = false;
  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;
  final CarouselSliderController controller = CarouselSliderController();
  final ScrollController youMayLikeScrollController = ScrollController();
  final ScrollController recentViewScrollController = ScrollController();

  List<String> imgList = [];
  int current = 0;
  bool isCompare = false;

  bool isErrorInLoadingData = false;

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

  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;

  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<ToggleCompareProductEvent>(_onToggleCompareProduct);
    on<ProductCustomizationChangeEvent>(_onOnProductCustomizationChange);
    on<RingDetailsToggleEvent>(_onRingDetailsToggleEvent);
    on<ProductDiamondDetailsToggleEvent>(_onProductDiamondDetailsToggleEvent);
    on<GemstoneDetailsToggleEvent>(_onGemstoneDetailsToggleEvent);
    on<ProductDetailsSuggestedProductLoadedEvent>(_onProductDetailsSuggestedProductLoadedEvent);
    on<ProductDetailsReviewsLoadedEvent>(_onProductDetailsReviewsLoadedEvent);
  }

  @override
  Future<void> close() async {
    wishlistUpdaterServiceStream?.cancel();
    super.close();
  }

  Future<void> _onLoadProductDetails(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (isInitialized) return;
    isInitialized = true;
    emit(ProductDetailsLoadingState());
    // assigning current userType
    userType = BlocProvider.of<AppBloc>(event.context).userType;

    getScreenIdentifier(event.context);
    String productId = event.context.routesData?[RoutesData.productId] ?? '--';
    if (screenIdentifier == ScreenIdentifier.productForDiamonds) {
      productCustomizations.clear();
      imgList.clear();
      suggestedProductList.clear();
      await getDiamondsDetails(event.context, productId);
      await getDiamondYouMayLike(event.context, productId);
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      productCustomizations.clear();
      imgList.clear();
      suggestedProductList.clear();
      recentlyViewedProductList.clear();
      await getGemstoneDetails(event.context, productId);
      await getGemstoneYouMayLike(event.context, productId);
    } else if (screenIdentifier == ScreenIdentifier.productForRing) {
      imgList.clear();
      suggestedProductList.clear();
      recentlyViewedProductList.clear();

      await getProductDetails(event.context, productId);
      if (productDetails != null) {
        emit(ProductDetailsLoadedState(productDetails!));
      }
      await getProductYouMayLike(event.context, productId);
      await productReviewsFilter(event.context, productId);
      await getProductRecentlyViewed(event.context, productId);
    }

    isCustomisation = event.context.routesData?[RoutesData.isCustomisationPage] ?? false;

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
          Utils.showMessage(error.message ?? '');
        }
      },
      (data) {
        diamondData = data;
        if (diamondData != null) {
          isErrorInLoadingData = false;
          bool isDiscounted =
              diamondData!.discountPercentage != null && (diamondData!.discountPercentage is num) && diamondData!.discountPercentage > 0;
          productName = diamondData!.rmDescription ?? '';
          imgList = diamondData!.image.map((e) => e.url ?? '').toList();
          productDetails = ProductDetailsModel(
            productId: productId,
            name: productName,
            offerPrice: isDiscounted ? diamondData!.discountPrice?.setCurrency : null,
            originalPrice: diamondData!.finalPrice?.setCurrency,
            discountPercentage:
                isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([diamondData!.discountPercentage]) : null,
            productSku: diamondData!.lotCode,
            reviewCount: diamondData!.reviewCount,
            rating: diamondData!.rating?.toDouble(),
            commodity: Commodity.diamond,
            isFavourite: diamondData?.isFavorite ?? false,
            wishlistId: diamondData?.wishlistID,
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
          Utils.showMessage(error.message ?? '');
        }
      },
      (data) {
        gemstoneData = data;
        if (gemstoneData != null) {
          isErrorInLoadingData = false;
          bool isDiscounted = gemstoneData?.discountPercentage != null &&
              (gemstoneData?.discountPercentage is num) &&
              (gemstoneData?.discountPercentage ?? 0) > 0;
          productName = gemstoneData?.rmDescription ?? '';
          if (gemstoneData?.image.isNotEmpty ?? false) {
            imgList = gemstoneData!.image.map((e) => e.url ?? '').toList();
          }
          productDetails = ProductDetailsModel(
            productId: productId,
            name: productName,
            offerPrice: isDiscounted ? gemstoneData?.discountPrice?.setCurrency : null,
            originalPrice: gemstoneData?.finalPrice?.setCurrency,
            discountPercentage:
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
          );
        }
      },
    );
  }

  Future<void> getDiamondYouMayLike(BuildContext context, String productId) async {
    Either<ErrorResponse, DiamondListingModel>? response =
        await AppRepository(context).getDiamondYouMayLike(productId, limit: '10', page: '1');
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message ?? '');
        }
      },
      (data) {
        if (data.data.isNotEmpty) {
          diamondDatumListAPI = data.data;
          suggestedProductList = diamondDatumListAPI.map((e) {
            bool isDiscounted = e.discountPercentage != null && (e.discountPercentage is num) && e.discountPercentage > 0;
            return ProductDetailsModel(
              productId: e.suid ?? '',
              name: e.rmDescription ?? '',
              imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
              offerPrice: isDiscounted ? e.discountPrice?.setCurrency : null,
              originalPrice: e.finalPrice?.setCurrency,
              discountPercentage: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([e.discountPercentage]) : null,
              productSku: e.lotCode,
              reviewCount: e.reviewCount,
              rating: e.rating?.toDouble(),
              commodity: Commodity.diamond,
              isFavourite: e.isFavorite,
              wishlistId: e.wishlistID,
            );
          }).toList();
          add(const ProductDetailsSuggestedProductLoadedEvent());
        }
      },
    );
  }

  Future<void> getGemstoneYouMayLike(BuildContext context, String productId) async {
    final Either<ErrorResponse, GemstoneListingModel>? response =
        await AppRepository(context).getGemstoneYouMayLike(productId, page: '1', limit: '10');

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
            productId: e.suid ?? '',
            name: e.rmDescription ?? '',
            imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
            offerPrice: isDiscounted ? e.discountPrice?.setCurrency : null,
            originalPrice: e.finalPrice?.setCurrency,
            discountPercentage: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([e.discountPercentage]) : null,
            productSku: e.lotCode,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            commodity: Commodity.gemstone,
            isFavourite: e.isFavorite,
            wishlistId: e.wishlistID,
          );
        }).toList();

        add(const ProductDetailsSuggestedProductLoadedEvent());
      },
    );
  }

  Future<void> getProductYouMayLike(BuildContext context, String productId) async {
    Either<ErrorResponse, JewelleryListingModel>? response =
        await AppRepository(context).getJewelleryYouMayLike(productId, page: '1', limit: '10');
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message ?? '');
        }
      },
      (data) {
        jewelleryDatumListAPI = data.data;
        suggestedProductList = data.data.map((e) {
          bool isDiscounted = e.discountPercentage != null && (e.discountPercentage! > 0);
          return ProductDetailsModel(
            productId: e.suid ?? '',
            name: e.productDescription ?? '',
            imageUrl: e.multipleFinishedViewImage.isNotEmpty ? (e.multipleFinishedViewImage.first.imageUrl ?? '') : '',
            offerPrice: isDiscounted ? e.discountPrice?.setCurrency : null,
            originalPrice: e.finalPrice?.setCurrency,
            discountPercentage: isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([e.discountPercentage]) : null,
            productSku: e.contractNoSkuNo,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            isFavourite: e.isFavorite,
            commodity: Commodity.jewellery,
            wishlistId: e.wishlistID,
          );
        }).toList();
        add(const ProductDetailsSuggestedProductLoadedEvent());
      },
    );
  }

  Future<void> getProductDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, JewelleryDataModel>? response = await AppRepository(context).getProductDetailById(productId, isLoadingShow: true);
    response?.fold(
      (error) {
        isErrorInLoadingData = true;
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message ?? '');
        }
      },
      (jewelleryData) {
        isErrorInLoadingData = false;
        productName = jewelleryData.productDescription ?? '';
        bool isDiscounted = jewelleryData.discountPercentage != null && (jewelleryData.discountPercentage! > 0);
        imgList = jewelleryData.multipleFinishedViewImage.map((e) => e.imageUrl ?? '').toList();
        productDetails = ProductDetailsModel(
          productId: productId,
          name: productName,
          offerPrice: isDiscounted ? jewelleryData.discountPrice?.setCurrency : null,
          originalPrice: jewelleryData.finalPrice?.setCurrency,
          discountPercentage:
              isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([jewelleryData.discountPercentage]) : null,
          productSku: jewelleryData.contractNoSkuNo,
          reviewCount: jewelleryData.reviewCount,
          rating: jewelleryData.rating?.toDouble(),
          brandName: jewelleryData.brandName,
          imageUrl: jewelleryData.multipleFinishedViewImage.isEmpty ? '' : jewelleryData.multipleFinishedViewImage[0].imageUrl ?? '',
          commodity: Commodity.jewellery,
          isFavourite: jewelleryData.isFavorite,
          wishlistId: jewelleryData.wishlistID,
        );
      },
    );
  }

  Future<void> productReviewsFilter(BuildContext context, String productId) async {
    // Here requested 6 reviews only for the first page. if the list's length is less than 6, then it will show the available reviews. or if the length is greater than 5, then it will show the view all reviews button.
    Either<ErrorResponse, PaginationData<ProductReviewModel>>? response =
        await AppRepository(context).productReviewsFilter(productId, query: {ApiKey.limit: "6", ApiKey.page: "1"}, isLoadMore: false);
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message ?? '');
        }
      },
      (data) {
        reviewList = (data.dataList as List<ProductReviewModel>?)?.map((e) {
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
        add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  Future<void> getProductRecentlyViewed(BuildContext context, String productId) async {
    Either<ErrorResponse, JewelleryListingModel>? response =
        await AppRepository(context).getRecentlyViewedProductList(page: "1", limit: "10");
    response?.fold(
      (error) {
        if (error.message.isNotNullNorEmpty) {
          Utils.showMessage(error.message ?? '');
        }
      },
      (data) {
        recentlyViewedProductList = data.data.map((e) {
          return ProductDetailsModel(
            productId: e.id,
            name: e.productDescription ?? '',
            imageUrl: e.multipleFinishedViewImage.isNotEmpty ? (e.multipleFinishedViewImage.first.imageUrl ?? '') : '',
            offerPrice: e.discountPrice?.setCurrency,
            originalPrice: e.finalPrice?.setCurrency,
            discountPercentage:
                e.discountPercentage != null ? APPStrings.percentageOffInterpolating.tr.interpolate([e.discountPercentage]) : null,
            productSku: e.contractNoSkuNo,
            reviewCount: e.reviewCount,
            rating: e.rating?.toDouble(),
            isFavourite: e.isFavorite,
            wishlistId: e.wishlistID,
            commodity: Commodity.jewellery,
          );
        }).toList();
        add(const ProductDetailsReviewsLoadedEvent());
      },
    );
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
  }

  void _onToggleCompareProduct(ToggleCompareProductEvent event, Emitter<ProductDetailsState> emit) {
    isCompare = !isCompare;
    emit(ProductCompareToggleState(isCompare));
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

  void _onProductDetailsSuggestedProductLoadedEvent(ProductDetailsSuggestedProductLoadedEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsSuggestedProductLoadedState(suggestedProductList));
  }

  void _onProductDetailsReviewsLoadedEvent(ProductDetailsReviewsLoadedEvent event, Emitter<ProductDetailsState> emit) {
    emit(const ReloadProductDetailsState());
    emit(const ProductDetailsRecentlyViewedLoadedState());
  }

  void navigateBasedOnScreenIdentifier(BuildContext context) {
    switch (screenIdentifier) {
      case ScreenIdentifier.productForRing:
        context.pushNamed(AppRoutes.productListGridPage, arguments: {
          RoutesData.isPageFor: ScreenIdentifier.productForRing,
          RoutesData.productId: productDetails?.productId,
        });
        break;
      case ScreenIdentifier.productForGemstones:
      case ScreenIdentifier.productForDiamonds:
        context.pushNamed(AppRoutes.stoneListingPage, arguments: {
          RoutesData.isPageFor: screenIdentifier,
          RoutesData.productId: productDetails?.productId,
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
      _updateProductList(state);
      _updateRecentlyViewedList(state);
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
  void _updateProductDetails(dynamic product, String wishlistId) {
    product.isFavorite = wishlistId.isNotEmpty;
    product.wishlistID = wishlistId;
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
}
