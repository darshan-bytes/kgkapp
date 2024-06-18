import 'package:kgk/kgk.dart';

part 'search_result_event.dart';

part 'search_result_state.dart';

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  bool isGrid = true;
  List<ProductDetails> productList = [];

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  String appbarTitle = '';

  SearchResultBloc() : super(SearchResultInitialState()) {
    on<InitialSearchResultEvent>(_onInitialSearchResultEvent);
    on<GetSearchResultProductListEvent>(_onGetSearchResultProductListEvent);
    on<SearchResultChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<SearchResultProductChangePageNumberEvent>(_onPageNumberChanged);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      appbarTitle = data[RoutesData.searchResultData];
    }
  }

  void _onInitialSearchResultEvent(InitialSearchResultEvent event, Emitter<SearchResultState> emit) {
    emit(SearchResultReloadState());
    isGrid = true;
    getRouteData(event.context);
    add(const GetSearchResultProductListEvent());
    emit(SearchResultInitialState());
  }

  void _onGetSearchResultProductListEvent(GetSearchResultProductListEvent event, Emitter<SearchResultState> emit) async {
    emit(SearchResultReloadState());
    List.generate(
        20,
        (index) => productList.add(
              ProductDetails(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
              ),
            ));
    emit(SearchResultInitialState());
  }

  void _onChangeListingTypeEvent(SearchResultChangeListingTypeEvent event, Emitter<SearchResultState> emit) {
    emit(SearchResultReloadState());
    isGrid = event.isGrid;
    emit(SearchResultChangeListingTypeState(event.isGrid));
  }

  void _onPageNumberChanged(SearchResultProductChangePageNumberEvent event, Emitter<SearchResultState> emit) {
    emit(SearchResultReloadState());
    selectedPageNumber = event.pageNumber;
    emit(SearchResultProductChangePageNumberState());
  }
}
