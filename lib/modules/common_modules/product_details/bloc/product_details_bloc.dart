import 'package:kgk/kgk.dart';

part 'product_details_event.dart';

part 'product_details_state.dart';

class ProductDetailsBloc extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  String productName = '';
  ProductDetails? productDetails;
  bool isCustomisation = false;
  final CarouselController controller = CarouselController();
  List<String> imgList = [
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
    "https://s3-alpha-sig.figma.com/img/9156/a32a/a7a41b3c1c10eb7ae104b2d7eca279eb?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jPe~zC0Ct0o7T7pV4gJRKyCzsQSM~YofLfJJy~uB6Dm2neQrjuzc6BjhjA2NWS7G1PLePl0a4V7igTOAVJsQvY1PNTYeiIMO12mtgRnqIfa4taVQerKt4W0zOR~HsABLODf1m3Z9QCMinRhmEf3J6aqWov1J639mmpMNlMMlAbY2eY8FE6pP~1~i2nNtMzEplnbIDQkH0CgEF1eFyR42IEzSP78Wyvb9wgbWLoqn5jXSMIEVqiM8FtTzyPrOWbCyU0ioLBAwNvVR4Skz3JV-Ri1itQNGJKLCqzUBgePluTy7EVxmUUocey4oXYjjhmz5v7T9Tp4FIP~rTezMK0i~bA__",
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
          ? "https://s3-alpha-sig.figma.com/img/0ba8/8350/c9044a7ca4c5737635c215d420bddce0?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=XGyPVEIZPONfyOIm3dzVeBRwheWGhTu13CHbV3qHy7JmSqsbCkSI9gsbn0yyKnAZu0QsocO-siGscgeVTLh2kCU0yk-gvQdLAoU6~OieGjMkhYddOSqWrJwcX18ZzDkEX2YQn1g2X4Psh6MLOq9w0ugt2OuYqialfV8AEK6njZcIJthBraWtQTJBPxu2m4Y2t8q8GOUSNroW6cpJJP84R6wgx~SYuAtdOST~NWn9BQZxlLTT72sBX6A5hDdKKUuIwZ5W5MH52bPe8u4NwJ~XeayJKv2mebjlTFDTHDJITDBsMhDd9anziWhtXuiLXST2lSyz0oHwR2q0KQzlRcTy5A__"
          : "https://s3-alpha-sig.figma.com/img/891f/a5e1/15a433edae27d4ac1983e4070c4f5358?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=TWL6ZqLZZ6obSpBXhFz99wnVCHatZYEeglMeGWKUN9MGLpEW7y4bZGKrAM3ijc7umAR1uxFYMS7XGSlxj3RPboAr3kGYjQ73jHLEpKernHvEo95qqNtyf6pypP39lnoXI3aS-MPyICdXN-oRrkjKEHAzY14f~LuWa19aYx2ywDMIn3hMLgmlngUNGlWPaO1QcV1jHuhDA4PB-0DC28Rwv84aWpBhGs4L8yWl2aUFf5IiqPSML4kAClrZ9cSrx0SCq9S-50cvzYHO7EUk3nByRSs1g4M8cNS1CtOrKCnmqc015EXjcE8UXjpi43YzKU0Vkc9~VkJIFsJwnwNH9b9DpQ__",
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
          ? "https://s3-alpha-sig.figma.com/img/e8d4/b8e6/871b736fbf2cea8eca4a9f90ac3c419d?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=UhE~3IjAPdKYGRKMjokhqzHeadcdieYDtB9WPuek3ycMRvW0LteBBhrmKWzwPoAGQNp82xqTovtnOPrc4EoCSzGSsnnLrdwHdijnoUvGraxzbiYix60jqBvQNlz4M8xcBheWj13r9ITtlFkqexd0uuGbi8jDbQMWeWIykPWfgui8B-Io2NSl35qKqxmgw1nPN6pWeEfKFRaPSGZnPRZGu2Gxh~KhS6WjUvk6rTQCG92EUCIUSl6gRX8mvkUa~XfGtnkR-pvcOTYRwepxZkjVlRyAekO7WSg~w6pxP-PLwdzwGCrDWhC-5aWmjaRfL2~rpvTvdb1fC5NJe-qwWS97wA__"
          : "https://s3-alpha-sig.figma.com/img/86b4/491b/425b79510ad32e0cd47e38d109c4bdc6?Expires=1717977600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=C0NlP7cRvU1~IIU0OGDYAG9Fx2D9uXaSvh0OyGwZmbuvwzxAebVL2y6ThV9c0N4tO5MunUS0NIyonwRoZOqB8wE-cqQNipxOTVADmwuRk6mUbMMsVWtzWZLHcSEtwnwU1jUhT7Voq4kTEPjyOOfO~0qSJ2HnEFk2eQHO82PvAz1eAdlnWFW9GmwtDas~SDlo7pnLUVjOU2V04yO8W10oHCOfABF7nRT5YRXgKSTgGH6LsqJvKuWzDNSYxcj3znME~TcDE-7GYc2fAFeHprcA1FOIQ2fYSglZzc~lhCXed8Knv97Iz4HJ0OTJh1cQsiRpuWNFoInbQHDtV0mhJOoCyw__",
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
