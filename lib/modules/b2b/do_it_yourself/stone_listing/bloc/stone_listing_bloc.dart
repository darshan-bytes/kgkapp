import 'package:kgk/kgk.dart';

part 'stone_listing_event.dart';

part 'stone_listing_state.dart';

class StoneListingBloc extends Bloc<StoneListingEvent, StoneListingState> {
  bool isInitialToggle = true;
  bool isGrid = true;
  List<ProductDetails> productList = [];

  String tabOneTitle = APPStrings.naturalDiamond.tr;
  String tabTwoTitle = APPStrings.looseDiamond.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.diamondForDIY;

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

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    screenIdentifier = data?[RoutesData.isPageFor] ?? ScreenIdentifier.diamondForDIY;
  }

  Future<void> _onGetStoneProductListEvent(GetStoneProductListEvent event, Emitter<StoneListingState> emit) async {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(StoneListLoadMoreEvent(currentPage));
      },
    );
    getScreenIdentifier(event.context);
    _generateProductList();

    refreshCompleter.complete(true);

    emit(const StoneProductLoadedState());
  }

  void _generateProductList() {
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
      productList.clear();
      tabOneTitle = APPStrings.precious.tr;
      tabTwoTitle = APPStrings.semiPrecious.tr;
      List.generate(
        20,
        (index) => productList.add(
          ProductDetails(
            isOutOfStock: index % 2 == 0,
            diamond: "1.5 gram",
            gram: "1.5 gram",
            imageUrl: index % 2 == 0 ? "https://i.ibb.co/477f41r/Group-1410089379.png" : "https://i.ibb.co/sggT4PJ/Group-1410089378.png",
            name: "0.35 Carat Super Premium Oval Moissanite",
            originalPrice: "\$1,600 .00",
          ),
        ),
      );
    } else {
      stoneListingAppbarTitle = APPStrings.diamonds.tr;
      productList.clear();
      tabOneTitle = APPStrings.naturalDiamond.tr;
      tabTwoTitle = APPStrings.looseDiamond.tr;
      List.generate(
        20,
        (index) => productList.add(
          ProductDetails(
            isOutOfStock: index % 2 == 0,
            diamond: "2.5 crt",
            gram: "1.5 grms",
            imageUrl: "https://i.ibb.co/yBHp2KB/image-7.png",
            name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
            originalPrice: "\$3,000.00",
            isForAuction: index % 2 == 0,
          ),
        ),
      );
    }
  }

  void _onStoneChangeTypeEvent(StoneChangeTypeEvent event, Emitter<StoneListingState> emit) {
    emit(StoneProductReloadState());
    isInitialToggle = event.isInitialToggle;
    emit(StoneChangeTypeState(isInitialToggle));
  }

  void _onChangeListingTypeEvent(StoneChangeListingTypeEvent event, Emitter<StoneListingState> emit) {
    emit(StoneProductReloadState());
    isGrid = !isGrid;
    emit(StoneChangeListingTypeState());
  }

  Future<void> _onStoneListLoadMoreEvent(StoneListLoadMoreEvent event, Emitter<StoneListingState> emit) async {
    emit(StoneListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    if (screenIdentifier == ScreenIdentifier.diamondForDIY) {
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
      List.generate(
          10,
          (index) => productList.add(
                ProductDetails(
                  isOutOfStock: index % 2 == 0,
                  diamond: "1.5 gram",
                  gram: "1.5 gram",
                  imageUrl:
                      index % 2 == 0 ? "https://i.ibb.co/477f41r/Group-1410089379.png" : "https://i.ibb.co/sggT4PJ/Group-1410089378.png",
                  name: "0.35 Carat Super Premium Oval Moissanite",
                  originalPrice: "\$1,600 .00",
                ),
              ));
    } else {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetails(
                    isOutOfStock: index % 2 == 0,
                    diamond: "2.5 crt",
                    gram: "1.5 grms",
                    imageUrl: "https://i.ibb.co/yBHp2KB/image-7.png",
                    name: "2.00 Carat H VS1 Excellent Cut Round Diamond",
                    originalPrice: "\$3,000.00"),
              ));
    }
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(StoneListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onStoneListPullToRefresh(StoneListPullToRefreshEvent event, Emitter<StoneListingState> emit) async {
    await Future.delayed(const Duration(seconds: 3));
    paginationScrollController.pullToRefresh();
    _generateProductList();
    refreshCompleter.complete(true);
    emit(const StoneProductLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const StoneListPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
