import 'package:kgk/kgk.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  String productName = '';
  ProductDetails? productDetails;
  bool isCustomisation = false;
  final CarouselController controller = CarouselController();
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
  GlobalKey<SmartExpansionTileState> diamondDetailsKey = GlobalKey();

  List<ProductDetails> suggestedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl: index % 2 == 0
          ? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png"
          : "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      name: "Diamond Vine Ring in 18k Rose Gold",
      originalPrice: "\$ 5,000",
    ),
  );

  List<ProductDetails> recentlyViewedProductList = List.generate(
    8,
    (index) => ProductDetails(
      diamond: "1.5 gram",
      gram: "1.5 gram",
      imageUrl: index % 2 == 0
          ? "https://i.ibb.co/6w4y6pX/DERS01-XXSRTTP-6-0-RD-PWR1-jpg-1.png"
          : "https://i.ibb.co/q71vDB8/DERS01-XXSRTTP-6-0-RD-PWR1-jpg.png",
      name: "Diamond Vine Ring in 18k Rose Gold",
      originalPrice: "\$ 5,000",
    ),
  );

  ProductDetailsBloc() : super(ProductDetailsInitialState()) {
    on<LoadProductDetailsEvent>(_onLoadProductDetails);
    on<OnProductImageChangeEvent>(_onOnProductImageChange);
    on<ToggleCompareProductEvent>(_onToggleCompareProduct);
    on<ProductCustomizationChangeEvent>(_onOnProductCustomizationChange);
    on<RingDetailsToggleEvent>(_onRingDetailsToggleEvent);
    on<DiamondDetailsToggleEvent>(_onDiamondDetailsToggleEvent);
  }

  void _onLoadProductDetails(LoadProductDetailsEvent event, Emitter<ProductDetailsState> emit) {
    emit(ProductDetailsLoadingState());
    productName = '14k Gold Engagement Ring';
    String productId = event.context.routesData?[RoutesData.productId] ?? '--';
    isCustomisation = event.context.routesData?[RoutesData.isCustomisationPage] ?? false;

    if (isCustomisation) {
      productCustomizations.insert(
        0,
        ProductCustomizationOptions(
          id: productCustomizations.length.toString(),
          name: APPStrings.head.tr,
          type: ProductCustomizationType.image.value,
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
    productDetails = ProductDetails(
      productId: productId,
      name: productName,
      offerPrice: '\$ 1200.00',
      originalPrice: '\$ 1600.00',
      discountPercentage: '(3% OFF)',
    );
    emit(ProductDetailsLoadedState(productDetails!));
  }

  void _onOnProductImageChange(OnProductImageChangeEvent event, Emitter<ProductDetailsState> emit) {
    current = event.index;
    emit(ProductImagePageChangeState(current));
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

  void _onDiamondDetailsToggleEvent(DiamondDetailsToggleEvent event, Emitter<ProductDetailsState> emit) {
    isDiamondDetailsOpen = !isDiamondDetailsOpen;
    emit(DiamondDetailsToggleState(isDiamondDetailsOpen));
  }
}
