import 'package:kgk/kgk.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetailsModel> productList = [];
  List<DiamondDataModel> diamondDatumList = [];
  List<GemstoneDatum> gemstoneDatumList = [];

  List<GemstoneFilterModel> gemstoneFilterList = [];

  int? totalNumberOfPages;
  static const int limit = 10;

  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;
  String productId = '';
  String productNavigation = '';

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
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(StoneListLoadMoreEvent(event.context, currentPage));
      },
    );
    getScreenIdentifier(event.context);
    await _generateProductList(event.context, emit);

    refreshCompleter.complete(true);

    emit(const StoneProductLoadedState());
  }

  Future<void> _generateProductList(BuildContext context, Emitter<StoneListingState> emit) async {
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
      stoneListingAppbarTitle = APPStrings.diy.tr;
      tabOneTitle = APPStrings.naturalDiamond.tr;
      tabTwoTitle = APPStrings.looseDiamond.tr;
      productList.clear();
      gemstoneFilterList = await AppBloc().getGemstoneFilterOptionList(context, 'diamond');
      await fetchDiamondList(context, emit, true);
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      stoneListingAppbarTitle = APPStrings.gemstone.tr;
      tabOneTitle = APPStrings.precious.tr;
      tabTwoTitle = APPStrings.semiPrecious.tr;
      productList.clear();
      gemstoneFilterList = await AppBloc().getGemstoneFilterOptionList(context, 'gemstone');
      await fetchGemstoneList(context, emit, true);
    } else {
      stoneListingAppbarTitle = APPStrings.diamonds.tr;
      tabOneTitle = APPStrings.naturalDiamond.tr;
      tabTwoTitle = APPStrings.looseDiamond.tr;
      productList.clear();
      gemstoneFilterList = await AppBloc().getGemstoneFilterOptionList(context, 'diamond');
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
            page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString());
      } else if (productNavigation == AppConst.recentlyViewed) {
        response = await AppRepository(context).getDiamondRecentlyViewedProductList(
            limit: limit.toString(), isLoadMore: isLoadMore ?? false, page: paginationScrollController.currentPage.toString());
      }
    } else {
      response = await AppRepository(context).fetchDiamondList(
          page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString(), type: type);
    }

    response?.fold((l) {
      Utils.showMessage(l.message ?? "");
    }, (r) {
      diamondDatumList = r.data;
      r.totalRecords ??= 0;
      totalNumberOfPages = Utils.calculateTotalPages(r.totalRecords, limit);
      List.generate(
        diamondDatumList.length,
        (index) {
          productList.add(
            ProductDetailsModel(
              productId: diamondDatumList[index].id,
              diamond: "2.5 crt",
              gram: "1.5 grms",
              imageUrl: diamondDatumList[index].image.first.url,
              name: diamondDatumList[index].rmDescription ?? "",
              originalPrice: (diamondDatumList[index].price ?? 0).toString().setCurrency,
              ctsOrGms: diamondDatumList[index].ctsOrGms,
              rappaportPrice: diamondDatumList[index].rappaportPrice,
              priceCts: diamondDatumList[index].priceCts,
              discountPrice: diamondDatumList[index].discountPrice?.setCurrency,
              finalPrice: diamondDatumList[index].finalPrice?.setCurrency,
              lotCode: diamondDatumList[index].lotCode,
              productSku: diamondDatumList[index].lotCode,
              shape: diamondDatumList[index].shape,
              fluorescence: diamondDatumList[index].fluorescence,
              labs: diamondDatumList[index].labs,
              lsp: diamondDatumList[index].lsp,
              color: diamondDatumList[index].color,
              clarity: diamondDatumList[index].clarity,
              cut: diamondDatumList[index].cut,
              certificateFile: diamondDatumList[index].certificateFile,
              openDnaUrl: diamondDatumList[index].openDnaUrl,
              commodity: Commodity.diamond,
              company: diamondDatumList[index].id,
              isFavourite: diamondDatumList[index].isFavorite,
              wishlistId: diamondDatumList[index].wishlistID,
            ),
          );
        },
      );
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const StoneDiamondListLoadedState());
    });
  }

  Future<void> fetchGemstoneList(BuildContext context, Emitter<StoneListingState> emit, bool? isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";
    String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    Either<ErrorResponse, GemstoneListingModel>? response;

    if (productId.isNotEmpty && productNavigation.isNotEmpty) {
      if (productNavigation == AppConst.youMayLike) {
        response = await AppRepository(context).getGemstoneYouMayLike(productId,
            page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString());
      } else if (productNavigation == AppConst.recentlyViewed) {
        response = await AppRepository(context).getGemstoneRecentlyViewedProductList(
            limit: limit.toString(), isLoadMore: isLoadMore ?? false, page: paginationScrollController.currentPage.toString());
      }
    } else {
      response = await AppRepository(context).fetchGemstoneList(
          page: paginationScrollController.currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString(), type: type);
    }
    response?.fold((l) {
      Utils.showMessage(l.message ?? "");
    }, (r) {
      gemstoneDatumList = r.data;
      r.totalRecords ??= 0;
      totalNumberOfPages = Utils.calculateTotalPages(r.totalRecords, limit);
      List.generate(
        gemstoneDatumList.length,
        (index) => productList.add(
          ProductDetailsModel(
            productId: gemstoneDatumList[index].id,
            diamond: "2.5 crt",
            gram: "1.5 grms",
            imageUrl: gemstoneDatumList[index].image.isNotNullNorEmpty ? gemstoneDatumList[index].image.first.url : null,
            name: gemstoneDatumList[index].rmDescription ?? "",
            originalPrice: (gemstoneDatumList[index].price ?? 0).toString().setCurrency,
            ctsOrGms: gemstoneDatumList[index].ctsOrGms,
            rappaportPrice: gemstoneDatumList[index].rappaportPrice,
            priceCts: gemstoneDatumList[index].priceCts,
            discountPrice: gemstoneDatumList[index].discountPrice?.setCurrency,
            finalPrice: gemstoneDatumList[index].finalPrice?.setCurrency,
            lotCode: gemstoneDatumList[index].lotCode,
            shape: gemstoneDatumList[index].shape,
            fluorescence: gemstoneDatumList[index].fluorescence,
            labs: gemstoneDatumList[index].labs,
            lsp: gemstoneDatumList[index].lsp,
            color: gemstoneDatumList[index].color,
            clarity: gemstoneDatumList[index].clarity,
            cut: gemstoneDatumList[index].cut,
            certificateFile: gemstoneDatumList[index].certificateFile,
            openDnaUrl: gemstoneDatumList[index].openDnaUrl,
            commodity: Commodity.gemstone,
            isFavourite: gemstoneDatumList[index].isFavorite,
            wishlistId: gemstoneDatumList[index].wishlistID,
            isForAuction: index % 2 == 0,
          ),
        ),
      );
      paginationScrollController.isPageLoaded.complete(paginationScrollController.currentPage == totalNumberOfPages);
      emit(const StoneDiamondListLoadedState());
    });
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
      await Future.delayed(const Duration(seconds: 2));
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
    await Future.delayed(const Duration(seconds: 3));
    paginationScrollController.pullToRefresh();
    await _generateProductList(event.context, emit);
    refreshCompleter.complete(true);
    emit(const StoneProductLoadedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(StoneListPullToRefreshEvent(context));
    bool result = await refreshCompleter.future;
    return result;
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
}
