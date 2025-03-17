import 'package:kgk/kgk.dart';

part 'compare_product_event.dart';

part 'compare_product_state.dart';

class CompareProductBloc extends Bloc<CompareProductEvent, CompareProductState> {
  MyBagBloc? myBagBloc;
  Commodity? commodity;
  String? jewelleryType;
  List<FilterOptionModel> filterList = [];
  final List<ProductDetailsModel> productList = [];
  final List<String> productIdList = [];
  List<Map<String, dynamic>> compareResult = [];

  bool _isInitialized = false;

  CompareProductBloc() : super(CompareProductInitial()) {
    on<CompareProductAddProductEvent>(_onCompareProductAddProduct);
    on<CompareProductRemoveProductEvent>(_onCompareProductRemoveProduct);
    on<CompareProductClearEvent>(_onCompareProductClear);
    on<CompareProductGenerateTableEvent>(_onCompareProductGenerateTable);
  }

  /// Generates a map of column widths for a table
  Map<int, FixedColumnWidth> generateTableColumnWidths(int length, double width) =>
      {for (int i = 0; i < length; i++) i: FixedColumnWidth(width)};

  /// Handles adding a product to the comparison list
  Future<void> _onCompareProductAddProduct(CompareProductAddProductEvent event, Emitter<CompareProductState> emit) async {
    // Initialize the commodity if null
    Commodity productCommodity = event.product.commodity ?? Commodity.jewellery;
    commodity ??= productCommodity;

    bool isDisplayError = commodity != productCommodity;
    if (!isDisplayError && (commodity == Commodity.jewellery)) {
      jewelleryType ??= event.product.jewelleryType;
      isDisplayError = jewelleryType != event.product.jewelleryType;
    }
    // Handle different commodities case
    if (isDisplayError) {
      final result = await Utils.showSmartModalBottomSheet(
        context: event.context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(16.r)),
        ),
        builder: (context) => ConfirmationDialog(
          title: APPStrings.differentCommoditiesSelected.tr,
          message: APPStrings.cantCompareDifferentCommodities.tr,
          onApproved: () => context.pop(arguments: {RoutesData.isContinueClearCompare: true}),
          onDenied: () => context.pop(),
          onApprovedText: APPStrings.strContinue.tr,
          onDeniedText: APPStrings.cancel.tr,
        ),
      );

