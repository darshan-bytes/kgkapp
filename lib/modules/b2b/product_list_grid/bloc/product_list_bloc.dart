import 'package:kgk/kgk.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  // For Product List view
  bool isGrid = true;

  // check user come form ring or diamond
  bool fromRing = true;

  String appbarTitle = APPStrings.ring.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.productListingForRing;

  List<ProductDetails> productList = [];

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  ProductListBloc() : super(ProductListInitial()) {
    on<InitialProductListEvent>(_onInitialProductListEvent);
    on<ChangePageNumberEvent>(onPageNumberChanged);
    on<ProductChangeListingTypeEvent>(_onChangeListingTypeEvent);
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.productListingForRing;
    }
  }

  Future<void> _onInitialProductListEvent(InitialProductListEvent event, Emitter<ProductListState> emit) async {
    emit(ReloadProductState());
    isGrid = true;
    getRouteData(event.context);

    if (screenIdentifier == ScreenIdentifier.productListingForRing) {
      appbarTitle = APPStrings.ring.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(ProductDetails(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
                discountPercentage: "You have saved 10%",
                offerPrice: '\$3,000.00',
              )));
      emit(ProductListInitial());
    } else if (screenIdentifier == ScreenIdentifier.productListingForDiamonds) {
      appbarTitle = APPStrings.diamond.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "1.5 gram",
                  gram: "1.5 gram",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000",
                ),
              ));
      emit(ProductListInitial());
    } else if (screenIdentifier == ScreenIdentifier.productListingForGemstones) {
      appbarTitle = APPStrings.gemstone.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "1.5 gram",
                  gram: "1.5 gram",
                  imageUrl:
                      index % 2 == 0 ? "https://i.ibb.co/477f41r/Group-1410089379.png" : "https://i.ibb.co/sggT4PJ/Group-1410089378.png",
                  name: "0.35 Carat Super Premium Oval Moissanite",
                  originalPrice: "\$1,600 .00",
                ),
              ));
      emit(ProductListInitial());
    }
  }

  void onPageNumberChanged(ChangePageNumberEvent event, Emitter<ProductListState> emit) {
    emit(ReloadProductState());
    selectedPageNumber = event.pageNumber;
    emit(ChangePageNumberState());
  }

  void _onChangeListingTypeEvent(ProductChangeListingTypeEvent event, Emitter<ProductListState> emit) {
    emit(ReloadProductState());
    isGrid = event.isGrid;
    emit(ProductChangeListingTypeState(event.isGrid));
  }
}
