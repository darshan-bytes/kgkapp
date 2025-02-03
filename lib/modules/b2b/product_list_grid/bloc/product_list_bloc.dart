import 'package:kgk/kgk.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

/// Defines different scenarios under which the product list can be fetched.
enum FetchScenario {
  /// Fetch based on product ID
  productId,

  /// Fetch based on collection name
  collectionName,

  /// Fetch recently viewed products
  recentlyViewed,

  /// Fetch "Deal of the Day" products
  dealOfTheDay,

  /// Fetch a regular product list
  regularList,

  /// Fetch recently viewed jewellery
  recentlyViewedJewellery,

  /// Couture collection
  coutureCollection,
}

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  /// Determines if the view is in grid or list mode
  bool isGrid = true;

  /// App bar title for the screen
  String appbarTitle = APPStrings.jewellery.tr;

  /// Identifier for the current screen type
  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;

  /// The total number of filtered records
  int? totalFilteredRecords;

  /// Controller for managing pagination
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// Variables for managing pagination and filtering
  String productId = "";
  String collectionName = "";
  String productNavigation = '';
  FetchScenario fetchScenario = FetchScenario.dealOfTheDay;

  /// Variables for sorting
  String sortKey = AppConst.sortKeyNERPBS;
  String sortValue = AppConst.sortValueDesc;

  /// Stores filter data for products
  List<FilterData> filterData = [];

  /// Stores sorting options for the product list
  List<SortOptions> sortOptions = [];

  /// This model is used to transfer data between the BLoC and the screen for displaying the product list in the UI
  List<ProductDetailsModel> productList = [];

  /// This model contains the actual data fetched, but we use ProductDetailsModel for displaying the data at the UI level
  List<JewelleryDataModel> jewelleryDatumList = [];

  /// Stream subscription for wishlist updates
  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;

  /// Constructor: Sets up event handlers
  ProductListBloc() : super(ProductListInitial()) {
    on<InitialProductListEvent>(_onInitialProductListEvent);
    on<ProductListLoadMoreEvent>(_onProductListLoadMoreEvent);
    on<ProductChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<ProductListPullToRefreshEvent>(_onProductListPullToRefresh);
    on<ProductListAddToWatchListEvent>(_onProductListAddToWatchList);
    on<ProductSortEvent>(_onProductSortEvent);
    on<ProductFilterEvent>(_onProductFilterEvent);
  }

  /// Override close to clean up resources
  @override
  Future<void> close() {
    paginationScrollController.dispose();
    wishlistUpdaterServiceStream?.cancel();
    return super.close();
  }

  /// Handler for initializing the product list
  Future<void> _onInitialProductListEvent(InitialProductListEvent event, Emitter<ProductListState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// Handler for loading more products when user scrolls
  Future<void> _onProductListLoadMoreEvent(ProductListLoadMoreEvent event, Emitter<ProductListState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  /// Handler for refreshing the product list
  Future<void> _onProductListPullToRefresh(ProductListPullToRefreshEvent event, Emitter<ProductListState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  /// Handler for toggling between grid and list view
  void _onChangeListingTypeEvent(ProductChangeListingTypeEvent event, Emitter<ProductListState> emit) {
    _toggleViewType(emit: emit, isGridValue: event.isGrid);
  }

  /// Handler for adding a product to the watchlist
  Future<void> _onProductListAddToWatchList(ProductListAddToWatchListEvent event, Emitter<ProductListState> emit) async {
    await _addToWatchList(event.context, event.productId);
  }

  /// Handler for sorting the product list
  Future<void> _onProductSortEvent(ProductSortEvent event, Emitter<ProductListState> emit) async {
    sortKey = event.sortData.sortKey ?? "";
    sortValue = event.sortData.sortValue ?? "";
    await _handlePullToRefresh(event.context, emit);
  }

  /// Handler for filtering the product list
  Future<void> _onProductFilterEvent(ProductFilterEvent event, Emitter<ProductListState> emit) async {
    emit(ProductListLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    jewelleryDatumList.clear();
    filterData = event.filterData;
    await fetchJewelleriesList(event.context, emit, false);
    emit(const ProductListLoadedState());
  }

  ///Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<ProductListState> emit) async {
    emit(ProductListLoadingState());
    getRouteData(context);
    _initializePagination(context);
    await _sortOptionListApiCall(context);
    if (filterData.isEmpty) {
      emit(ReloadProductState());
      await _setupFilters(context);
      emit(ProductListFilterLoadedState());
    }
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await _loadInitialData(context, emit);
    }
    emit(const ProductListLoadedState());
    _initWishlistUpdaterServiceBloc(context);
  }

  /// Fetches data from the current route (navigation)
  void getRouteData(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
      productId = data[RoutesData.productId] ?? "";
      collectionName = data[RoutesData.collectionName] ?? "";
      productNavigation = data[RoutesData.productNavigation] ?? AppConst.youMayLike;
      fetchScenario = data[RoutesData.dealsOfTheDay] ?? FetchScenario.regularList;
    }

    /// Here we set the appbar title
    _getProductListName();
  }

  /// Fetches sort options for products
  Future<void> _sortOptionListApiCall(BuildContext context) async {
    List<SortOptions> sortOptionsList = await StorageManager().getSortingList(Commodity.jewellery.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
    }
  }

  /// Initializes pagination behavior
  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProductListLoadMoreEvent(currentPage, context));
      },
    );
  }

  /// jewellery product list main api call method
  Future<void> _loadInitialData(BuildContext context, Emitter<ProductListState> emit) async {
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      productList.clear();
      jewelleryDatumList.clear();
      await fetchJewelleriesList(context, emit, false);
    }

    if (screenIdentifier == ScreenIdentifier.productForCouture) {
      productList.clear();
      jewelleryDatumList.clear();
      await fetchJewelleriesList(context, emit, false);
      if (filterData.isEmpty) {
        emit(ReloadProductState());
        await _setupFilters(context);
        emit(ProductListFilterLoadedState());
      }
    }
  }

  // Future<void> fetchKgkCoutureData(BuildContext context, Emitter<ProductListState> emit, bool isLoadMore,
  //     {Map<String, String>? query}) async {
  //   try {
  //     final response = await AppRepository(context).homePageKgkCoutureCollections(
  //         page: AppConst.page1.toString(), limit: AppConst.pageLimit10.toString(), kgkCollection: kgkCollection, isLoadMore: true);
  //     response?.fold(
  //       (l) {
  //         //Utils.showMessage(l.message);
  //       },
  //       (r) {
  //         productList = List.generate(
  //           r.dataList?.length ?? 0,
  //           (index) {
  //             KgkCoutureDetails item = r.dataList![index];
  //             return ProductDetailsModel(
  //               productId: item.suid ?? '',
  //               commodity: Commodity.jewellery,
  //               imageUrl: item.multipleFinishedViewImage ?? '',
  //               title: item.jewelleryTypeName ?? '',
  //               subTitle: item.productDescription ?? '',
  //               originalPrice: item.finalPrice?.toString().setCurrency ?? '-',
  //               offerPrice: item.discountPrice?.toString().setCurrency ?? '',
  //             );
  //           },
  //         );
  //       },
  //     );
  //   } catch (e) {
  //     // Utils.showMessage(e.toString());
  //   }
  // }

  /// Determine the fetch scenario
  FetchScenario determineFetchScenario() {
    if (productId.isNotNullNorEmpty && (productNavigation.isNotNullNorEmpty && productNavigation == AppConst.youMayLike)) {
      return FetchScenario.productId;
    }
    if (collectionName.isNotNullNorEmpty) return FetchScenario.collectionName;
    if (productNavigation.isNotNullNorEmpty && productNavigation == AppConst.recentlyViewed) {
      return FetchScenario.recentlyViewed;
    }
    if (productNavigation.isNotNullNorEmpty && productNavigation == AppConst.coutureCollection) {
      return FetchScenario.coutureCollection;
    }
    if (fetchScenario == FetchScenario.dealOfTheDay) return FetchScenario.dealOfTheDay;
    return FetchScenario.regularList;
  }

  /// Builds the filter query
  Map<String, String> buildFilterQuery(Map<String, String> query, List<FilterData> filterData) {
    filterData.where((element) {
      return (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) ||
          (element.filterType == FilterType.range && element.rangeValues != null);
    }).forEach(
      (element) {
        if (element.filterType == FilterType.range) {
          query['${element.code}[min]'] = element.rangeValues?.start.toString() ?? '';
          query['${element.code}[max]'] = element.rangeValues?.end.toString() ?? '';
        } else {
          query[element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
        }
      },
    );
    return query;
  }

  /// Fetches jewellery product list
  Future<void> fetchJewelleriesList(BuildContext context, Emitter<ProductListState> emit, bool isLoadMore,
      {Map<String, String>? query}) async {
    emit(ReloadProductState());

    /// Determine the scenario for fetching data
    FetchScenario scenario = determineFetchScenario();

    /// Initialize query if it's null
    query ??= {};

    /// Build the query based on filters
    query = buildFilterQuery(query, filterData);

    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    Either<ErrorResponse, JewelleryListingModel>? response;

    /// Fetch data based on the scenario
    switch (scenario) {
      case FetchScenario.productId:
        response = await fetchByProductId(context: context);
        break;
      case FetchScenario.collectionName:
        if (query.isEmpty) {
          query.addAll({ApiKey.kgkCollection: collectionName});
        }
        response = await fetchByCollectionName(context: context, isLoadMore: isLoadMore, query: query);
        break;
      case FetchScenario.regularList:
        response = await fetchRegularList(context: context, isLoadMore: isLoadMore, query: query);
        break;
      case FetchScenario.recentlyViewed:
        response = await fetchRecentlyViewed(context: context, isLoadMore: isLoadMore);
        break;
      case FetchScenario.recentlyViewedJewellery:
        response = await fetchRecentlyViewedJewellery(context: context, isLoadMore: isLoadMore);
        break;
      case FetchScenario.dealOfTheDay:
        response = await fetchDealOfTheDay(context: context, isLoadMore: isLoadMore);
        break;
      case FetchScenario.coutureCollection:
        // response = await fetchKgkCoutureData(context, emit, isLoadMore, query: query);
        break;
    }

    /// Handle the response and update the state
    await response?.fold(
      (error) => Utils.showMessage(error.message),
      (success) async {
        await handleSuccessResponse(success, emit);
      },
    );

    /// Update the state
    emit(ProductListLoadedState());
  }

  /// Handle the success response
  Future<void> handleSuccessResponse(JewelleryListingModel success, Emitter<ProductListState> emit) async {
    totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
    final localList = success.data;

    /// Show the total number of records in the UI side
    totalFilteredRecords = success.filteredRecords;
    jewelleryDatumList.addAll(localList);
    productList.addAll(localList.map((item) => mapToProductDetailsModel(item)));

    /// Below Code is commented as of now to avoid the precache of images.
    // printWrapped("precacheImageList-start-time: ${DateTime.now()}");
    // await Future.forEach(productList, (productDetails) async {
    //   bool canLaunch = false;
    //   try {
    //     await DefaultCacheManager().downloadFile(productDetails.imageUrl ?? '', force: true);
    //     canLaunch = true;
    //   } catch (e) {
    //     canLaunch = false;
    //   }
    //   if (!canLaunch) {
    //     productDetails.imageUrl = '';
    //     int index = productList.indexWhere((element) => element.productId == productDetails.productId);
    //     if (index != -1) {
    //       productList[index].imageUrl = '';
    //     }
    //   }
    // });
    // // List<String> imageUrlList = productList.where((e) => e.imageUrl.isNullOrEmpty).map((e) => e.imageUrl ?? '').toList();
    // // await Utils.precacheImageList(imageUrlList);
    // printWrapped("precacheImageList-end-time: ${DateTime.now()}");
    if (paginationScrollController.isPageLoaded.isCompleted) {
      paginationScrollController.isPageLoaded = Completer<bool>();
    }
    paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
  }

  /// Helper function to map the product data into ProductDetailsModel
  ProductDetailsModel mapToProductDetailsModel(JewelleryDataModel item) {
    return ProductDetailsModel(
      suid: item.suid ?? "",
      imageUrl: item.multipleFinishedViewImage.isNotNullNorEmpty ? item.multipleFinishedViewImage[0].imageUrl : "",
      name: item.productDescription ?? "",
      originalPrice: item.finalPrice?.toString().setCurrency,
      offerPrice: item.discountPrice?.toString().setCurrency,
      finalPrice: item.discountPrice?.toString().setCurrency,
      discountPercentageString: item.discountEXT,
      productId: item.id ?? "",
      commodity: Commodity.jewellery,
      isFavourite: item.isFavorite,
      wishlistId: item.wishlistID,
      productSku: item.contractNoSkuNo,
      title: item.contractNoSkuNo ?? '',
      subTitle: item.productDescription ?? '',
      kgkCollectionName: item.kgkCollection ?? "\n",
      businessCategoryName: item.businessCategoryName ?? "\n",
      cts: item.crtEXT,
      gms: item.gms,
      brandName: item.brandName,
      isAddedToCart: item.isAddedToCart,
      colorsCode: [
        item.metalColor1HexCode ?? "",
        item.metalColor2HexCode ?? "",
        item.metalColor3HexCode ?? "",
      ],
    );
  }

  /// Fetch products by productId
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchByProductId({required BuildContext context}) async {
    return AppRepository(context).getJewelleryYouMayLike(
      productId,
      limit: AppConst.pageLimit.toString(),
      isLoadMore: false,
      page: paginationScrollController.currentPage.toString(),
    );
  }

  /// Fetch products by collection name
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchByCollectionName(
      {required BuildContext context, bool isLoadMore = false, Map<String, String>? query}) async {
    return AppRepository(context).fetchJewelleryList(
      page: paginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
      limit: AppConst.pageLimit.toString(),
      type: '',
      sortKey: sortKey,
      sortValue: sortValue,
      query: query,
    );
  }

  /// Fetch the regular list of products
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchRegularList(
      {required BuildContext context, bool isLoadMore = false, required Map<String, String> query}) async {
    return AppRepository(context).fetchJewelleryList(
      page: paginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
      limit: AppConst.pageLimit.toString(),
      type: '',
      sortKey: sortKey,
      sortValue: sortValue,
      query: query,
    );
  }

  /// Fetch recently viewed products
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchRecentlyViewed(
      {required BuildContext context, bool isLoadMore = false}) async {
    return AppRepository(context).getRecentlyViewedProductList(
      limit: AppConst.pageLimit.toString(),
      page: paginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
    );
  }

  /// Fetch recently viewed jewellery products
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchRecentlyViewedJewellery(
      {required BuildContext context, bool isLoadMore = false}) async {
    return AppRepository(context).getRecentlyViewedProductList(
      limit: AppConst.pageLimit.toString(),
      page: paginationScrollController.currentPage.toString(),
      isLoadMore: isLoadMore,
    );
  }

  /// Fetch deal of the day products
  Future<Either<ErrorResponse, JewelleryListingModel>?> fetchDealOfTheDay({required BuildContext context, bool isLoadMore = false}) async {
    return AppRepository(context).getJewelleryDealOfTheDayProductList(
      page: paginationScrollController.currentPage.toString(),
      limit: AppConst.pageLimit.toString(),
      isLoadMore: isLoadMore,
    );
  }

  /// Load more products
  Future<void> _handleLoadMore(BuildContext context, Emitter<ProductListState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(ProductListLoadingMoreState());
      await fetchJewelleriesList(context, emit, false);
      emit(ProductListLoadedMoreState(currentPage));
    }
  }

  /// Refresh the product list
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<ProductListState> emit) async {
    emit(ProductListLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    jewelleryDatumList.clear();
    await _loadInitialData(context, emit);
    emit(const ProductListLoadedState());
  }

  /// Toggle between grid and list view
  void _toggleViewType({bool isGridValue = false, required Emitter<ProductListState> emit}) {
    emit(ReloadProductState());
    isGrid = isGridValue;
    emit(ProductChangeListingTypeState());
  }

  /// Add a product to the watchlist
  Future<void> _addToWatchList(BuildContext context, String productId) async {
    ProductDetailsModel? product = productList.firstWhereOrNull((element) => element.productId == productId);
    if (product != null) {
      BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.add(product, context));
      await Utils.showSmartModalBottomSheet(context: context, enableDrag: false, builder: (context) => const AddWatchlistScreen());
    }
  }

  /// Initialize the wishlist updater service
  void _initWishlistUpdaterServiceBloc(BuildContext context) {
    WishlistUpdaterServiceBloc wishlistUpdaterServiceBloc = BlocProvider.of<WishlistUpdaterServiceBloc>(context);
    wishlistUpdaterServiceStream = wishlistUpdaterServiceBloc.stream.listen((state) {
      if (state is WishListUpdateProductState) {
        try {
          if (screenIdentifier == ScreenIdentifier.productForRing) {
            int index = jewelleryDatumList.indexWhere((element) => element.suid == state.productId);
            if (index != -1) {
              if (state.wishlistId.isNotEmpty) {
                jewelleryDatumList[index].isFavorite = true;
                jewelleryDatumList[index].wishlistID = state.wishlistId;
              } else {
                jewelleryDatumList[index].isFavorite = false;
                jewelleryDatumList[index].wishlistID = "";
              }
              productList[index].isFavourite = jewelleryDatumList[index].isFavorite;
              productList[index].wishlistId =
                  jewelleryDatumList[index].wishlistID.isNotNullNorEmpty ? jewelleryDatumList[index].wishlistID : null;
            }
          }
        } catch (e) {
          printWrapped(e.toString());
        }
      }
    });
  }

  /// Setup filters
  Future<void> _setupFilters(BuildContext context) async {
    final filterList = await BlocProvider.of<AppBloc>(context).getFilterOptionList(context, AppConst.jewellery);
    filterData.clear();
    for (FilterOptionModel filterOption in filterList) {
      if (filterOption.data.isNotEmpty) {
        FilterData filter = FilterData(
          name: filterOption.name,
          code: filterOption.slug,
          inputType: filterOption.inputType,
          filterType: filterOption.filterType,
          subFilterCodes: filterOption.data.map((e) => e.toString()).join(','),
          secondaryFilterData: [],
        );
        if (!filterOption.fromCommon) {
          filter.secondaryFilterData = filterOption.data.map((e) => SecondaryFilterData(name: e.toString(), code: e.toString())).toList();
        }
        if (filter.filterType == FilterType.range && filterOption.data.isNotEmpty) {
          if (filterOption.data.isNotEmpty) {
            filter.minMaxValues = SfRangeValues(0, filterOption.data.last.toDouble());
          } else {
            continue;
          }
        }
        filterData.add(filter);
      }
    }
  }

  void _getProductListName() {
    /// Determine the scenario for fetching data
    FetchScenario scenario = determineFetchScenario();
    appbarTitle = APPStrings.jewellery.tr;
    switch (scenario) {
      case FetchScenario.productId:
        appbarTitle = APPStrings.youMayAlsoLike.tr;
        break;
      case FetchScenario.regularList:
      case FetchScenario.collectionName:
        appbarTitle = collectionName.isNotNullNorEmpty ? collectionName : APPStrings.jewellery.tr;
        break;
      case FetchScenario.dealOfTheDay:
        appbarTitle = APPStrings.dealOfTheDay.tr;
        break;
      case FetchScenario.recentlyViewed || FetchScenario.recentlyViewedJewellery:
        appbarTitle = APPStrings.recentlyViewed.tr;
        break;
      case FetchScenario.coutureCollection:
        appbarTitle = APPStrings.jewellery.tr;
        break;
    }
  }
}
