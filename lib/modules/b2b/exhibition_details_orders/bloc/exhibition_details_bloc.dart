import 'package:kgk/kgk.dart';

part 'exhibition_details_event.dart';

part 'exhibition_details_state.dart';

class ExhibitionDetailsBloc extends Bloc<ExhibitionDetailsEvent, ExhibitionDetailsState> {
  /// Determines if the view is in grid or list mode
  bool isGrid = true;

  /// App bar title for the screen
  String appbarTitle = '';

  String exhibitionId = '';

  /// Exhibition type is required for fetching exhibition product listing
  String exhibitionType = '';

  /// Identify Current user type
  UserType userType = UserType.b2cUser;

  /// For keeping track of the current tab and stop same tab on click event
  int currentTab = -1;

  /// TabController for managing tabs in the UI.
  late TabController tabController;

  /// List of tabs
  final List<Widget> tabs = <Widget>[
    Tab(text: APPStrings.products.tr),
    Tab(text: APPStrings.orders.tr),
  ];

  /// The total number of filtered records
  int totalFilteredRecords = 0;

  /// Controller for managing pagination
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// List of exhibition products
  List<ProductDetailsModel> productList = [];

  /// List of exhibition orders
  List<B2BCustomListingDataModel> exhibitionOrdersList = [];

  /// Exhibition details
  ExhibitionListDataModel exhibitionDetails = ExhibitionListDataModel();
  ExhibitionProductDetailsDataModel exhibitionProductDetailsData = ExhibitionProductDetailsDataModel();

