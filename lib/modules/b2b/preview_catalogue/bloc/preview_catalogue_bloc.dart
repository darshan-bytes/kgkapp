import 'package:kgk/kgk.dart';

part 'preview_catalogue_event.dart';

part 'preview_catalogue_state.dart';

class PreviewCatalogueBloc extends Bloc<PreviewCatalogueEvent, PreviewCatalogueState> {
  /// Title of the digital catalogue.
  String titleOfCatalogue = '';

  /// Model containing details of the digital catalogue.
  DigitalCatalogueListingModel? digitalCatalogueListingModel;

  /// Model containing data of the preview catalogue.
  PreviewCatalogueDataModel? previewCatalogueDataModel;

  /// Determines if the catalogue should be displayed in a WebView.
  bool get isWebView => digitalCatalogueListingModel?.isWebView ?? false;

  /// List of product details displayed in the catalogue.
  List<ProductDetailsModel> productList = [];

  /// Controller for managing WebView actions and events.
  late WebViewController webViewController;

  PreviewCatalogueBloc() : super(const PreviewCatalogueInitial()) {
    on<InitialPreviewCatalogueEvent>(_onInitialPreviewCatalogueEvent);
  }

  /// Handles the initial loading of the preview catalogue.
  Future<void> _onInitialPreviewCatalogueEvent(InitialPreviewCatalogueEvent event, Emitter<PreviewCatalogueState> emit) async {
    _getRouteData(context: event.context);
    if (isWebView) {
      _initializeWebViewController();
    } else {
      await _callPreviewCatalogueApi(context: event.context);
    }
    emit(const PreviewCatalogueLoadedState());
  }

  /// Retrieves the digital catalogue data from the route data.
  void _getRouteData({required BuildContext context}) {
    if (context.routesData == null) return;
    digitalCatalogueListingModel = context.routesData?[RoutesData.catalogueData];
    titleOfCatalogue = digitalCatalogueListingModel?.name ?? '';
  }

  /// Initializes the WebView controller and sets up the navigation delegate
  void _initializeWebViewController() {
    webViewController = WebViewController()..setJavaScriptMode(JavaScriptMode.unrestricted);
    String? webUrl = digitalCatalogueListingModel?.webUrl;
    if (webUrl.isNotNullNorEmpty) {
      webViewController.loadRequest(Uri.parse(webUrl!));
    }
  }

  /// Fetches data from the design library API.
  Future<void> _callPreviewCatalogueApi({required BuildContext context}) async {
    /// Makes the API request and handles the response.
    Either<ErrorResponse, PreviewCatalogueDataModel>? response =
        await AppRepository(context).getPreviewCatalogue(id: digitalCatalogueListingModel?.id ?? '');

    response?.fold((error) {
      if (error.message.isNotNullNorEmpty) {
        Utils.showMessage(error.message);
      }
    }, (PreviewCatalogueDataModel data) {
      previewCatalogueDataModel = data;
      if (previewCatalogueDataModel != null) {
        _generateProductList(previewCatalogueDataModel!);
      }
    });
  }

  /// Generates a product list for the preview catalogue.
  void _generateProductList(PreviewCatalogueDataModel model) {
    switch (model.catalogueType) {
      case AppConst.diamond:
        _populateDiamondProductList(model.diamondDataList ?? []);
        break;
      case AppConst.jewellery:
        _populateJewelleryProductList(model.jewelleryDataList ?? []);
        break;
      case AppConst.gemstone:
        _populateGemstoneProductList(model.gemstoneDataList ?? []);
        break;
      case AppConst.cadLibrary:
        _populateCadLibraryProductList(model.cadLibraryListItemDataList ?? []);
        break;
      case AppConst.designLibrary:
        _populateDesignLibraryProductList(model.designLibraryListItemDataList ?? []);
        break;
      case AppConst.styleLibrary:
        _populateStyleLibraryProductList(model.styleLibraryListItemDataList ?? []);
        break;
      case AppConst.skuLibrary:
        _populateSkuLibraryProductList(model.skuProductList ?? []);
        break;
    }
  }

  /// Populates the product list for diamond.
  void _populateDiamondProductList(List<DiamondDataModel> diamondDataList) {
    productList = List.generate(
      diamondDataList.length,
      (index) => ProductDetailsModel(
        productId: diamondDataList[index].suid,
        imageUrl: (diamondDataList[index].image.isNotNullNorEmpty) ? diamondDataList[index].image.first.url : '',
        title: diamondDataList[index].lotCode,
        subTitle: diamondDataList[index].rmDescription,
        originalPrice: diamondDataList[index].finalPrice?.setCurrency,
        offerPrice: diamondDataList[index].finalPrice?.setCurrency,
        finalPrice: diamondDataList[index].discountPrice?.setCurrency,
        isCommentVisible: diamondDataList[index].isCommented,
        commodity: Commodity.diamond,
      ),
    );
  }

