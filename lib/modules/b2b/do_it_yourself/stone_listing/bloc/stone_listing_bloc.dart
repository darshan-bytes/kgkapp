import 'package:kgk/kgk.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetailsModel> productList = [];
  List<DiamondDataModel> diamondDatumList = [];
  List<GemstoneDatum> gemstoneDatumList = [];

  List<FilterOptionModel> filterList = [];

  int? totalNumberOfPages;

  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;
  String productId = '';
  String productNavigation = '';
  String sortKey = AppConst.sortKeySuid;
  String sortValue = AppConst.sortValueAsc;

  String stoneListingAppbarTitle = "";

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  StoneListingBloc() : super(const StoneListingInitial()) {
    on<GetStoneProductListEvent>(_onGetStoneProductListEvent);
    on<StoneChangeTypeEvent>(_onStoneChangeTypeEvent);
    on<StoneChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<StoneListLoadMoreEvent>(_onStoneListLoadMoreEvent);
    on<StoneListPullToRefreshEvent>(_onStoneListPullToRefresh);
    on<StoneListAddToWatchListEvent>(_onStoneListAddToWatchList);
    on<StoneSortEvent>(_onStoneSortEvent);
  }

  bool get displaySelection => productId.isEmpty;

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDIY;
    productId = data?[RoutesData.productId] ?? "";
    productNavigation = data?[RoutesData.productNavigation] ?? AppConst.youMayLike;
  }

  Future<void> _onGetStoneProductListEvent(GetStoneProductListEvent event, Emitter<StoneListingState> emit) async {
    getScreenIdentifier(event.context);
    paginationScrollController.init(
      isSecondaryView: true,
      loadAction: (int currentPage) async {
        add(StoneListLoadMoreEvent(event.context, currentPage));
      },
    );
    await _generateProductList(event.context, emit);

    refreshCompleter.complete(true);

    emit(const StoneProductLoadedState());
  }

  Future<void> _generateProductList(BuildContext context, Emitter<StoneListingState> emit) async {
    if (screenIdentifier == ScreenIdentifier.diamondForDIY || screenIdentifier == ScreenIdentifier.productForGemstones) {
      stoneListingAppbarTitle = screenIdentifier == ScreenIdentifier.diamondForDIY ? APPStrings.diy.tr : APPStrings.gemstone.tr;

      tabOneTitle = screenIdentifier == ScreenIdentifier.diamondForDIY ? APPStrings.naturalDiamond.tr : APPStrings.precious.tr;

      tabTwoTitle = screenIdentifier == ScreenIdentifier.diamondForDIY ? APPStrings.looseDiamond.tr : APPStrings.semiPrecious.tr;

      /// TODO :: THIS API IS COMMENTED TEMPORARY TO GET STATIC DATA OF FILTER OPTIONS
      // filterList = await BlocProvider.of<AppBloc>(context).getFilterOptionList(
      //     context, screenIdentifier == ScreenIdentifier.diamondForDIY ? AppConst.diamondFilter : AppConst.gemstoneFilter);

      filterList = List.generate(
          5,
          (index) => FilterOptionModel(
                name: index % 2 == 0 ? "Shape" : "Type",
                slug: index % 2 == 0 ? "shape" : "type",
                defaultValue: null,
                inputType: index % 2 == 0 ? "checkbox" : "slider",
                data: [],
                id: index,
              ));

      if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
        await fetchDiamondList(context, emit, true);
      } else {
        await fetchGemstoneList(context, emit, true);
      }
    } else {
      stoneListingAppbarTitle = APPStrings.diamonds.tr;
      tabOneTitle = APPStrings.naturalDiamond.tr;
      tabTwoTitle = APPStrings.looseDiamond.tr;

      /// TODO :: THIS API IS COMMENTED TEMPORARY TO GET STATIC DATA OF FILTER OPTIONS
      // filterList = await BlocProvider.of<AppBloc>(context).getGemstoneFilterOptionList(context, AppConst.diamondFilter);
      filterList = List.generate(
          10,
          (index) => FilterOptionModel(
                name: index % 2 == 0 ? "Shape" : "Type",
                slug: index % 2 == 0 ? "shape" : "type",
                defaultValue: null,
                inputType: index % 2 == 0 ? "checkbox" : "slider",
                data: [],
                id: index,
              ));

      await fetchDiamondList(context, emit, true);
    }
  }

  Future<void> fetchDiamondList(BuildContext context, Emitter<StoneListingState> emit, bool? isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";
    String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    Either<ErrorResponse, DiamondListingModel>? response;

    if (productId.isNotEmpty && productNavigation.isNotEmpty) {
      if (productNavigation == AppConst.youMayLike) {
        response = await AppRepository(context).getDiamondYouMayLike(productId,
            page: paginationScrollController.currentPage.toString(),
            isLoadMore: isLoadMore ?? false,
            limit: AppConst.pageLimit50.toString());
      } else if (productNavigation == AppConst.recentlyViewed) {
        response = await AppRepository(context).getDiamondRecentlyViewedProductList(
            limit: AppConst.pageLimit.toString(), isLoadMore: isLoadMore ?? false, page: paginationScrollController.currentPage.toString());
      }
    } else {
      response = await AppRepository(context).fetchDiamondList(
        page: paginationScrollController.currentPage.toString(),
        isLoadMore: isLoadMore ?? false,
        limit: AppConst.pageLimit50.toString(),
        type: type,
        sortValue: sortValue,
        sortKey: sortKey,
      );
    }

    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.totalRecords, AppConst.pageLimit50);
      final localList = success.data;
      productList.addAll(localList.map((e) => _convertDiamondDataModelToProductDetailsModel(diamond: e)).toList());
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const StoneDiamondListLoadedState());
    });
  }

  Future<void> fetchGemstoneList(BuildContext context, Emitter<StoneListingState> emit, bool? isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";
    String type = isInitialToggle ? AppConst.precious : AppConst.semiPrecious;
    Either<ErrorResponse, GemstoneListingModel>? response;

    if (productId.isNotEmpty && productNavigation.isNotEmpty) {
      if (productNavigation == AppConst.youMayLike) {
        context.setAppLoading(true);
        response = await AppRepository(context).getGemstoneYouMayLike(productId,
            page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: AppConst.pageLimit.toString());
        context.setAppLoading(false);
      } else if (productNavigation == AppConst.recentlyViewed) {
        response = await AppRepository(context).getGemstoneRecentlyViewedProductList(
            limit: AppConst.pageLimit.toString(), isLoadMore: isLoadMore ?? false, page: paginationScrollController.currentPage.toString());
      }
    } else {
      response = await AppRepository(context).fetchGemstoneList(
        page: paginationScrollController.currentPage.toString(),
        isLoadMore: isLoadMore ?? false,
        limit: AppConst.pageLimit50.toString(),
        type: type,
        sortKey: sortKey,
        sortValue: sortValue,
      );
    }
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (success) {
      totalNumberOfPages = Utils.calculateTotalPages(success.totalRecords, AppConst.pageLimit50);
      final localList = success.data;
      productList.addAll(localList.map((e) => _convertGemstoneDatumToProductDetailsModel(gemstone: e)).toList());
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
      imageUrl: diamond.image.first.url,
      name: diamond.rmDescription ?? "",
      originalPrice: (diamond.finalPrice ?? 0).toString().setCurrency,
      ctsOrGms: diamond.ctsOrGms,
      rappaportPrice: diamond.rappaportPrice,
      priceCts: diamond.priceCts,
      discountPrice: diamond.discountPrice?.setCurrency,
      finalPrice: diamond.discountPrice?.setCurrency,
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
    );
  }

  /// Helper Function: Convert Gemstone Data to ProductDetailsModel
  ProductDetailsModel _convertGemstoneDatumToProductDetailsModel({required GemstoneDatum gemstone}) {
    return ProductDetailsModel(
      title: gemstone.rmDescription ?? "",
      productId: gemstone.id,
      diamond: "2.5 crt",
      gram: "1.5 grms",
      imageUrl: gemstone.image.isNotNullNorEmpty ? gemstone.image.first.url : null,
      name: gemstone.rmDescription ?? "",
      originalPrice: (gemstone.finalPrice ?? 0).toString().setCurrency,
      ctsOrGms: gemstone.ctsOrGms,
      rappaportPrice: gemstone.rappaportPrice,
      priceCts: gemstone.priceCts,
      discountPrice: (gemstone.discountPrice ?? 0).toString().setCurrency,
      finalPrice: gemstone.discountPrice?.setCurrency,
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
    );
  }

  Future<void> _onStoneChangeTypeEvent(StoneChangeTypeEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    isInitialToggle = event.isInitialToggle;
    paginationScrollController.pullToRefresh();
    await _generateProductList(event.context, emit);
    emit(StoneChangeTypeState(isInitialToggle));
  }

  void _onChangeListingTypeEvent(StoneChangeListingTypeEvent event, Emitter<StoneListingState> emit) {
    emit(StoneProductReloadState());
    isGrid = !isGrid;
    emit(StoneChangeListingTypeState());
  }

  Future<void> _onStoneListLoadMoreEvent(StoneListLoadMoreEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneListLoadingMoreState());
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetailsModel(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
                  originalPrice: "\$3,000.00",
                  discountPercentage: "Save UP TO 10%",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      await fetchGemstoneList(event.context, emit, false);
    } else {
      await fetchDiamondList(event.context, emit, false);
    }
    emit(StoneListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onStoneListPullToRefresh(StoneListPullToRefreshEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    paginationScrollController.pullToRefresh();
    productList.clear();
    await _generateProductList(event.context, emit);
    refreshCompleter.complete(true);
    emit(const StoneProductLoadedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    refreshCompleter = Completer<bool>();
    add(StoneListPullToRefreshEvent(context));
    return refreshCompleter.future;
  }

  Future<void> _onStoneListAddToWatchList(StoneListAddToWatchListEvent event, Emitter<StoneListingState> emit) async {
    ProductDetailsModel? productDetails = productList.firstWhereOrNull((element) => element.productId == event.stoneId);
    if (productDetails != null) {
      BlocProvider.of<AddToWatchlistBloc>(event.context).add(AddToWatchlistInitialEvent.add(productDetails, event.context));
      Utils.showSmartModalBottomSheet(
        context: event.context,
        enableDrag: false,
        useRootNavigator: true,
        builder: (context) => const AddWatchlistScreen(),
      );
    }
  }

  /// Sort event for stone listing
  Future<void> _onStoneSortEvent(StoneSortEvent event, Emitter<StoneListingState> emit) async {
    sortKey = event.sortData.sortKey ?? "";
    sortValue = event.sortData.sortValue ?? "";
    pullToRefresh(event.context);
  }
}