  ExhibitionDetailsBloc() : super(const ExhibitionDetailsInitialsState()) {
    on<ExhibitionDetailsInitialEvent>(_onInitialEvent);
    on<ExhibitionChangeTabsEvent>(_onChangeTabEvent);
    on<ExhibitionListingLoadMoreEvent>(_onExhibitionListingLoadMoreEvent);
    on<ExhibitionChangeListingTypeEvent>(_onExhibitionChangeListingTypeEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  /// Initializes the OrdersBloc by fetching order data
  Future<void> _onInitialEvent(ExhibitionDetailsInitialEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _initializeBloc(context: event.context, emit: emit);
  }

  /// Handles the ChangeOrderTabsEvent for tab switching
  Future<void> _onChangeTabEvent(ExhibitionChangeTabsEvent event, Emitter<ExhibitionDetailsState> emit) async {
    await _handleTabSelection(context: event.context, index: event.index, emit: emit);
  }

  /// Handles the load more event for order listings
  Future<void> _onExhibitionListingLoadMoreEvent(ExhibitionListingLoadMoreEvent event, Emitter<ExhibitionDetailsState> emit) async {
    // await _handleLoadMore(event.context, event.currentPage, emit);
  }

  /// Handles the change listing type event
  Future<void> _onExhibitionChangeListingTypeEvent(ExhibitionChangeListingTypeEvent event, Emitter<ExhibitionDetailsState> emit) async {
    _toggleViewType(isGridValue: event.isGrid, emit: emit);
  }

  Future<void> _initializeBloc({required Emitter<ExhibitionDetailsState> emit, required BuildContext context}) async {
    emit(const ExhibitionDetailsReloadState());

    /// Set the current user type.
    userType = BlocProvider.of<AppBloc>(context).userType;

    /// Extract exhibitionId number from route data.
    _getRouteData(context);

    /// Initialize pagination.
    _initializePagination(context);

    /// Fetch exhibition details
    await _getExhibitionDetails(context, exhibitionId);

    /// Fetch exhibition product details
    await _getExhibitionProductDetails(context, exhibitionId);

    /// Fetch exhibition product listing
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      /// Fetch exhibition product listing
      await _callProductListingApi(context: context, exhibitionType: exhibitionType);
    }
    emit(const ExhibitionDetailsLoadedState());
  }

  /// Extract exhibitionId number from route data.
  void _getRouteData(BuildContext context) {
    String exhibitionIdValue = context.routesData?[RoutesData.exhibitionId] ?? '';
    if (exhibitionIdValue.isNotNullNorEmpty) {
      exhibitionId = exhibitionIdValue;
    }
  }

  /// Initializes pagination for loading more order data
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ExhibitionListingLoadMoreEvent(currentPage: currentPage, context: context));
      },
    );
  }

  /// Fetches the exhibition details data from the API
  Future<void> _getExhibitionDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionListDataModel>? response = await AppRepository(context).fetchExhibitionDetails(id: id);
    response?.fold(
      (error) => error.message.isNotNullNorEmpty ? Utils.showMessage(error.message) : null,
      (data) {
        /// Set the exhibition details.
        exhibitionDetails = data;
        appbarTitle = exhibitionDetails.name ?? '';
        exhibitionType = exhibitionDetails.exhibitionType ?? "";
      },
    );
  }

  /// Fetches the exhibition product details data from the API
  Future<void> _getExhibitionProductDetails(BuildContext context, String id) async {
    Either<ErrorResponse, ExhibitionProductDetailsDataModel>? response = await AppRepository(context).fetchExhibitionProductDetails(id: id);
    response?.fold(
      (error) => error.message.isNotNullNorEmpty ? Utils.showMessage(error.message) : null,
      (data) => exhibitionProductDetailsData = data,
    );
  }

  /// Handles tab selection and reloads order data accordingly
  Future<void> _handleTabSelection(
      {required BuildContext context, required int index, required Emitter<ExhibitionDetailsState> emit}) async {
    if (currentTab == index) return;
    currentTab = index;
    emit(const ExhibitionDetailsReloadState());

    /// Reload order data
    // await _reloadOrderData(context, emit);
    emit(const ExhibitionChangeTabsState());
  }

  /// Toggle between grid and list view
  void _toggleViewType({bool isGridValue = false, required Emitter<ExhibitionDetailsState> emit}) {
    emit(const ExhibitionDetailsReloadState());
    isGrid = isGridValue;
    emit(const ExhibitionChangeListingTypeState());
  }

  Future<void> _callProductListingApi({required BuildContext context, required String exhibitionType}) async {
    Either<ErrorResponse, dynamic>? response;
    switch (exhibitionType) {
      case AppConst.diamond:
        response = await AppRepository(context).fetchDiamondList(
          limit: AppConst.pageLimit.toString(),
          page: paginationScrollController.currentPage.toString(),
          sortKey: null,
          sortValue: null,
          type: null,
          query: {ApiKey.exhibitionId: exhibitionId},
        );
        break;
      case AppConst.jewellery:
        response = await AppRepository(context).fetchJewelleryList(
          limit: AppConst.pageLimit.toString(),
          page: paginationScrollController.currentPage.toString(),
          sortKey: null,
          sortValue: null,
          type: null,
          query: {ApiKey.exhibitionId: exhibitionId},
        );
        break;
      case AppConst.gemstone:
        response = await AppRepository(context).fetchGemstoneList(
          limit: AppConst.pageLimit.toString(),
          page: paginationScrollController.currentPage.toString(),
          sortKey: null,
          sortValue: null,
          type: null,
          query: {ApiKey.exhibitionId: exhibitionId},
        );
        break;
      case AppConst.cadLibrary:
        response = await AppRepository(context).getCadLibraryList(query: {
          ApiKey.limit: AppConst.pageLimit.toString(),
          ApiKey.page: paginationScrollController.currentPage.toString(),
          ApiKey.exhibitionId: exhibitionId,
        });
        break;
      case AppConst.designLibrary:
        response = await AppRepository(context).getDesignLibraryList(query: {
          ApiKey.limit: AppConst.pageLimit.toString(),
          ApiKey.page: paginationScrollController.currentPage.toString(),
          ApiKey.exhibitionId: exhibitionId,
        });
        break;
      case AppConst.styleLibrary:
        response = await AppRepository(context).getStyleLibraryList(query: {
          ApiKey.limit: AppConst.pageLimit.toString(),
          ApiKey.page: paginationScrollController.currentPage.toString(),
          ApiKey.exhibitionId: exhibitionId,
        });
        break;
      case AppConst.skuLibrary:
        response = await AppRepository(context).getSkuLibraryList(query: {
          ApiKey.limit: AppConst.pageLimit.toString(),
          ApiKey.page: paginationScrollController.currentPage.toString(),
          ApiKey.exhibitionId: exhibitionId,
        });
        break;
    }
  }

  /// Populates the product list for diamond.
  void _populateDiamondProductList(List<DiamondDataModel> diamondDataList) {
    productList = List.generate(
      diamondDataList.length,
      (index) => ProductDetailsModel(
        productId: diamondDataList[index].id,
        imageUrl: (diamondDataList[index].image.isNotNullNorEmpty) ? diamondDataList[index].image.first.url : '',
        title: diamondDataList[index].lotCode,
        subTitle: diamondDataList[index].rmDescription,
        originalPrice: diamondDataList[index].discountPrice,
        isCommentVisible: true,
      ),
    );
  }

  /// Populates the product list for jewellery.
  void _populateJewelleryProductList(List<JewelleryDataModel> jewelleryDataList) {
    productList = List.generate(
      jewelleryDataList.length,
      (index) => ProductDetailsModel(
        productId: jewelleryDataList[index].id,
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
        isCommentVisible: true,
      ),
    );
  }

  /// Populates the product list for gemstone.
  void _populateGemstoneProductList(List<GemstoneDatum> gemstoneDataList) {
    productList = List.generate(
      gemstoneDataList.length,
      (index) => ProductDetailsModel(
        productId: gemstoneDataList[index].id,
        imageUrl: (gemstoneDataList[index].image.isNotNullNorEmpty) ? gemstoneDataList[index].image.first.url : '',
        title: gemstoneDataList[index].lotCode,
        subTitle: gemstoneDataList[index].rmDescription,
        originalPrice: (gemstoneDataList[index].discountPrice ?? 0).toString(),
        isCommentVisible: true,
      ),
    );
  }

  /// Populates the product list for CAD library.
  void _populateCadLibraryProductList(List<CadLibraryListItemDataModel> cadLibraryListItemDataList) {
    productList = List.generate(
      cadLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: cadLibraryListItemDataList[index].sId,
        imageUrl:
            (cadLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false) ? cadLibraryListItemDataList[index].images?.first : '',
        title: cadLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: cadLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: cadLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: cadLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: true,
      ),
    );
  }

  /// Populates the product list for design library.
  void _populateDesignLibraryProductList(List<DesignLibraryListItemDataModel> designLibraryListItemDataList) {
    productList = List.generate(
      designLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: designLibraryListItemDataList[index].sId,
        imageUrl: (designLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? designLibraryListItemDataList[index].images?.first
            : '',
        title: designLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: designLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: designLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: designLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: true,
      ),
    );
  }

  /// Populates the product list for style library.
  void _populateStyleLibraryProductList(List<CadLibraryListItemDataModel> styleLibraryListItemDataList) {
    productList = List.generate(
      styleLibraryListItemDataList.length,
      (index) => ProductDetailsModel(
        productId: styleLibraryListItemDataList[index].sId,
        imageUrl: (styleLibraryListItemDataList[index].images?.isNotNullNorEmpty ?? false)
            ? styleLibraryListItemDataList[index].images?.first
            : '',
        title: styleLibraryListItemDataList[index].contractNoSkuNo,
        subTitle: styleLibraryListItemDataList[index].productDescription ?? '',
        kgkCollectionName: styleLibraryListItemDataList[index].kgkCollection ?? "\n",
        businessCategoryName: styleLibraryListItemDataList[index].businessCategoryName ?? "\n",
        isCommentVisible: true,
      ),
    );
  }

  /// Populates the product list for SKU library.
  void _populateSkuLibraryProductList(List<SkuProductModel> skuProductList) {
    productList = List.generate(
      skuProductList.length,
      (index) => ProductDetailsModel(
        productId: skuProductList[index].sId,
        imageUrl: (skuProductList[index].multipleFinishedViewImage?.isNotNullNorEmpty ?? false)
            ? skuProductList[index].multipleFinishedViewImage?.first.imageUrl
            : '',
        title: skuProductList[index].contractNumber,
        subTitle: skuProductList[index].productDescription ?? '',
        kgkCollectionName: skuProductList[index].kgkCollection ?? "\n",
        businessCategoryName: skuProductList[index].businessCategoryName ?? "\n",
        originalPrice: skuProductList[index].discountPrice,
        isCommentVisible: true,
      ),
    );
  }
}
