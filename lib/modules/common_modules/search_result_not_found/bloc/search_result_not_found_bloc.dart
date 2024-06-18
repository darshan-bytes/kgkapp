import 'package:kgk/kgk.dart';

part 'search_result_not_found_event.dart';

part 'search_result_not_found_state.dart';

class SearchResultNotFoundBloc extends Bloc<SearchResultNotFoundEvent, SearchResultNotFoundState> {
  List<ProductDetails> productList = [];

  String appbarTitle = '';

  SearchResultNotFoundBloc() : super(SearchResultNotFoundInitialState()) {
    on<InitialSearchResultNotFoundEvent>(_onInitialSearchResultNotFoundEvent);
    on<GetSearchResultNotFoundProductListEvent>(_onGetSearchResultNotFoundProductListEvent);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      appbarTitle = data[RoutesData.searchResultData] ?? "";
    }
  }

  void _onInitialSearchResultNotFoundEvent(InitialSearchResultNotFoundEvent event, Emitter<SearchResultNotFoundState> emit) {
    emit(SearchResultNotFoundReloadState());
    getRouteData(event.context);
    add(const GetSearchResultNotFoundProductListEvent());
    emit(SearchResultNotFoundInitialState());
  }

  void _onGetSearchResultNotFoundProductListEvent(
      GetSearchResultNotFoundProductListEvent event, Emitter<SearchResultNotFoundState> emit) async {
    emit(SearchResultNotFoundReloadState());
    List.generate(
        20,
        (index) => productList.add(
              ProductDetails(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
              ),
            ));
    emit(SearchResultNotFoundInitialState());
  }
}
