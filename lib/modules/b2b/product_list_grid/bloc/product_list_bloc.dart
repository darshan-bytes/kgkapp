import 'package:kgk/kgk.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

/// Enum for Fetch Scenarios
enum FetchScenario {
  productId,
  collectionName,
  regularList,
  recentlyViewed,
  dealOfTheDay,
}

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  UserType userType = UserType.b2cUser;
  bool isGrid = true;
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
  FetchScenario fetchScenario = FetchScenario.dealOfTheDay;

  List<FilterData> filterData = [];
  List<JewelleryDataModel> jewelleryDatumList = [];
  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;

  List<SortOptions> sortOptions = [];

  ProductListBloc() : super(ProductListInitial()) {
    on<InitialProductListEvent>(_onInitialProductListEvent);
    on<ProductListLoadMoreEvent>(_onProductListLoadMoreEvent);
    on<ProductChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<ProductListPullToRefreshEvent>(_onProductListPullToRefresh);
    on<ProductListAddToWatchListEvent>(_onProductListAddToWatchList);
    on<ProductSortEvent>(_onProductSortEvent);
    on<ProductFilterEvent>(_onProductFilterEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    wishlistUpdaterServiceStream?.cancel();
    return super.close();
  }

  /// Event handlers
  Future<void> _onInitialProductListEvent(InitialProductListEvent event, Emitter<ProductListState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onProductListLoadMoreEvent(ProductListLoadMoreEvent event, Emitter<ProductListState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onProductListPullToRefresh(ProductListPullToRefreshEvent event, Emitter<ProductListState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  void _onChangeListingTypeEvent(ProductChangeListingTypeEvent event, Emitter<ProductListState> emit) {
    _toggleViewType(emit: emit, isGridValue: event.isGrid);
  }

  Future<void> _onProductListAddToWatchList(ProductListAddToWatchListEvent event, Emitter<ProductListState> emit) async {
    await _addToWatchList(event.context, event.productId);
  }

  Future<void> _onProductSortEvent(ProductSortEvent event, Emitter<ProductListState> emit) async {
    sortKey = event.sortData.sortKey ?? "";
    sortValue = event.sortData.sortValue ?? "";
    _handlePullToRefresh(event.context, emit);
  }

  ///Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<ProductListState> emit) async {
    userType = BlocProvider.of<AppBloc>(context).userType;
    _initWishlistUpdaterServiceBloc(context);
    await _sortOptionListApiCall(context);
    emit(ReloadProductState());
    _initializePagination(context);
    getRouteData(context);
    await _loadInitialData(context, emit);
    emit(const ProductListLoadedState());
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
      productId = data[RoutesData.productId] ?? "";
      collectionName = data[RoutesData.collectionName] ?? "";
      productNavigation = data[RoutesData.productNavigation] ?? AppConst.youMayLike;
      fetchScenario = data[RoutesData.dealsOfTheDay] ?? FetchScenario.dealOfTheDay;
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

  Future<void> _sortOptionListApiCall(BuildContext context) async {
    ///fetch sort options
    List<SortOptions> sortOptionsList = await StorageManager().getSortingList(Commodity.jewellery.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
    }
  }

  void _initializePagination(BuildContext context) {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProductListLoadMoreEvent(currentPage, context));
      },
    );
  }

  Future<void> _loadInitialData(BuildContext context, Emitter<ProductListState> emit) async {
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      appbarTitle = APPStrings.ring.tr;
      productList.clear();
      if (filterData.isEmpty) {
        await _setupFilters(context);
      }
      await fetchJewelleriesList(context, emit, true);
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
        ),
      );
    }
  }

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
        if (filter.filterType == FilterType.range) {
          if (filterOption.data.isNotEmpty) {
            filter.rangeValues = SfRangeValues(0, filterOption.data.first.toDouble());
            filter.minMaxValues = SfRangeValues(0, filterOption.data.last.toDouble());
          } else {
            continue;
          }
        }
        filterData.add(filter);
      }
    }
  }

  Future<void> fetchJewelleriesList(
    BuildContext context,
    Emitter<ProductListState> emit,
    bool isLoadMore, {
    Map<String, String>? query,
  }) async {
    Either<ErrorResponse, JewelleryListingModel>? response;
    FetchScenario scenario = determineFetchScenario();
    query ??= {};
    filterData
        .where(
            (element) => (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) || element.filterType == FilterType.range)
        .forEach(
      (element) {
        if (element.filterType == FilterType.range) {
          query!['${element.code}[min]'] = element.rangeValues?.start.toString() ?? '';
          query['${element.code}[max]'] = element.rangeValues?.end.toString() ?? '';
        } else {
          query![element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
        }
      },
    );

    switch (scenario) {
      case FetchScenario.productId:
        response = await AppRepository(context).getJewelleryYouMayLike(productId,
            limit: AppConst.pageLimit.toString(), isLoadMore: false, page: paginationScrollController.currentPage.toString());
        break;
      case FetchScenario.collectionName:
        response = await AppRepository(context).fetchJewelleryList(
            page: paginationScrollController.currentPage.toString(),
            isLoadMore: isLoadMore,
            limit: AppConst.pageLimit.toString(),
            type: '',
            sortKey: sortKey,
            sortValue: sortValue,
            query: {ApiKey.kgkCollection: collectionName});
        break;
      case FetchScenario.regularList:
        response = await AppRepository(context).fetchJewelleryList(
          page: paginationScrollController.currentPage.toString(),
          isLoadMore: isLoadMore,
          limit: AppConst.pageLimit.toString(),
          type: '',
          sortKey: sortKey,
          sortValue: sortValue,
          query: query,
        );
        break;
      case FetchScenario.recentlyViewed:
        response = await AppRepository(context).getRecentlyViewedProductList(
            limit: AppConst.pageLimit.toString(), page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore);
        break;

      case FetchScenario.dealOfTheDay:
        response = await AppRepository(context).getJewelleryDealOfTheDayProductList(
          page: paginationScrollController.currentPage.toString(),
          limit: AppConst.pageLimit.toString(),
          isLoadMore: isLoadMore,
        );
        break;
    }

    response?.fold((error) => Utils.showMessage(error.message), (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final localList = success.data;
      productList.addAll(localList
          .map((item) => ProductDetailsModel(
                  suid: item.suid ?? "",
                  imageUrl: item.multipleFinishedViewImage.isNotNullNorEmpty ? item.multipleFinishedViewImage[0].imageUrl : "",
                  name: item.productDescription ?? "",
                  originalPrice: item.finalPrice?.setCurrency,
                  offerPrice: item.discountPrice?.setCurrency,
                  finalPrice: item.discountPrice?.setCurrency,
                  discountPercentage: APPStrings.percentageOffInterpolating.tr.interpolate([item.discountPercentage]),
                  productId: item.id ?? "",
                  commodity: Commodity.jewellery,
                  isFavourite: item.isFavorite,
                  wishlistId: item.wishlistID,
                  productSku: item.contractNoSkuNo,
                  title: item.contractNoSkuNo ?? '',
                  subTitle: item.productDescription ?? '',
                  kgkCollectionName: item.kgkCollection ?? "\n",
                  businessCategoryName: item.businessCategoryName ?? "\n",
                  cts: item.crt,
                  gms: item.gms,
                  brandName: item.brandName,
                  colorsCode: [
                    item.metalColor1HexCode ?? "",
                    item.metalColor2HexCode ?? "",
                    item.metalColor3HexCode ?? "",
                  ]))
          .toList());
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const ProductListLoadedState());
    });
  }

  FetchScenario determineFetchScenario() {
    if (productId.isNotNullNorEmpty) return FetchScenario.productId;
    if (collectionName.isNotNullNorEmpty) return FetchScenario.collectionName;
    if (productNavigation.isNotNullNorEmpty && productNavigation == AppConst.recentlyViewed) return FetchScenario.recentlyViewed;
    if (fetchScenario == FetchScenario.dealOfTheDay) return FetchScenario.dealOfTheDay;
    return FetchScenario.regularList;
  }

  void _toggleViewType({bool isGridValue = false, required Emitter<ProductListState> emit}) {
    emit(ReloadProductState());
    isGrid = isGridValue;
    emit(ProductChangeListingTypeState());
  }

  Future<void> _handleLoadMore(BuildContext context, Emitter<ProductListState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(ProductListLoadingMoreState());
      await fetchJewelleriesList(context, emit, false);
      emit(ProductListLoadedMoreState(currentPage + 1));
    }
  }

  Future<void> _handlePullToRefresh(BuildContext context, Emitter<ProductListState> emit) async {
    paginationScrollController.pullToRefresh();
    productList.clear();
    await _loadInitialData(context, emit);
    emit(const ProductListLoadedState());
  }

  Future<void> _addToWatchList(BuildContext context, String productId) async {
    ProductDetailsModel? product = productList.firstWhereOrNull((element) => element.productId == productId);
    if (product != null) {
      BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.add(product, context));
      await Utils.showSmartModalBottomSheet(context: context, enableDrag: false, builder: (context) => const AddWatchlistScreen());
    }
  }

  Future<void> _onProductFilterEvent(ProductFilterEvent event, Emitter<ProductListState> emit) async {
    emit(ReloadProductState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    filterData = event.filterData;
    await fetchJewelleriesList(event.context, emit, true);
    emit(const ProductListLoadedState());
  }
}
