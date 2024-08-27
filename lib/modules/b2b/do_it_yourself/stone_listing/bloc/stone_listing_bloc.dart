import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/do_it_yourself/stone_listing/model/gemstone_listing_model.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];
  List<DiamondDataModel> diamondDatumList = [];
  List<GemstoneDatum> gemstoneDatumList = [];

  int currentPage = 1;
  int? totalNumberOfPages;
  int limit = 10;

  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;
  String productId = "";

  String stoneListingAppbarTitle = "DIY";

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  Completer<bool> refreshCompleter = Completer<bool>();

  StoneListingBloc() : super(const StoneListingInitial()) {
    on<GetStoneProductListEvent>(_onGetStoneProductListEvent);
    on<StoneChangeTypeEvent>(_onStoneChangeTypeEvent);
    on<StoneChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<StoneListLoadMoreEvent>(_onStoneListLoadMoreEvent);
    on<StoneListPullToRefreshEvent>(_onStoneListPullToRefresh);
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
      productList.clear();
      List.generate(
        20,
        (index) => productList.add(
          ProductDetails(
            isOutOfStock: index % 2 == 0,
            diamond: "2.5 crt",
            gram: "1.5 grms",
            imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
            name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
            originalPrice: "\$3,000.00",
            discountPercentage: "Save UP TO 10%",
          ),
        ),
      );
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      stoneListingAppbarTitle = APPStrings.gemstone.tr;
      tabOneTitle = APPStrings.precious.tr;
      tabTwoTitle = APPStrings.semiPrecious.tr;
      productList.clear();
      await fetchGemstoneList(context, emit, true);
    } else {
      stoneListingAppbarTitle = APPStrings.diamonds.tr;
      tabOneTitle = APPStrings.naturalDiamond.tr;
      tabTwoTitle = APPStrings.looseDiamond.tr;
      productList.clear();
      await fetchDiamondList(context, emit, true);
    }
  }

  Future<void> fetchDiamondList(BuildContext context, Emitter<StoneListingState> emit, bool? isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";
    String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    Either<ErrorResponse, DiamondListingModel>? response;
    if (productId.isNotEmpty) {
      response = await AppRepository(context)
          .getDiamondYouMayLike(productId, page: currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString());
    } else {
      response = await AppRepository(context)
          .fetchDiamondList(page: currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString(), type: type);
    }

    response?.fold((l) {
      Utils.showMessage(l.message ?? "");
    }, (r) {
      diamondDatumList = r.data;
      totalNumberOfPages = (r.totalRecords ?? 0) ~/ limit;
      List.generate(
        diamondDatumList.length,
        (index) => productList.add(
          ProductDetails(
            productId: diamondDatumList[index].id,
            isOutOfStock: index % 2 == 0,
            diamond: "2.5 crt",
            gram: "1.5 grms",
            imageUrl: diamondDatumList[index].image.first.url,
            //"https://i.ibb.co/yBHp2KB/image-7.png",
            name: diamondDatumList[index].rmDescription ?? "",
            originalPrice: "$currency${diamondDatumList[index].price}",
            //"\$3,000.00",
            ctsOrGms: diamondDatumList[index].ctsOrGms,
            rappaportPrice: diamondDatumList[index].rappaportPrice,
            priceCts: diamondDatumList[index].priceCts,
            discountPrice: diamondDatumList[index].discountPrice,
            finalPrice: diamondDatumList[index].finalPrice,
            lotCode: diamondDatumList[index].lotCode,
            shape: diamondDatumList[index].shape,
            fluorescence: diamondDatumList[index].fluorescence,
            labs: diamondDatumList[index].labs,
            lsp: diamondDatumList[index].lsp,
            color: diamondDatumList[index].color,
            clarity: diamondDatumList[index].clarity,
            cut: diamondDatumList[index].cut,
            certificateFile: diamondDatumList[index].certificateFile,
            openDnaUrl: diamondDatumList[index].openDnaUrl,
          ),
        ),
      );

      emit(const StoneDiamondListLoadedState());
    });
  }

  Future<void> fetchGemstoneList(BuildContext context, Emitter<StoneListingState> emit, bool? isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";
    String type = isInitialToggle ? AppConst.diamondSinglestone : AppConst.diamondNormal;
    await AppRepository(context)
        .fetchGemstoneList(page: currentPage.toString(), isLoadMore: isLoadMore ?? false, limit: limit.toString(), type: '')
        .then((value) async {
      value?.fold((l) {
        Utils.showMessage(l.message ?? "");
      }, (r) {
        gemstoneDatumList = r.data;
        totalNumberOfPages = (r.totalRecords ?? 0) ~/ limit;
        List.generate(
          gemstoneDatumList.length,
          (index) => productList.add(
            ProductDetails(
              productId: gemstoneDatumList[index].id,
              isOutOfStock: index % 2 == 0,
              diamond: "2.5 crt",
              gram: "1.5 grms",
              imageUrl: gemstoneDatumList[index].image.first.url,
              //"https://i.ibb.co/yBHp2KB/image-7.png",
              name: gemstoneDatumList[index].rmDescription ?? "",
              originalPrice: "$currency${gemstoneDatumList[index].price}",
              //"\$3,000.00",
              ctsOrGms: gemstoneDatumList[index].ctsOrGms,
              rappaportPrice: gemstoneDatumList[index].rappaportPrice,
              priceCts: gemstoneDatumList[index].priceCts,
              discountPrice: gemstoneDatumList[index].discountPrice,
              finalPrice: gemstoneDatumList[index].finalPrice,
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
            ),
          ),
        );

        emit(const StoneDiamondListLoadedState());
      });
    });
  }

  Future<void> _onStoneChangeTypeEvent(StoneChangeTypeEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneProductReloadState());
    isInitialToggle = event.isInitialToggle;
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
                ProductDetails(
                  isOutOfStock: index % 2 == 0,
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
                  originalPrice: "\$3,000.00",
                  discountPercentage: "Save UP TO 10%",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForGemstones) {
      currentPage++;
      await fetchGemstoneList(event.context, emit, false);
    } else {
      currentPage++;
      await fetchDiamondList(event.context, emit, false);
    }
    paginationScrollController.isPageLoaded.complete(event.currentPage == totalNumberOfPages);
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
}
