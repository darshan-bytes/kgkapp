import 'package:kgk/kgk.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

// Using this enum identifies different fetch scenarios
enum FetchScenario {
  productId,
  collectionName,
  regularList,
  recentlyViewed,
}

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  // For Product List view
  bool isGrid = true;

  // For Watchlist

  String appbarTitle = APPStrings.ring.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;

  List<ProductDetailsModel> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  int? totalNumberOfPages;

  String productId = "";
  String productNavigation = '';
  String sortKey = AppConst.sortKeySuid;
  String sortValue = AppConst.sortValueAsc;

  String collectionName = "";

  List<JewelleryDataModel> jewelleryDatumList = [];
  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;
  List<FilterOptionModel> filterList = [];

  ProductListBloc() : super(ProductListInitial()) {
    on<InitialProductListEvent>(_onInitialProductListEvent);
    on<ProductListLoadMoreEvent>(_onProductListLoadMoreEvent);
    on<ProductChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<ProductListPullToRefreshEvent>(_onProductListPullToRefresh);
    on<ProductListAddToWatchListEvent>(_onProductListAddToWatchList);
    on<ProductSortEvent>(_onProductSortEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    wishlistUpdaterServiceStream?.cancel();
    return super.close();
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
      productId = data[RoutesData.productId] ?? "";
      collectionName = data[RoutesData.collectionName] ?? "";
      productNavigation = data[RoutesData.productNavigation] ?? AppConst.youMayLike;
    }
  }

  Future<void> _onInitialProductListEvent(InitialProductListEvent event, Emitter<ProductListState> emit) async {
    // assigning current userType
    userType = BlocProvider.of<AppBloc>(event.context).userType;
    _initWishlistUpdaterServiceBloc(event.context);
    _sortOptionListApiCall(event.context);

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }

    emit(ReloadProductState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProductListLoadMoreEvent(currentPage, event.context));
      },
    );
    isGrid = true;
    getRouteData(event.context);

    if (screenIdentifier == ScreenIdentifier.productForRing) {
      appbarTitle = APPStrings.ring.tr;
      productList.clear();
      filterList = [
        FilterOptionModel(
          name: "Type",
          slug: "type",
          defaultValue: "",
          inputType: "checkbox",
          data: [],
          id: 1,
        ),
        FilterOptionModel(
          name: "Color",
          slug: "color",
          defaultValue: "",
          inputType: "slider",
          data: [],
          id: 2,
        ),
        FilterOptionModel(
          name: "Clarity",
          slug: "clarity",
          defaultValue: "",
          inputType: "checkbox",
          data: [],
          id: 3,
        ),
        FilterOptionModel(
          name: "Shape",
          slug: "shape",
          defaultValue: "",
          inputType: "slider",
          data: [],
          id: 4,
        )
      ];

      /// TODO :: THIS API IS COMMENTED TEMPORARY TO GET STATIC DATA OF FILTER OPTIONS
      // gemstoneFilterList = await BlocProvider.of<AppBloc>(event.context).getFilterOptionList(event.context, 'jewellery');
      await fetchJewelleriesList(event.context, emit, true);
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      appbarTitle = APPStrings.diamonds.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetailsModel(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000.00",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetailsModel(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetailsModel(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/Lk4H7Wj/image-7-1.png" : "https://i.ibb.co/Gxkhf7J/image-7.png",
                  name: "Diamond Vine Ring in 18k Yellow Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    }
    emit(const ProductListLoadedState());
  }

  FetchScenario determineFetchScenario({String? productId, String? collectionName}) {
    if (productId.isNotNullNorEmpty) {
      return FetchScenario.productId;
    } else if (collectionName.isNotNullNorEmpty) {
      return FetchScenario.collectionName;
    } else if (productNavigation.isNotNullNorEmpty && productNavigation == AppConst.recentlyViewed) {
      return FetchScenario.recentlyViewed;
    } else {
      return FetchScenario.regularList;
    }
  }

  Future<void> fetchJewelleriesList(BuildContext context, Emitter<ProductListState> emit, bool isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";

    Either<ErrorResponse, JewelleryListingModel>? response;

    FetchScenario scenario = determineFetchScenario(productId: productId, collectionName: collectionName);

    switch (scenario) {
      case FetchScenario.productId:
        // For You May Like API
        response = await AppRepository(context).getJewelleryYouMayLike(
          productId,
          limit: AppConst.pageLimit.toString(),
          isLoadMore: true,
          page: paginationScrollController.currentPage.toString(),
        );
        break;

      case FetchScenario.collectionName:
        // For collection filter API
        response = await AppRepository(context).fetchJewelleryList(
          page: paginationScrollController.currentPage.toString(),
          isLoadMore: isLoadMore,
          limit: AppConst.pageLimit.toString(),
          type: '',
          sortKey: sortKey,
          sortValue: sortValue,
          query: {ApiKey.kgkCollection: collectionName},
        );
        break;

      case FetchScenario.regularList:
        // For jewellery list API
        response = await AppRepository(context).fetchJewelleryList(
          page: paginationScrollController.currentPage.toString(),
          isLoadMore: isLoadMore,
          limit: AppConst.pageLimit.toString(),
          type: '',
          sortKey: sortKey,
          sortValue: sortValue,
        );
        break;

      case FetchScenario.recentlyViewed:
        // For jewellery list API
        response = await AppRepository(context).getRecentlyViewedProductList(
            limit: AppConst.pageLimit.toString(), page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore);
        break;
    }

    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) {
      jewelleryDatumList = r.data;
      r.totalRecords ??= 0;
      totalNumberOfPages = Utils.calculateTotalPages(r.totalRecords, AppConst.pageLimit);

      List.generate(jewelleryDatumList.length, (index) {
        productList.add(ProductDetailsModel(
          imageUrl: jewelleryDatumList[index].multipleFinishedViewImage.isNotNullNorEmpty
              ? jewelleryDatumList[index].multipleFinishedViewImage[0].imageUrl
              : "",
          name: jewelleryDatumList[index].productDescription ?? "",
          originalPrice: jewelleryDatumList[index].finalPrice?.setCurrency,
          discountPercentage: APPStrings.percentageOffInterpolating.tr.interpolate([jewelleryDatumList[index].discountPercentage]),
          offerPrice: jewelleryDatumList[index].discountPrice?.setCurrency,
          productId: jewelleryDatumList[index].id ?? "",
          commodity: Commodity.jewellery,
          productSku: jewelleryDatumList[index].contractNoSkuNo,
          company: jewelleryDatumList[index].brandName,
          isFavourite: jewelleryDatumList[index].isFavorite,
          wishlistId: jewelleryDatumList[index].wishlistID,
        ));
      });

      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
    });
  }

  Future<void> _onProductListLoadMoreEvent(ProductListLoadMoreEvent event, Emitter<ProductListState> emit) async {
    emit(ProductListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      await fetchJewelleriesList(event.context, emit, false);
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetailsModel(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000.00",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetailsModel(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetailsModel(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/Lk4H7Wj/image-7-1.png" : "https://i.ibb.co/Gxkhf7J/image-7.png",
                  name: "Diamond Vine Ring in 18k Yellow Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    }
    paginationScrollController.isPageLoaded.complete(event.currentPage == totalNumberOfPages);
    emit(ProductListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onProductListPullToRefresh(ProductListPullToRefreshEvent event, Emitter<ProductListState> emit) async {
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      appbarTitle = APPStrings.ring.tr;
      productList.clear();
      await fetchJewelleriesList(event.context, emit, true);
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      appbarTitle = APPStrings.diamonds.tr;
      productList.clear();
      productList = List.generate(
        20,
        (index) => ProductDetailsModel(
          diamond: "2.5 crt",
          gram: "1.5 grms",
          imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
          name: "2.00 Carat H VS1 Excellent Cut Round Setting",
          originalPrice: "\$3,000.00",
        ),
      ).toList();
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      productList = List.generate(
          20,
          (index) => ProductDetailsModel(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
              )).toList();
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      productList = List.generate(
          20,
          (index) => ProductDetailsModel(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/Lk4H7Wj/image-7-1.png" : "https://i.ibb.co/Gxkhf7J/image-7.png",
                name: "Diamond Vine Ring in 18k Yellow Gold",
                originalPrice: '\$5,000.00',
              )).toList();
    }
    refreshCompleter.complete(true);
    emit(const ProductListLoadedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(ProductListPullToRefreshEvent(context));
    bool result = await refreshCompleter.future;
    return result;
  }

  void _onChangeListingTypeEvent(ProductChangeListingTypeEvent event, Emitter<ProductListState> emit) {
    emit(ReloadProductState());
    isGrid = !isGrid;
    emit(ProductChangeListingTypeState());
  }

  Future<void> _onProductListAddToWatchList(ProductListAddToWatchListEvent event, Emitter<ProductListState> emit) async {
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      ProductDetailsModel? productDetails = productList.firstWhereOrNull((element) => element.productId == event.productId);
      if (productDetails != null) {
        BlocProvider.of<AddToWatchlistBloc>(event.context).add(AddToWatchlistInitialEvent.add(productDetails, event.context));
        await Utils.showSmartModalBottomSheet(
          context: event.context,
          enableDrag: false,
          useRootNavigator: true,
          builder: (context) => const AddWatchlistScreen(),
        );
      }
    }
  }

  void _initWishlistUpdaterServiceBloc(BuildContext context) {
    WishlistUpdaterServiceBloc wishlistUpdaterServiceBloc = BlocProvider.of<WishlistUpdaterServiceBloc>(context);
    wishlistUpdaterServiceStream = wishlistUpdaterServiceBloc.stream.listen((state) {
      if (state is WishListUpdateProductState) {
        try {
          if (screenIdentifier == ScreenIdentifier.productForRing) {
            int index = jewelleryDatumList.indexWhere((element) => element.id == state.productId);
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

  Future<void> _onProductSortEvent(ProductSortEvent event, Emitter<ProductListState> emit) async {
    sortKey = event.sortData.sortKey;
    sortValue = event.sortData.sortValue;
    pullToRefresh(event.context);
  }

  Future<void> _sortOptionListApiCall(BuildContext context) async {
    ///fetch sort options
    StorageManager().getSortingList(Commodity.diamond.value);
  }
}
