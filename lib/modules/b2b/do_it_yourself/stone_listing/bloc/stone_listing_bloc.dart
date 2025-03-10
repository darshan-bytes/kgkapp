import 'package:kgk/kgk.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  /// This variable is used to check whether the toggle is Precious tab or Semi Precious tab
  bool isInitialToggle = true;

  /// Determines if the view is in grid or list mode
  bool isGrid = true;

  /// Tab title
  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  /// App bar title for the screen
  String appbarTitle = '';

  /// Identifier for the current screen type
  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;

  /// The total number of filtered records
  int? totalFilteredRecords;

  /// Controller for managing pagination
  int? totalNumberOfPages;
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  /// Variables for managing pagination and filtering
  String productId = "";
  String productNavigation = "";
  Map<dynamic, String?>? filterDataMap;

  /// Variables for sorting
  String sortKey = AppConst.sortKeyUpdatedDateTime;
  String sortValue = AppConst.sortValueDesc;

  /// Stores filter data for products
  List<FilterData> filterData = [];

  /// Stores sorting options for the product list
  List<SortOptions> sortOptions = [];

  /// This model is used to transfer data between the BLoC and the screen for displaying the product list in the UI
  List<ProductDetailsModel> productList = [];

  /// This model contains the actual data fetched, but we use ProductDetailsModel for displaying the data at the UI level
  List<DiamondDataModel> diamondDatumList = [];
  List<GemstoneDatum> gemstoneDatumList = [];

  /// Stream subscription for wishlist updates
  StreamSubscription<WishlistUpdaterServiceState>? wishlistUpdaterServiceStream;

  /// Stone listing constructor
  StoneListingBloc() : super(const StoneListingInitial()) {
    on<GetStoneProductListEvent>(_onGetStoneProductListEvent);
    on<StoneChangeTypeEvent>(_onStoneChangeTypeEvent);
    on<StoneChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<StoneListLoadMoreEvent>(_onStoneListLoadMoreEvent);
    on<StoneListPullToRefreshEvent>(_onStoneListPullToRefresh);
    on<StoneListAddToWatchListEvent>(_onStoneListAddToWatchList);
    on<StoneSortEvent>(_onStoneSortEvent);
    on<StoneListingFilterEvent>(_onStoneListingFilterEvent);
  }

  bool get displaySelection => productId.isEmpty;

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    wishlistUpdaterServiceStream?.cancel();
    return super.close();
  }

  /// Handler for initializing the stone list
  Future<void> _onGetStoneProductListEvent(GetStoneProductListEvent event, Emitter<StoneListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  /// Handler for changing the stone type
  Future<void> _onStoneChangeTypeEvent(StoneChangeTypeEvent event, Emitter<StoneListingState> emit) async {
    await stoneChangeType(event.context, event, emit);
  }

  /// Handler for changing the listing type
  Future<void> _onChangeListingTypeEvent(StoneChangeListingTypeEvent event, Emitter<StoneListingState> emit) async {
    _changeListingViewType(isGridValue: event.isGrid, emit: emit);
  }

  /// Handler for load more
  Future<void> _onStoneListLoadMoreEvent(StoneListLoadMoreEvent event, Emitter<StoneListingState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  /// Handler for pull to refresh
  Future<void> _onStoneListPullToRefresh(StoneListPullToRefreshEvent event, Emitter<StoneListingState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  /// Handler for adding a product to the watchlist
  Future<void> _onStoneListAddToWatchList(StoneListAddToWatchListEvent event, Emitter<StoneListingState> emit) async {
    await _addToWatchList(event.context, event.stoneId);
  }

  /// Handler for sorting
  Future<void> _onStoneSortEvent(StoneSortEvent event, Emitter<StoneListingState> emit) async {
    await _handleSortFunction(event, emit);
  }

  /// Handler for filtering
  Future<void> _onStoneListingFilterEvent(StoneListingFilterEvent event, Emitter<StoneListingState> emit) async {
    await _handleFilterFunction(event, emit);
  }

  ///Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<StoneListingState> emit) async {
    emit(StoneListLoadingState(isFirst: true));
    getRouteData(context);
    _initializePagination(context);
    await _initializeSortOptions(context);
    if (totalNumberOfPages == null || paginationScrollController.currentPage <= totalNumberOfPages!) {
      await _generateProductList(context, emit);
    }
    emit(const StoneProductReloadState());
    emit(const StoneProductLoadedState());
    _initWishlistUpdaterServiceBloc(context);
  }

  /// Get screen identifier
  void getRouteData(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDIY;
    productId = data?[RoutesData.productId] ?? "";
    productNavigation = data?[RoutesData.productNavigation] ?? AppConst.youMayLike;
    filterDataMap = data?[RoutesData.filterData];

    /// Here we set the appbar title
    _getStoneListName();
  }

  /// Initialize pagination
  _initializePagination(BuildContext context) {
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(StoneListLoadMoreEvent(context, currentPage));
      },
    );
  }

  Future<void> _generateProductList(BuildContext context, Emitter<StoneListingState> emit) async {
    /// Clear product list before fetching new data
    productList.clear();
    diamondDatumList.clear();
    gemstoneDatumList.clear();

    /// Determine screen-specific settings
    switch (screenIdentifier) {
      case ScreenIdentifier.diamondForDIY:
        await fetchDiamondList(context, emit);
        if (filterData.isEmpty) {
          await _setupFilters(context, ScreenIdentifier.diamondForDIY);
        }
        break;
      case ScreenIdentifier.productForGemstones:
        await fetchGemstoneList(context, emit);
        print("Gemstone Data: $filterData");
        if (filterData.isEmpty) {
          await _setupFilters(context, ScreenIdentifier.productForGemstones);
        }
        break;
      default:
        await fetchDiamondList(context, emit);
        if (filterData.isEmpty) {
          await _setupFilters(context, ScreenIdentifier.diamondForDefault);
        }
        break;
    }

    emit(const StoneProductReloadState());
    emit(const StoneProductLoadedState());
  }

  /// Setup titles
  void _setupTitles(String appbarTitleValue, String tabOne, String tabTwo) {
    appbarTitle = appbarTitleValue;
    tabOneTitle = tabOne;
    tabTwoTitle = tabTwo;
  }

  /// Fetch diamond list
  Future<void> fetchDiamondList(BuildContext context, Emitter<StoneListingState> emit,
      {bool isLoadMore = false, Map<String, String>? query}) async {
    final String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    Either<ErrorResponse, DiamondListingModel>? response;
    query ??= {};
    filterDataMap?.forEach((key, value) {
      if (value != null) {
        query![key] = value;
      }
    });
    if (StorageManager.instance.getIsSkipLogin()) {
      String? bagId = StorageManager.instance.getBagId();
      if (bagId.isNotNullNorEmpty) {
        query[ApiKey.quote] = bagId!;
      }
    }
    filterData
        .where((element) =>
            (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) ||
            (element.filterType == FilterType.range && element.rangeValues != null))
        .forEach(
      (element) {
        if (element.filterType == FilterType.range) {
          query!['${element.code}[min]'] = element.rangeValues?.start.toString() ?? '';
          query['${element.code}[max]'] = element.rangeValues?.end.toString() ?? '';
        } else if (element.filterType == FilterType.boolean &&
            (element.secondaryFilterData ?? []).isNotEmpty &&
            element.secondaryFilterData!.any((e) => e.isSelected)) {
          query![element.code ?? ''] = 'YES';
        } else {
          query![element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
        }
      },
    );

    if (productNavigation == AppConst.youMayLike) {
      response = await AppRepository(context).getDiamondYouMayLike(
        productId,
        page: paginationScrollController.currentPage.toString(),
        isShowLoader: isLoadMore,
        limit: AppConst.pageLimit.toString(),
      );
    } else if (productNavigation == AppConst.recentlyViewed) {
      response = await AppRepository(context).getDiamondRecentlyViewedProductList(
        limit: AppConst.pageLimit.toString(),
        isLoadMore: isLoadMore,
        page: paginationScrollController.currentPage.toString(),
      );
    } else if (productNavigation == AppConst.diamondsDealsOfTheDayParam) {
      Map<String, String> queryParam = {
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.stone: AppConst.diamondsDealsOfTheDayParam
      };
      queryParam.addAll(query);
      response = await AppRepository(context).getDiamondDealOfTheDayProductList(query: queryParam, isLoadMore: isLoadMore);
    } else if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      response = await AppRepository(context).diyFilters(
        page: paginationScrollController.currentPage.toString(),
        isLoadMore: isLoadMore,
        limit: AppConst.pageLimit.toString(),
        query: query,
      );
    } else {
      response = await AppRepository(context).fetchDiamondList(
        page: paginationScrollController.currentPage.toString(),
        isLoadMore: isLoadMore,
        limit: AppConst.pageLimit.toString(),
        type: type,
        sortKey: sortKey,
        sortValue: sortValue,
        query: query,
      );
    }

    _handleDiamondListResponse(emit: emit, response: response);
  }

  /// Handle diamond list response
  void _handleDiamondListResponse(
      {required Either<ErrorResponse, DiamondListingModel>? response, required Emitter<StoneListingState> emit}) {
    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final diamondList = success.data;

      /// Show the total number of records in the UI side
      totalFilteredRecords = success.filteredRecords;
      diamondDatumList.addAll(diamondList);
      productList.addAll(
        diamondList.map((diamond) => _convertDiamondDataModelToProductDetailsModel(diamond: diamond)).toList(),
      );

      /// Here sometime the pagination is not completed and called multiple times so we have managed it
      if (paginationScrollController.isPageLoaded.isCompleted) {
        paginationScrollController.isPageLoaded = Completer<bool>();
      }
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const StoneDiamondListLoadedState());
    });
  }

  /// Fetch gemstone list
  Future<void> fetchGemstoneList(BuildContext context, Emitter<StoneListingState> emit,
      {bool isLoadMore = false, Map<String, String>? query}) async {
    final String type = isInitialToggle ? AppConst.precious : AppConst.semiPrecious;
    Either<ErrorResponse, GemstoneListingModel>? response;
    query ??= {};
    filterData
        .where((element) =>
            (element.secondaryFilterData?.any((e) => e.isSelected == true) ?? false) ||
            (element.filterType == FilterType.range && element.rangeValues != null))
        .forEach(
      (element) {
        if (element.filterType == FilterType.range) {
          query!['${element.code}[min]'] = element.rangeValues?.start.toString() ?? '';
          query['${element.code}[max]'] = element.rangeValues?.end.toString() ?? '';
        } else if (element.filterType == FilterType.boolean &&
            (element.secondaryFilterData ?? []).isNotEmpty &&
            element.secondaryFilterData!.any((e) => e.isSelected)) {
          query![element.code ?? ''] = 'YES';
        } else {
          query![element.code ?? ''] = element.secondaryFilterData?.where((e) => e.isSelected == true).map((e) => e.code).join(',') ?? '';
        }
      },
    );

    if (productId.isNotEmpty && productNavigation.isNotEmpty) {
      if (productNavigation == AppConst.youMayLike) {
        response = await AppRepository(context).getGemstoneYouMayLike(
          productId,
          page: paginationScrollController.currentPage.toString(),
          isLoadMore: isLoadMore,
          limit: AppConst.pageLimit.toString(),
        );
      } else if (productNavigation == AppConst.recentlyViewed) {
        response = await AppRepository(context).getGemstoneRecentlyViewedProductList(
          limit: AppConst.pageLimit.toString(),
          isLoadMore: isLoadMore,
          page: paginationScrollController.currentPage.toString(),
        );
      }
    } else if (productNavigation == AppConst.gemstoneDealsOfTheDayParam) {
      Map<String, String> queryParam = {
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.stone: AppConst.gemstoneDealsOfTheDayParam
      };
      queryParam.addAll(query);
      response = await AppRepository(context).getGemstoneDealOfTheDayProductList(query: queryParam, isLoadMore: isLoadMore);
    } else {
      response = await AppRepository(context).fetchGemstoneList(
        page: paginationScrollController.currentPage.toString(),
        isLoadMore: isLoadMore,
        limit: AppConst.pageLimit.toString(),
        type: type,
        sortKey: sortKey,
        sortValue: sortValue,
        query: query,
      );
    }

    _handleGemstoneListResponse(emit: emit, response: response);
  }

  /// Handle gemstone list response
  void _handleGemstoneListResponse(
      {required Either<ErrorResponse, GemstoneListingModel>? response, required Emitter<StoneListingState> emit}) {
    response?.fold((error) {
      Utils.showMessage(error.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.filteredRecords, AppConst.pageLimit);
      final gemstoneList = success.data;

      /// Show the total number of records in the UI side
      totalFilteredRecords = success.filteredRecords;
      gemstoneDatumList.addAll(gemstoneList);
      productList.addAll(
        gemstoneList.map((gemstone) => _convertGemstoneDatumToProductDetailsModel(gemstone: gemstone)).toList(),
      );
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const StoneDiamondListLoadedState());
    });
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  ProductDetailsModel _convertDiamondDataModelToProductDetailsModel({required DiamondDataModel diamond}) {
    return ProductDetailsModel(
      suid: diamond.suid,
      productId: diamond.id,
      imageUrl: diamond.image.isNotNullNorEmpty ? diamond.image.first.url : null,
      name: diamond.rmDescription ?? "",
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      originalPrice: diamond.finalPrice?.toString().setCurrency,
      offerPrice: diamond.finalPrice?.toString().setCurrency,
      finalPrice: diamond.discountPrice?.toString().setCurrency,
      lotCode: diamond.lotCode,
      productSku: diamond.lotCode,
      shape: diamond.shape,
      fluorescence: diamond.fluorescence,
      labs: diamond.labs,
      lsp: diamond.lsp,
      color: diamond.color,
      clarity: diamond.clarity,
      cut: diamond.cut,
      certificateFile: diamond.certificateFile,
      openDnaUrl: diamond.openDnaUrl,
      commodity: Commodity.diamond,
      company: diamond.id,
      isFavourite: diamond.isFavorite,
      wishlistId: diamond.wishlistID,
      title: diamond.lotCode ?? "",
      subTitle: diamond.rmDescription ?? "",
      isForAuction: diamond.isAuction,
      isAddedToCart: diamond.isAddedToCart,
    );
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  ProductDetailsModel _convertGemstoneDatumToProductDetailsModel({required GemstoneDatum gemstone}) {
    return ProductDetailsModel(
      suid: gemstone.suid,
      productId: gemstone.id,
      imageUrl: gemstone.image.isNotNullNorEmpty ? gemstone.image.first.url : null,
      name: gemstone.rmDescription ?? "",
      ctsOrGms: gemstone.ctsOrGms,
      rappaportPrice: gemstone.rappaportPrice,
      priceCts: gemstone.priceCts,
      originalPrice: gemstone.finalPrice?.toString().setCurrency,
      offerPrice: gemstone.finalPrice?.toString().setCurrency,
      finalPrice: gemstone.discountPrice?.toString().setCurrency,
      lotCode: gemstone.lotCode,
      shape: gemstone.shape,
      fluorescence: gemstone.fluorescence,
      labs: gemstone.labs,
      lsp: gemstone.lsp?.toString(),
      color: gemstone.color,
      clarity: gemstone.clarity,
      cut: gemstone.cut,
      certificateFile: gemstone.certificateFile,
      openDnaUrl: gemstone.openDnaUrl,
      commodity: Commodity.gemstone,
      isFavourite: gemstone.isFavorite,
      wishlistId: gemstone.wishlistID,
      isForAuction: false,
      title: gemstone.lotCode ?? "",
      subTitle: gemstone.rmDescription ?? "",
      isAddedToCart: gemstone.isAddedToCart,
    );
  }

  /// Stone Change Type
  Future<void> stoneChangeType(BuildContext context, StoneChangeTypeEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    isInitialToggle = event.isInitialToggle;
    emit(StoneChangeTypeState(isInitialToggle));
    emit(StoneListLoadingState());
    paginationScrollController.pullToRefresh();
    filterData.clear();
    await _setupFilters(context, screenIdentifier);
    await _generateProductList(event.context, emit);
    emit(const StoneProductLoadedState());
  }

  /// Change listing view type
  void _changeListingViewType({required bool isGridValue, required Emitter<StoneListingState> emit}) {
    emit(StoneProductReloadState());
    isGrid = isGridValue;
    emit(StoneChangeListingTypeState());
  }

  /// Handle load more
  Future<void> _handleLoadMore(BuildContext context, Emitter<StoneListingState> emit, int currentPage) async {
    if (currentPage <= totalNumberOfPages!) {
      emit(StoneListLoadingMoreState());
      if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
        await fetchDiamondList(context, emit, isLoadMore: false);
      } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
        await fetchGemstoneList(context, emit, isLoadMore: false);
      } else {
        await fetchDiamondList(context, emit, isLoadMore: false);
      }
      emit(StoneListLoadedMoreState(currentPage));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<StoneListingState> emit) async {
    emit(StoneListLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    diamondDatumList.clear();
    productList.clear();
    diamondDatumList.clear();
    await _generateProductList(context, emit);
    emit(const StoneProductReloadState());
    emit(const StoneProductLoadedState());
  }

  /// Add to watchlist
  Future<void> _addToWatchList(BuildContext context, String stoneId) async {
    ProductDetailsModel? productDetails = productList.firstWhereOrNull((element) => element.productId == stoneId);
    if (productDetails != null) {
      BlocProvider.of<AddToWatchlistBloc>(context).add(AddToWatchlistInitialEvent.add(productDetails, context));
      Utils.showSmartModalBottomSheet(
        context: context,
        enableDrag: false,
        useRootNavigator: true,
        builder: (context) => const AddWatchlistScreen(),
      );
    }
  }

  /// Sort event for diamond listing
  Future<void> _handleSortFunction(StoneSortEvent event, Emitter<StoneListingState> emit) async {
    sortKey = event.sortData.sortKey ?? "";
    sortValue = event.sortData.sortValue ?? "";
    await _handlePullToRefresh(event.context, emit);
  }

  /// For Setup Filters
  Future<void> _setupFilters(BuildContext context, ScreenIdentifier screenIdentifier) async {
    String filterKey = "";
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      filterKey = AppConst.diamondForDIYFilter;
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      filterKey = AppConst.diamondFilter;
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      filterKey = AppConst.gemstoneFilter;
    }
    if (filterKey.isEmpty) {
      return;
    }
    final String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    final tempFilterData = await BlocProvider.of<AppBloc>(context).getFilterOptionList(context, filterKey, type: type);
    filterData.clear();
    for (FilterOptionModel filterOption in tempFilterData) {
      if (filterDataMap?.containsKey(filterOption.slug) == true) {
        continue;
      }
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
        } else if (filterOption.filterType == FilterType.boolean) {
          filter.secondaryFilterData = [SecondaryFilterData(name: filterOption.name)];
        }
        if (filter.filterType == FilterType.range && filterOption.data.isNotEmpty) {
          if (filterOption.data.isNotEmpty) {
            filter.minMaxValues = SfRangeValues(0, filterOption.data.lastOrNull?.toString().toDouble ?? 0);
          } else {
            continue;
          }
        }
        filterData.add(filter);
      }
    }
  }

  /// Initialize sort options
  Future<void> _initializeSortOptions(BuildContext context) async {
    List<SortOptions> sortOptionsList = await StorageManager()
        .getSortingList(screenIdentifier == ScreenIdentifier.diamondForDIY ? Commodity.diamond.value : Commodity.gemstone.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
      BlocProvider.of<SortFilterBloc>(context).add(InitialSortFilterEvent(sortOptions: sortOptions));
    }
  }

  /// Handle filter
  Future<void> _handleFilterFunction(StoneListingFilterEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneListLoadingState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    diamondDatumList.clear();
    filterData = event.filterData;
    await _generateProductList(event.context, emit);
    emit(const StoneProductReloadState());
    emit(const StoneProductLoadedState());
  }

  void _getStoneListName() {
    appbarTitle = APPStrings.diamonds.tr;
    if (productNavigation == AppConst.youMayLike && productId.isNotEmpty) {
      appbarTitle = APPStrings.youMayAlsoLike.tr;
      return;
    } else if (productNavigation == AppConst.recentlyViewed && productId.isNotEmpty) {
      appbarTitle = APPStrings.recentlyViewed.tr;
      return;
    }
    switch (screenIdentifier) {
      case ScreenIdentifier.diamondForDIY:
        _setupTitles(APPStrings.diy.tr, APPStrings.naturalDiamond.tr, APPStrings.looseDiamond.tr);
        break;
      case ScreenIdentifier.productForDiamonds:
      case ScreenIdentifier.diamondForDefault:
        _setupTitles(APPStrings.diamonds.tr, APPStrings.naturalDiamond.tr, APPStrings.looseDiamond.tr);
        break;
      case ScreenIdentifier.productForGemstones:
        _setupTitles(APPStrings.gemstone.tr, APPStrings.precious.tr, APPStrings.semiPrecious.tr);
        break;
      default:
        appbarTitle = APPStrings.diamonds.tr;
        break;
    }
  }

  /// Initialize the wishlist updater service
  void _initWishlistUpdaterServiceBloc(BuildContext context) {
    WishlistUpdaterServiceBloc wishlistUpdaterServiceBloc = BlocProvider.of<WishlistUpdaterServiceBloc>(context);
    wishlistUpdaterServiceStream = wishlistUpdaterServiceBloc.stream.listen((state) {
      if (state is WishListUpdateProductState) {
        try {
          if (screenIdentifier == ScreenIdentifier.diamondForDefault || screenIdentifier == ScreenIdentifier.diamondForDIY) {
            int index = diamondDatumList.indexWhere((element) => element.suid == state.productId);
            if (index != -1) {
              if (state.wishlistId.isNotEmpty) {
                diamondDatumList[index].isFavorite = true;
                diamondDatumList[index].wishlistID = state.wishlistId;
              } else {
                diamondDatumList[index].isFavorite = false;
                diamondDatumList[index].wishlistID = "";
              }
              productList[index].isFavourite = diamondDatumList[index].isFavorite;
              productList[index].wishlistId =
                  diamondDatumList[index].wishlistID.isNotNullNorEmpty ? diamondDatumList[index].wishlistID : null;
            }
          } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
            int index = gemstoneDatumList.indexWhere((element) => element.suid == state.productId);
            if (index != -1) {
              if (state.wishlistId.isNotEmpty) {
                gemstoneDatumList[index].isFavorite = true;
                gemstoneDatumList[index].wishlistID = state.wishlistId;
              } else {
                gemstoneDatumList[index].isFavorite = false;
                gemstoneDatumList[index].wishlistID = "";
              }
              productList[index].isFavourite = gemstoneDatumList[index].isFavorite;
              productList[index].wishlistId =
                  gemstoneDatumList[index].wishlistID.isNotNullNorEmpty ? gemstoneDatumList[index].wishlistID : null;
            }
          }
        } catch (e) {
          printWrapped(e.toString());
        }
      }
    });
  }
}