  /// Populates the product list for jewellery.
  void _populateJewelleryProductList(List<JewelleryDataModel> jewelleryDataList) {
    productList = List.generate(
      jewelleryDataList.length,
      (index) => ProductDetailsModel(
        productId: jewelleryDataList[index].suid,
        imageUrl: (jewelleryDataList[index].multipleFinishedViewImage.isNotNullNorEmpty)
            ? jewelleryDataList[index].multipleFinishedViewImage.first.imageUrl
            : '',
        title: jewelleryDataList[index].contractNoSkuNo,
        subTitle: jewelleryDataList[index].productDescription,
        kgkCollectionName: jewelleryDataList[index].kgkCollection ?? "\n",
        businessCategoryName: jewelleryDataList[index].businessCategoryName ?? "\n",
        originalPrice: jewelleryDataList[index].finalPrice?.setCurrency,
        offerPrice: jewelleryDataList[index].finalPrice?.setCurrency,
        finalPrice: jewelleryDataList[index].discountPrice?.setCurrency,
        cts: jewelleryDataList[index].crt,
        gms: jewelleryDataList[index].gms,
        colorsCode: [
          jewelleryDataList[index].metalColor1HexCode ?? "",
          jewelleryDataList[index].metalColor2HexCode ?? "",
          jewelleryDataList[index].metalColor3HexCode ?? "",
        ],
        isCommentVisible: jewelleryDataList[index].isCommented,
        commodity: Commodity.jewellery,
      ),
    );
  }

  /// Populates the product list for gemstone.
  void _populateGemstoneProductList(List<GemstoneDatum> gemstoneDataList) {
    productList = List.generate(
      gemstoneDataList.length,
      (index) => ProductDetailsModel(
        productId: gemstoneDataList[index].suid,
        imageUrl: (gemstoneDataList[index].image.isNotNullNorEmpty) ? gemstoneDataList[index].image.first.url : '',
        title: gemstoneDataList[index].lotCode,
        subTitle: gemstoneDataList[index].rmDescription,
        originalPrice: gemstoneDataList[index].finalPrice?.setCurrency,
        offerPrice: gemstoneDataList[index].finalPrice?.setCurrency,
        finalPrice: gemstoneDataList[index].discountPrice?.setCurrency,
        isCommentVisible: gemstoneDataList[index].isCommented,
        commodity: Commodity.gemstone,
      ),
    );
  }

  /// Populates the product list for CAD library.
  void _populateCadLibraryProductList(List<CadLibraryListItemDataModel> cadLibraryListItemDataList) {
    productList = List.generate(
      cadLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: cadLibraryListItemDataList[index].suid,
        imageUrl:
            (cadLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false) ? cadLibraryListItemDataList[index].images?.first : '',
        title: cadLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: cadLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: cadLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: cadLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: cadLibraryListItemDataList[index].isCommented ?? false,
        commodity: Commodity.cadLibrary,
      ),
    );
  }

  /// Populates the product list for design library.
  void _populateDesignLibraryProductList(List<DesignLibraryListItemDataModel> designLibraryListItemDataList) {
    productList = List.generate(
      designLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: designLibraryListItemDataList[index].suid,
        imageUrl: (designLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? designLibraryListItemDataList[index].images?.first
            : '',
        title: designLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: designLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: designLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: designLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: designLibraryListItemDataList[index].isCommented,
        commodity: Commodity.designLibrary,
      ),
    );
  }

  /// Populates the product list for style library.
  void _populateStyleLibraryProductList(List<CadLibraryListItemDataModel> styleLibraryListItemDataList) {
    productList = List.generate(
      styleLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: styleLibraryListItemDataList[index].suid,
        imageUrl: (styleLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? styleLibraryListItemDataList[index].images?.first
            : '',
        title: styleLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: styleLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: styleLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: styleLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: styleLibraryListItemDataList[index].isCommented ?? false,
        commodity: Commodity.styleLibrary,
      ),
    );
  }

  /// Populates the product list for SKU library.
  void _populateSkuLibraryProductList(List<SkuProductModel> skuProductList) {
    productList = List.generate(
      skuProductList.length,
      (index) => ProductDetailsModel(
        productId: skuProductList[index].suid,
        imageUrl: (skuProductList[index].multipleFinishedViewImage?.isNotNullNorEmpty ?? false)
            ? skuProductList[index].multipleFinishedViewImage?.first.imageUrl
            : '',
        title: skuProductList[index].contractNumber,
        subTitle: skuProductList[index].productDescription ?? '',
        kgkCollectionName: skuProductList[index].kgkCollection ?? "\n",
        businessCategoryName: skuProductList[index].businessCategoryName ?? "\n",
        originalPrice: skuProductList[index].finalPrice?.setCurrency,
        offerPrice: skuProductList[index].finalPrice?.setCurrency,
        finalPrice: skuProductList[index].discountPrice?.setCurrency,
        isCommentVisible: skuProductList[index].isCommented ?? false,
        commodity: Commodity.skuLibrary,
      ),
    );
  }
}
