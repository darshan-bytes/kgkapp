import 'package:kgk/kgk.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  bool isInitialized = false;

  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  String productName = '';
  ProductDetails? productDetails;
  DiamondDataModel? diamondData;
  bool isCustomisation = false;
  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;
  final CarouselSliderController controller = CarouselSliderController();
  final ScrollController youMayLikeScrollController = ScrollController();
  final ScrollController recentViewScrollController = ScrollController();

  List<String> imgList = [
    "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
    "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
    "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
    "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png",
    "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
  ];
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

  List<ProductDetails> suggestedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: index % 2 == 0
          ? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png"
          : "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      name: "Diamond Vine Ring in 18k Rose Gold",
      originalPrice: "\$5,000.00",
    ),
  );

  List<ProductDetails> recentlyViewedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: index % 2 == 0
          ? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png"
          : "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      name: "Diamond Vine Ring in 18k Rose Gold",
      originalPrice: "\$5,000.00",
    ),
  );

  List<ReviewDataModel> reviewList = [];

  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<ToggleCompareProductEvent>(_onToggleCompareProduct);
    on<ProductCustomizationChangeEvent>(_onOnProductCustomizationChange);
    on<RingDetailsToggleEvent>(_onRingDetailsToggleEvent);
    on<ProductDiamondDetailsToggleEvent>(_onProductDiamondDetailsToggleEvent);
    on<GemstoneDetailsToggleEvent>(_onGemstoneDetailsToggleEvent);
    on<ProductDetailsSuggestedProductLoadedEvent>(_onProductDetailsSuggestedProductLoadedEvent);
  }

  Future<void> _onLoadProductDetails(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) async {
    if (isInitialized) return;
    isInitialized = true;
    emit(ProductDetailsLoadingState());
    // assigning current userType
    userType = BlocProvider.of<AppBloc>(event.context).userType;

    getScreenIdentifier(event.context);

    productName = screenIdentifier == ScreenIdentifier.productForRing
        ? '14k Gold Engagement Ring'
        : screenIdentifier == ScreenIdentifier.productForGemstones
            ? '0.35 Carat Super Premium Oval Moissanite'
            : '';

    String productId = event.context.routesData?[RoutesData.productId] ?? '--';
    if (screenIdentifier == ScreenIdentifier.productForDiamonds) {
      productCustomizations.clear();
      imgList.clear();
      suggestedProductList.clear();

      //TODO: Need to integrate API for suggested products
      // suggestedProductList = List.generate(
      //   8,
      //   (index) => ProductDetails(
      //     diamond: "1.5 gram",
      //     gram: "1.5 gram",
      //     imageUrl: 'https://i.ibb.co/8s6hWz2/image-414.png',
      //     name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
      //     originalPrice: "\$ 5,000.00",
      //   ),
      // );
      await getDiamondsDetails(event.context, productId);
      getDiamondYouMayLike(event.context, productId);
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      productCustomizations.clear();
      imgList.clear();
      suggestedProductList.clear();
      recentlyViewedProductList.clear();

      imgList = [
        "https://i.ibb.co/477f41r/Group-1410089379.png",
        "https://i.ibb.co/477f41r/Group-1410089379.png",
        "https://i.ibb.co/477f41r/Group-1410089379.png",
        "https://i.ibb.co/477f41r/Group-1410089379.png",
        "https://i.ibb.co/477f41r/Group-1410089379.png",
        "https://i.ibb.co/477f41r/Group-1410089379.png",
      ];

      recentlyViewedProductList = List.generate(
        8,
        (index) => ProductDetails(
          diamond: "1.5 gram",
          gram: "1.5 gram",
          imageUrl: 'https://i.ibb.co/RQQGX6J/image-7.png',
          name: "Diamond Vine Ring in 18k Rose Gold",
          originalPrice: "\$ 5,000.00",
        ),
      );

      suggestedProductList = List.generate(
        8,
        (index) => ProductDetails(
          diamond: "1.5 gram",
          gram: "1.5 gram",
          imageUrl: 'https://i.ibb.co/s1Xyxy7/image-7.png',
          name: "Diamond Vine Ring in 18k Rose Gold",
          originalPrice: "\$ 5,000.00",
        ),
      );
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

    reviewList = List.generate(
      6,
      (index) => ReviewDataModel(
        id: index,
        userName: 'Esther Howard',
        date: '01/05/23',
        rating: 4,
        title: 'Gorgeous and more gorgeous',
        review:
            'I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone. I love this ring. It is so beautiful and the quality is amazing. I have received so many compliments on it. I would highly recommend this ring to anyone.',
        images: [
          'https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png',
          'https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png',
          'https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png',
          'https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png',
        ],
      ),
    );
    if (productDetails != null) {
      emit(ProductDetailsLoadedState(productDetails!));
    }
  }

  Future<void> getDiamondsDetails(BuildContext context, String productId) async {
    Either<ErrorResponse, DiamondDataModel>? response = await DiamondRepository(context).getDiamondDetailById(productId);
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
          productDetails = ProductDetails(
            productId: productId,
            name: productName,
            offerPrice: isDiscounted ? diamondData!.discountPrice?.setCurrency : null,
            originalPrice: diamondData!.finalPrice?.setCurrency,
            discountPercentage: isDiscounted ? APPStrings.percentageOffInterpolating.interpolate([diamondData!.discountPercentage]) : null,
            productSku: diamondData!.lotCode,
            reviewCount: diamondData!.reviewCount,
            rating: diamondData!.rating?.toDouble(),
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
          List<DiamondDataModel> suggestedProductListAPI = data.data;
          suggestedProductList = suggestedProductListAPI.map((e) {
            bool isDiscounted = e.discountPercentage != null && (e.discountPercentage is num) && e.discountPercentage > 0;
            return ProductDetails(
              productId: e.id,
              name: e.rmDescription ?? '',
              imageUrl: e.image.isNotEmpty ? (e.image.first.url ?? '') : '',
              offerPrice: isDiscounted ? e.discountPrice?.setCurrency : null,
              originalPrice: e.finalPrice?.setCurrency,
              discountPercentage: isDiscounted ? APPStrings.percentageOffInterpolating.interpolate([e.discountPercentage]) : null,
              productSku: e.lotCode,
              reviewCount: e.reviewCount,
              rating: e.rating?.toDouble(),
            );
          }).toList();
          add(const ProductDetailsSuggestedProductLoadedEvent());
        }
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

  void navigateBasedOnScreenIdentifier(BuildContext context) {
    switch (screenIdentifier) {
      case ScreenIdentifier.productForRing:
        context.pushNamed(AppRoutes.productListGridPage, arguments: {RoutesData.isPageFor: ScreenIdentifier.productForRing});
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
}
