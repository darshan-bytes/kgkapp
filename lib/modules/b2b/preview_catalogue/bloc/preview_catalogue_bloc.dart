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

  /// Index of the currently displayed page.
  int currentPage = 0;

  /// List of pages available in the catalogue.
  List<int> pageList = [];

  /// List of product details displayed in the catalogue.
  List<ProductDetailsModel> productList = [];

  /// Controller for managing WebView actions and events.
  late WebViewController webViewController;

  /// Indicates whether the comment section is visible.
  bool isCommentVisible = false;

  /// Index of the selected product for commenting.
  int selectedCommentIndex = -1;

  /// Controller for handling comment input text.
  final TextEditingController commentController = TextEditingController();

  /// Focus node for the comment input field to manage focus.
  final FocusNode commentFocusNode = FocusNode();

  PreviewCatalogueBloc() : super(const PreviewCatalogueInitial()) {
    on<InitialPreviewCatalogueEvent>(_onInitialPreviewCatalogueEvent);
    on<PreviewCataloguePreviousNextPageEvent>(_onPreviewCataloguePreviousNextPageEvent);
    on<PreviewCatalogueCommentEvent>(_onPreviewCatalogueCommentEvent);
    on<PreviewCatalogueCommentProductSelectEvent>(_onPreviewCatalogueCommentProductSelectEvent);
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
    pageList = List.generate(3, (index) => index);
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
    }, (previewCatalogueDataModel) {
      previewCatalogueDataModel = previewCatalogueDataModel;
      _generateProductList(previewCatalogueDataModel);
    });
  }

  /// Generates a product list for the preview catalogue.
  void _generateProductList(PreviewCatalogueDataModel model) {
    printWrapped("catalogue => ${model.catalogueType}");
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
        imageUrl: (diamondDataList[index].image.isNotNullNorEmpty) ? diamondDataList[index].image.first.url : '',
        title: diamondDataList[index].lotCode,
        subTitle: diamondDataList[index].rmDescription,
        originalPrice: diamondDataList[index].discountPrice,
        isCommentVisible: false,
      ),
    );
  }

  /// Populates the product list for jewellery.
  void _populateJewelleryProductList(List<JewelleryDataModel> jewelleryDataList) {
    productList = List.generate(
      jewelleryDataList.length,
      (index) => ProductDetailsModel(
        imageUrl: (jewelleryDataList[index].multipleFinishedViewImage.isNotNullNorEmpty)
            ? jewelleryDataList[index].multipleFinishedViewImage.first.imageUrl
            : '',
        title: jewelleryDataList[index].contractNoSkuNo,
        subTitle: jewelleryDataList[index].productDescription,
        kgkCollectionName: jewelleryDataList[index].kgkCollection ?? "\n",
        businessCategoryName: jewelleryDataList[index].businessCategoryName ?? "\n",
        originalPrice: jewelleryDataList[index].discountPrice,
        cts: jewelleryDataList[index].crt,
        gms: jewelleryDataList[index].gms,
        colorsCode: [
          jewelleryDataList[index].metalColor1HexCode ?? "",
          jewelleryDataList[index].metalColor2HexCode ?? "",
          jewelleryDataList[index].metalColor3HexCode ?? "",
        ],
        isCommentVisible: false,
      ),
    );
  }

  /// Populates the product list for gemstone.
  void _populateGemstoneProductList(List<GemstoneDatum> gemstoneDataList) {
    productList = List.generate(
      gemstoneDataList.length,
      (index) => ProductDetailsModel(
        imageUrl: (gemstoneDataList[index].image.isNotNullNorEmpty) ? gemstoneDataList[index].image.first.url : '',
        title: gemstoneDataList[index].lotCode,
        subTitle: gemstoneDataList[index].rmDescription,
        originalPrice: (gemstoneDataList[index].discountPrice ?? 0).toString(),
        isCommentVisible: false,
      ),
    );
  }

  /// Populates the product list for CAD library.
  void _populateCadLibraryProductList(List<CadLibraryListItemDataModel> cadLibraryListItemDataList) {
    productList = List.generate(
      cadLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        imageUrl:
            (cadLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false) ? cadLibraryListItemDataList[index].images?.first : '',
        title: cadLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: cadLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: cadLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: cadLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: false,
      ),
    );
  }

  /// Populates the product list for design library.
  void _populateDesignLibraryProductList(List<DesignLibraryListItemDataModel> designLibraryListItemDataList) {
    productList = List.generate(
      designLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        imageUrl: (designLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? designLibraryListItemDataList[index].images?.first
            : '',
        title: designLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: designLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: designLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: designLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: false,
      ),
    );
  }

  /// Populates the product list for style library.
  void _populateStyleLibraryProductList(List<CadLibraryListItemDataModel> styleLibraryListItemDataList) {
    productList = List.generate(
      styleLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        imageUrl: (styleLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? styleLibraryListItemDataList[index].images?.first
            : '',
        title: styleLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: styleLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: styleLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: styleLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: false,
      ),
    );
  }

  /// Populates the product list for SKU library.
  void _populateSkuLibraryProductList(List<SkuProductModel> skuProductList) {
    productList = List.generate(
      skuProductList.length,
      (index) => ProductDetailsModel(
        imageUrl: (skuProductList[index].multipleFinishedViewImage?.isNotNullNorEmpty ?? false)
            ? skuProductList[index].multipleFinishedViewImage?.first.imageUrl
            : '',
        title: skuProductList[index].contractNumber,
        subTitle: skuProductList[index].productDescription ?? '',
        kgkCollectionName: skuProductList[index].kgkCollection ?? "\n",
        businessCategoryName: skuProductList[index].businessCategoryName ?? "\n",
        originalPrice: skuProductList[index].discountPrice,
        isCommentVisible: false,
      ),
    );
  }

  /// Handles switching between previous and next pages of the catalogue.
  void _onPreviewCataloguePreviousNextPageEvent(PreviewCataloguePreviousNextPageEvent event, Emitter<PreviewCatalogueState> emit) {
    emit(const PreviewCatalogueReloadState());
    _updateCurrentPage(event.isNext);
    emit(PreviewCataloguePreviousNextPageState(event.isNext));
  }

  /// Updates the current page index based on navigation direction.
  void _updateCurrentPage(bool isNext) {
    if (isNext) {
      if (currentPage < pageList.length - 1) {
        currentPage++;
      }
    } else {
      if (currentPage > 0) {
        currentPage--;
      }
    }
  }

  /// Toggles the visibility of the comment section.
  void _onPreviewCatalogueCommentEvent(PreviewCatalogueCommentEvent event, Emitter<PreviewCatalogueState> emit) {
    emit(const PreviewCatalogueReloadState());
    isCommentVisible = !isCommentVisible;
    if (!isCommentVisible) {
      commentFocusNode.unfocus();
    }
    emit(const PreviewCatalogueCommentState());
  }

  /// Handles selecting a specific product for commenting.
  void _onPreviewCatalogueCommentProductSelectEvent(PreviewCatalogueCommentProductSelectEvent event, Emitter<PreviewCatalogueState> emit) {
    emit(const PreviewCatalogueReloadState());
    selectedCommentIndex = event.index;
    commentFocusNode.requestFocus();
    emit(const PreviewCatalogueCommentProductSelectState());
  }
}