      if (result?[RoutesData.isContinueClearCompare] == true) {
        commodity = productCommodity;
        jewelleryType = event.product.jewelleryType;
        productIdList.clear();
        productList.clear();
      } else {
        return;
      }
    }

    // Add the product if not already present
    if (event.product.productId.isNotNullNorEmpty && !productIdList.contains(event.product.productId)) {
      productIdList.add(event.product.productId!); // Add product explicitly
      productList.add(event.product); // Add product to the list
      emit(CompareProductReloadState());
      emit(CompareProductAddedState(productIdList: List.unmodifiable(productIdList)));
    }
  }

  /// Handles removing a product from the comparison list
  void _onCompareProductRemoveProduct(CompareProductRemoveProductEvent event, Emitter<CompareProductState> emit) {
    int index = productIdList.indexOf(event.productId);
    if (index > -1) {
      productIdList.removeAt(index);
      productList.removeAt(index);
      if (compareResult.isNotEmpty) {
        compareResult.removeAt(index);
      }
      emit(CompareProductReloadState());
      emit(CompareProductAddedState(productIdList: List.unmodifiable(productIdList)));
      if (event.isFromCompareScreen) {
        if (productIdList.isNotEmpty) {
          emit(CompareProductsLoadedState());
        } else {
          event.context.pop();
        }
      }
    }
  }

  /// Clears all products from the comparison list
  void _onCompareProductClear(CompareProductClearEvent event, Emitter<CompareProductState> emit) {
    productIdList.clear();
    productList.clear();
    filterList.clear();
    emit(CompareProductReloadState());
    emit(CompareProductAddedState(productIdList: List.unmodifiable(productIdList)));
  }

  /// Stub for table generation logic
  Future<void> _onCompareProductGenerateTable(CompareProductGenerateTableEvent event, Emitter<CompareProductState> emit) async {
    if (_isInitialized) return;
    _isInitialized = true;
    compareResult.clear();
    productList.clear();
    emit(CompareProductLoadingState());
    event.context.setAppLoading(true);
    filterList = await BlocProvider.of<AppBloc>(event.context).getFilterOptionList(event.context, commodity?.value ?? '');
    event.context.setAppLoading(false);

    try {
      final Map<String, dynamic> body = {
        ApiKey.products: productIdList.map((e) => {ApiKey.id: e, ApiKey.collectionType: commodity?.value}).toList(),
      };

      if (StorageManager.instance.getIsSkipLogin()) {
        body[ApiKey.quote] = StorageManager.instance.getBagId();
      }

      final response = await AppRepository(event.context).compareProducts(body: body);
      response?.fold(
        (l) {
          emit(CompareProductErrorState(message: l.message ?? ''));
        },
        (r) {
          compareResult = r;
          for (int i = 0; i < compareResult.length; i++) {
            productList.add(_convertToProductDetailModel(compareResult[i]));
          }
          emit(CompareProductsLoadedState());
        },
      );
    } catch (e) {
      emit(CompareProductErrorState(message: e.toString()));
    }
  }

  ProductDetailsModel _convertToProductDetailModel(Map<String, dynamic> sourceModel) {
    ProductDetailsModel productDetails = ProductDetailsModel();

    if (commodity == Commodity.jewellery) {
      JewelleryDataModel jewelleryData = JewelleryDataModel.fromJson(sourceModel);
      bool isDiscounted = jewelleryData.discountPercentage != null && (jewelleryData.discountPercentage! > 0);
      productDetails = ProductDetailsModel(
        productId: jewelleryData.suid,
        suid: jewelleryData.suid,
        name: jewelleryData.productDescription ?? '',
        jewelleryType: jewelleryData.jewelleryType,
        originalPrice: jewelleryData.finalPrice?.toString().setCurrency,
        offerPrice: jewelleryData.discountPrice?.toString().setCurrency,
        finalPrice: jewelleryData.discountPrice?.toString().setCurrency,
        // offerPrice: isDiscounted ? jewelleryData.discountPrice?.setCurrency : null,
        // originalPrice: jewelleryData.finalPrice?.setCurrency,
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
    } else if (commodity == Commodity.diamond) {
      DiamondDataModel diamondData = DiamondDataModel.fromJson(sourceModel);
      bool isDiscounted =
          diamondData.discountPercentage != null && (diamondData.discountPercentage is num) && diamondData.discountPercentage > 0;
      productDetails = ProductDetailsModel(
        productId: diamondData.suid,
        suid: diamondData.suid,
        name: diamondData.rmDescription ?? '',
        originalPrice: diamondData.finalPrice?.toString().setCurrency,
        offerPrice: diamondData.discountPrice?.toString().setCurrency,
        finalPrice: diamondData.discountPrice?.toString().setCurrency,
        // offerPrice: isDiscounted ? diamondData!.discountPrice?.setCurrency : null,
        // originalPrice: diamondData!.finalPrice?.setCurrency,
        discountPercentageString:
            isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([diamondData.discountPercentage]) : null,
        productSku: diamondData.lotCode,
        reviewCount: diamondData.reviewCount,
        rating: diamondData.rating,
        commodity: Commodity.diamond,
        isFavourite: diamondData.isFavorite,
        wishlistId: diamondData.wishlistID,
        stoneElements: diamondData.components,
        auctionId: diamondData.auctionId,
        isAddedToCart: diamondData.isAddedToCart,
      );
    } else if (commodity == Commodity.gemstone) {
      GemstoneDatum gemstoneData = GemstoneDatum.fromJson(sourceModel);
      bool isDiscounted =
          gemstoneData.discountPercentage != null && (gemstoneData.discountPercentage is num) && (gemstoneData.discountPercentage ?? 0) > 0;

      productDetails = ProductDetailsModel(
        productId: gemstoneData.suid,
        suid: gemstoneData.suid,
        name: gemstoneData.rmDescription ?? '',
        originalPrice: gemstoneData.finalPrice?.toString().setCurrency,
        offerPrice: gemstoneData.discountPrice?.toString().setCurrency,
        finalPrice: gemstoneData.discountPrice?.toString().setCurrency,
        // offerPrice: isDiscounted ? (gemstoneData!.discountPrice ?? 0).toString().setCurrency : null,
        // originalPrice: gemstoneData!.finalPrice?.setCurrency,
        discountPercentageString:
            isDiscounted ? APPStrings.percentageOffInterpolating.tr.interpolate([gemstoneData.discountPercentage]) : null,
        productSku: gemstoneData.lotCode,
        reviewCount: gemstoneData.reviewCount,
        rating: gemstoneData.rating?.toDouble(),
        shape: gemstoneData.shape,
        productQuality: CartProductQuality(name: gemstoneData.quality),
        color: gemstoneData.color,
        clarity: gemstoneData.clarity,
        commodity: Commodity.gemstone,
        isFavourite: gemstoneData.isFavorite,
        wishlistId: gemstoneData.wishlistID,
        stoneElements: gemstoneData.components,
        isAddedToCart: gemstoneData.isAddedToCart,
      );
    }

    return productDetails;
  }

  void setInitialized(bool bool) {
    _isInitialized = bool;
  }

  void handleBagButtonClick(BuildContext context, int index) {
    if (!productList[index].isAddedToCart) {
      BlocProvider.of<AppBloc>(context).onTapBag(context, productDetails: productList[index]);
      productList[index].isAddedToCart = true;
    } else {
      BlocProvider.of<LandingBloc>(context).add(LandingChangeTabEvent(LandingBloc.myBagIndex, context: context));
      context.popUntil((route) => route.settings.name == AppRoutes.landingPage);
    }
  }
}
