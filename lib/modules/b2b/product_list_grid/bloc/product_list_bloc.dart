import 'package:kgk/kgk.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  // For Product List view
  bool isGrid = true;

  // check user come form ring or diamond
  bool fromRing = true;

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
      if (data[RoutesData.productListData] != null) {
        final int userData = data[RoutesData.productListData];
        if (userData == 0) {
          fromRing = true;
        } else {
          fromRing = false;
        }
      }
    }
  }

  Future<void> _onInitialProductListEvent(InitialProductListEvent event, Emitter<ProductListState> emit) async {
    emit(ReloadProductState());
    isGrid = true;
    getRouteData(event.context);

    if (fromRing) {
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(ProductDetails(
                imageUrl:
                    'https://s3-alpha-sig.figma.com/img/b565/a299/4cad8feb0dc565fcb23a5df4b8a8aa9f?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bngvfjokcYR5qP3qicAkkvvY9SxFgBLXhBlaL~4lqLjlUOko6k2LOmg5LT5GSAikSbdf4TJh64kIfhs59GcliNFg9UQU9Zstps6QkpWjHsgc~kInzl3rKyBeeFTQDGMFwLzBsLdjlnQiYh7uN3Y8xPpFeW7xewz~z9TST5RzBgFkAd2d-jyJiyrnlOc5ubcYsSlBG3DpKp7--GzK4OzkespCMjGgFO608x3N-~~CVZd5QeNBYTLTJODLe9DABhX~DDeTDyun-3Ihcp7jvxl7y9UbR9zLQDR6H67fYYxXN3WhLZshgLz8RVAT~RG-UDqKv2zTyMd-f8xi9E4CAy7sng__',
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
                discountPercentage: "You have saved 10%",
                offerPrice: '\$3,000.00',
              )));
      emit(ProductListInitial());
    } else {
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "1.5 gram",
                  gram: "1.5 gram",
                  imageUrl:
                      "https://s3-alpha-sig.figma.com/img/9ebd/9517/705a51c9fc5153f1dfac36afd60d16c9?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=CEg00oBHot6FBC0S~Jgw7iEpQ8mNWZVdQNorFxVAef310QMk5wmJYsAJm6gNWbd9YG-WSLNPc6Q9MAPEeXz2BgYTWjrTnkQWPWCgxqJswcHGQHgnZxMZmXM96HnkylNG17Pg~WURYovysiTsZS8p7H35ha09xWKBhxQvFf8Y6I5pyO2QTiPF-xHyabnzy~6lzTJXnXrEbKli7InPVL0hXMn1EDrTSMr4BAh1y0oZYzz-VQWRuFRn7mmyBpOhrkUrBMucWnlfpB9F3rz72aAqE898LfJTKfdSILEP41fI-fVdASU9sAMhm6b9XPwXvt-VjcU0PqEdDuUh8sAgW2fDGw__",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000",
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
