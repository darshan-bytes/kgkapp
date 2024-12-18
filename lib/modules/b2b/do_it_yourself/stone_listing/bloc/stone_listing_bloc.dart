import 'package:kgk/kgk.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  /// grid/list view for product listing
  bool isInitialToggle = true;
  bool isGrid = true;

  /// appbar title
  String stoneListingAppbarTitle = "";
  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;

  /// Store product list
  List<ProductDetailsModel> productList = [];
  List<DiamondDataModel> diamondDatumList = [];
  List<GemstoneDatum> gemstoneDatumList = [];

  /// Store filter and sort data
  List<FilterData> filterData = [];
  List<SortOptions> sortOptions = [];

  int? totalNumberOfPages;
  String productId = '';
  String productNavigation = '';
  String sortKey = AppConst.sortKeyUpdatedDateTime;
  String sortValue = AppConst.sortValueDesc;

  /// Tab title
  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  /// Pagination controller
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

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
    return super.close();
  }

  /// Event handlers
  Future<void> _onGetStoneProductListEvent(GetStoneProductListEvent event, Emitter<StoneListingState> emit) async {
    await _initializeBloc(event.context, emit);
  }

  Future<void> _onStoneChangeTypeEvent(StoneChangeTypeEvent event, Emitter<StoneListingState> emit) async {
    await stoneChangeType(event.context, event, emit);
  }

  Future<void> _onChangeListingTypeEvent(StoneChangeListingTypeEvent event, Emitter<StoneListingState> emit) async {
    _changeListingViewType(emit);
  }

  Future<void> _onStoneListLoadMoreEvent(StoneListLoadMoreEvent event, Emitter<StoneListingState> emit) async {
    await _handleLoadMore(event.context, emit, event.currentPage);
  }

  Future<void> _onStoneListPullToRefresh(StoneListPullToRefreshEvent event, Emitter<StoneListingState> emit) async {
    await _handlePullToRefresh(event.context, emit);
  }

  Future<void> _onStoneListAddToWatchList(StoneListAddToWatchListEvent event, Emitter<StoneListingState> emit) async {
    await _addToWatchList(event.context, event.stoneId);
  }

  Future<void> _onStoneSortEvent(StoneSortEvent event, Emitter<StoneListingState> emit) async {
    await _handleSortFunction(event, emit);
  }

  Future<void> _onStoneListingFilterEvent(StoneListingFilterEvent event, Emitter<StoneListingState> emit) async {
    await _handleFilterFunction(event, emit);
  }

  ///Initialization Logic
  Future<void> _initializeBloc(BuildContext context, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    getScreenIdentifier(context);
    await _initializeSortOptions();
    _initializePagination(context);
    await _generateProductList(context, emit);
    emit(const StoneProductLoadedState());
  }

  /// Get screen identifier
  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDIY;
    productId = data?[RoutesData.productId] ?? "";
    productNavigation = data?[RoutesData.productNavigation] ?? AppConst.youMayLike;
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

    /// Determine screen-specific settings
    switch (screenIdentifier) {
      case ScreenIdentifier.diamondForDIY:
        _setupTitles(APPStrings.diy.tr, APPStrings.naturalDiamond.tr, APPStrings.looseDiamond.tr);
        await fetchDiamondList(context, emit, isLoadMore: true);
        if (filterData.isEmpty) {
          await _setupFilters(context, ScreenIdentifier.diamondForDIY);
        }
        break;
      case ScreenIdentifier.productForGemstones:
        _setupTitles(APPStrings.gemstone.tr, APPStrings.precious.tr, APPStrings.semiPrecious.tr);
        await fetchGemstoneList(context, emit, isLoadMore: true);
        if (filterData.isEmpty) {
          await _setupFilters(context, ScreenIdentifier.productForGemstones);
        }
        break;
      default:
        _setupTitles(APPStrings.diamonds.tr, APPStrings.naturalDiamond.tr, APPStrings.looseDiamond.tr);
        await fetchDiamondList(context, emit, isLoadMore: true);
        if (filterData.isEmpty) {
          await _setupFilters(context, ScreenIdentifier.diamondForDIY);
        }
        break;
    }

    emit(const StoneProductLoadedState());
  }

  /// Setup titles
  void _setupTitles(String appbarTitle, String tabOne, String tabTwo) {
    stoneListingAppbarTitle = appbarTitle;
    tabOneTitle = tabOne;
    tabTwoTitle = tabTwo;
  }

  /// Fetch diamond list
  Future<void> fetchDiamondList(BuildContext context, Emitter<StoneListingState> emit,
      {required bool isLoadMore, Map<String, String>? query}) async {
    final String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    Either<ErrorResponse, DiamondListingModel>? response;
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

    if (productId.isNotEmpty && productNavigation.isNotEmpty) {
      if (productNavigation == AppConst.youMayLike) {
        response = await AppRepository(context).getDiamondYouMayLike(
          productId,
          page: paginationScrollController.currentPage.toString(),
          isLoadMore: isLoadMore,
          limit: AppConst.pageLimit.toString(),
        );
      } else if (productNavigation == AppConst.recentlyViewed) {
        response = await AppRepository(context).getDiamondRecentlyViewedProductList(
          limit: AppConst.pageLimit.toString(),
          isLoadMore: isLoadMore,
          page: paginationScrollController.currentPage.toString(),
        );
      }
    } else if (productNavigation == AppConst.diamondsDealsOfTheDayParam) {
      Map<String, String> queryParam = {
        ApiKey.page: paginationScrollController.currentPage.toString(),
        ApiKey.limit: AppConst.pageLimit.toString(),
        ApiKey.stone: AppConst.diamondsDealsOfTheDayParam
      };
      queryParam.addAll(query);
      response = await AppRepository(context).getDiamondDealOfTheDayProductList(query: queryParam, isLoadMore: isLoadMore);
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
      productList.addAll(
        diamondList.map((diamond) => _convertDiamondDataModelToProductDetailsModel(diamond: diamond)).toList(),
      );
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const StoneDiamondListLoadedState());
    });
  }

  /// Fetch gemstone list
  Future<void> fetchGemstoneList(BuildContext context, Emitter<StoneListingState> emit,
      {required bool isLoadMore, Map<String, String>? query}) async {
    final String type = isInitialToggle ? AppConst.precious : AppConst.semiPrecious;
    Either<ErrorResponse, GemstoneListingModel>? response;
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
      productId: diamond.id,
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: diamond.image.isNotNullNorEmpty ? diamond.image.first.url : null,
      name: diamond.rmDescription ?? "",
      originalPrice: (diamond.discountPrice ?? 0).toString().setCurrency,
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      discountPrice: diamond.finalPrice?.setCurrency,
      finalPrice: (diamond.finalPrice ?? 0).toString().setCurrency,
      offerPrice: diamond.discountPrice?.setCurrency,
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
    );
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  ProductDetailsModel _convertGemstoneDatumToProductDetailsModel({required GemstoneDatum gemstone}) {
    return ProductDetailsModel(
      productId: gemstone.id,
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: gemstone.image.isNotNullNorEmpty ? gemstone.image.first.url : null,
      name: gemstone.rmDescription ?? "",
      originalPrice: (gemstone.discountPrice ?? 0).toString().setCurrency,
      ctsOrGms: gemstone.ctsOrGms,
      rappaportPrice: gemstone.rappaportPrice,
      priceCts: gemstone.priceCts,
      discountPrice: (gemstone.discountPrice ?? 0).toString().setCurrency,
      finalPrice: gemstone.finalPrice?.setCurrency,
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
    );
  }

  /// Stone Change Type
  Future<void> stoneChangeType(BuildContext context, StoneChangeTypeEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    isInitialToggle = event.isInitialToggle;
    paginationScrollController.pullToRefresh();
    await _generateProductList(event.context, emit);
    emit(StoneChangeTypeState(isInitialToggle));
  }

  /// Change listing view type
  void _changeListingViewType(Emitter<StoneListingState> emit) {
    emit(StoneProductReloadState());
    isGrid = !isGrid;
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
      emit(StoneListLoadedMoreState(currentPage + 1));
    }
  }

  /// Handle pull to refresh
  Future<void> _handlePullToRefresh(BuildContext context, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    productList.clear();
    await _generateProductList(context, emit);
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
      filterKey = AppConst.diamondFilter;
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      filterKey = AppConst.gemstoneFilter;
    }
    final tempFilterData = await BlocProvider.of<AppBloc>(context).getFilterOptionList(context, filterKey);
    filterData.clear();
    for (FilterOptionModel filterOption in tempFilterData) {
      if (filterOption.data.isNotEmpty) {
        FilterData filter = FilterData(
          name: filterOption.name,
          code: filterOption.slug,
          inputType: filterOption.inputType,
          filterType: filterOption.filterType,
          subFilterCodes: filterOption.data.map((e) => e.toString()).join(','),
          secondaryFilterData: [],
        );
        if (filter.filterType == FilterType.range && filterOption.data.isNotEmpty) {
          filter.rangeValues = SfRangeValues(0, filterOption.data.first.toDouble());
          filter.minMaxValues = SfRangeValues(0, filterOption.data.last.toDouble());
        }
        filterData.add(filter);
      }
    }
  }

  /// Initialize sort options
  Future<void> _initializeSortOptions() async {
    List<SortOptions> sortOptionsList = await StorageManager()
        .getSortingList(screenIdentifier == ScreenIdentifier.diamondForDIY ? Commodity.diamond.value : Commodity.gemstone.value);
    if (sortOptionsList.isNotNullNorEmpty) {
      sortOptions = sortOptionsList;
      SortOptions defaultSortOption = sortOptionsList.firstWhereOrNull((element) => element.isDefault == true) ?? sortOptionsList.first;
      sortKey = defaultSortOption.sortKey ?? "";
      sortValue = defaultSortOption.sortValue ?? "";
    }
  }

  /// Handle filter
  Future<void> _handleFilterFunction(StoneListingFilterEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    filterData = event.filterData;
    await _generateProductList(event.context, emit);
    emit(const StoneProductLoadedState());
  }
}
