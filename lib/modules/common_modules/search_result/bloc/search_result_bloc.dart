import 'package:kgk/kgk.dart';

part 'search_result_event.dart';

part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  bool isGrid = true;
  List<ProductDetailsModel> productList = [];
  List<ProductDetailsModel> newlyLaunchedItems = [];

  List<AuctionListModel> shopDiamondsByShapeList = [];

  String appbarTitle = '';
  bool isNoDataFound = false;

  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  SearchResultBloc() : super(SearchResultInitialState()) {
    on<InitialSearchResultEvent>(_onInitialSearchResultEvent);
    on<GetSearchResultProductListEvent>(_onGetSearchResultProductListEvent);
    on<SearchResultChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<LoadMoreSearchResultEvent>(_onLoadMoreSearchResultEvent);
    on<SearchResultPullToRefreshEvent>(_onSearchResultPullToRefreshEvent);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      appbarTitle = data[RoutesData.searchResultData] ?? '';
      isNoDataFound = data[RoutesData.isNoDataFound] ?? false;
    }
  }

  void _onInitialSearchResultEvent(InitialSearchResultEvent event, Emitter<SearchResultState> emit) {
    emit(const SearchResultReloadState());
    isGrid = true;
    getRouteData(event.context);
    add(const GetSearchResultProductListEvent());
  }

  void _onGetSearchResultProductListEvent(GetSearchResultProductListEvent event, Emitter<SearchResultState> emit) async {
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(LoadMoreSearchResultEvent(currentPage));
      },
    );

    productList.clear();
    shopDiamondsByShapeList.clear();
    newlyLaunchedItems.clear();
    if (!isNoDataFound) {
      productList = List.generate(
          20,
          (index) => ProductDetailsModel(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
              ));
      refreshCompleter.complete(true);
    } else {
      paginationScrollController.isPageLoaded.complete(true);
      List.generate(5, (index) {
        List<String> nameList = ["Round", "Oval", "Cushion", "Pear", "Emerald"];
        List<String> imageList = [
          "https://i.ibb.co/9TVNqts/1.png",
          "https://i.ibb.co/5B1LRSk/2.png",
          "https://i.ibb.co/gFLXVS0/3.png",
          "https://i.ibb.co/S7q1RKQ/4.png",
          "https://i.ibb.co/gFLXVS0/3.png",
        ];
        shopDiamondsByShapeList.add(
          AuctionListModel(
            id: index.toString(),
            name: nameList[index],
            imageUrl: imageList[index],
          ),
        );
      });
      List.generate(
          5,
          (index) => newlyLaunchedItems.add(
                ProductDetailsModel(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    }

    emit(const SearchResultLoadedState());
  }

  void _onChangeListingTypeEvent(SearchResultChangeListingTypeEvent event, Emitter<SearchResultState> emit) {
    emit(const SearchResultReloadState());
    isGrid = !isGrid;
    emit(const SearchResultChangeListingTypeState());
  }

  Future<void> _onLoadMoreSearchResultEvent(LoadMoreSearchResultEvent event, Emitter<SearchResultState> emit) async {
    emit(const SearchResultLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    List.generate(
        20,
        (index) => productList.add(
              ProductDetailsModel(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
              ),
            ));
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(SearchResultLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onSearchResultPullToRefreshEvent(SearchResultPullToRefreshEvent event, Emitter<SearchResultState> emit) async {
    emit(const SearchResultReloadState());
    await Future.delayed(const Duration(seconds: 2));
    paginationScrollController.pullToRefresh();
    productList = List.generate(
        20,
        (index) => ProductDetailsModel(
              imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
              name: "Diamond Vine Ring in 18k Rose Gold",
              originalPrice: '\$5,000.00',
            ));
    refreshCompleter.complete(true);

    emit(const SearchResultLoadedState());
  }

  Future<bool> pullToRefresh() async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(const SearchResultPullToRefreshEvent());
    bool result = await refreshCompleter.future;
    return result;
  }
}
