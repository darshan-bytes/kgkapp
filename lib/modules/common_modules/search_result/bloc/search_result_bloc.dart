import 'package:kgk/kgk.dart';

part 'search_result_event.dart';

part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  bool isGrid = true;
  List<ProductDetails> productList = [];
  List<ProductDetails> newlyLaunchedItems = [];

  List<AuctionListModel> shopDiamondsByShapeList = [];

  String appbarTitle = '';
  bool isNoDataFound = false;

  SearchResultBloc() : super(SearchResultInitialState()) {
    on<InitialSearchResultEvent>(_onInitialSearchResultEvent);
    on<GetSearchResultProductListEvent>(_onGetSearchResultProductListEvent);
    on<SearchResultChangeListingTypeEvent>(_onChangeListingTypeEvent);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      appbarTitle = data[RoutesData.searchResultData] ?? '';
      isNoDataFound = data[RoutesData.isNoDataFound] ?? false;
    }
  }

  void _onInitialSearchResultEvent(InitialSearchResultEvent event, Emitter<SearchResultState> emit) {
    emit(SearchResultReloadState());
    isGrid = true;
    getRouteData(event.context);
    add(const GetSearchResultProductListEvent());
  }

  void _onGetSearchResultProductListEvent(GetSearchResultProductListEvent event, Emitter<SearchResultState> emit) async {
    emit(SearchResultReloadState());
    productList.clear();
    shopDiamondsByShapeList.clear();
    newlyLaunchedItems.clear();
    if (!isNoDataFound) {
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    } else {
      List.generate(20, (index) {
        List<String> nameList = ["Round", "Oval", "Cushion", "Pear", "Pendant"];
        List<String> imageList = [
          "https://i.ibb.co/yBHp2KB/image-7.png",
          "https://i.ibb.co/477f41r/Group-1410089379.png",
          "https://i.ibb.co/sggT4PJ/Group-1410089378.png"
        ];
        shopDiamondsByShapeList.add(
          AuctionListModel(
            id: index.toString(),
            name: nameList[Random().nextInt(nameList.length)],
            imageUrl: imageList[Random().nextInt(imageList.length)],
          ),
        );
      });
      List.generate(
          5,
          (index) => newlyLaunchedItems.add(
                ProductDetails(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    }
    emit(SearchResultLoadedState());
  }

  void _onChangeListingTypeEvent(SearchResultChangeListingTypeEvent event, Emitter<SearchResultState> emit) {
    emit(SearchResultReloadState());
    isGrid = !isGrid;
    emit(SearchResultChangeListingTypeState());
  }
}
