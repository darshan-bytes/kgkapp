import 'package:kgk/kgk.dart';
import 'package:kgk/modules/b2b/product_list_grid/model/jewellery_listing_model.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  // For Product List view
  bool isGrid = true;

  // For Watchlist

  String appbarTitle = APPStrings.ring.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;

  List<ProductDetails> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();
  Completer<bool> refreshCompleter = Completer<bool>();

  int currentPage = 1;
  int? totalNumberOfPages;
  int limit = 10;

  List<JewelleryDatum> jewelleryDatumList = [];

  ProductListBloc() : super(ProductListInitial()) {
    on<InitialProductListEvent>(_onInitialProductListEvent);
    on<ProductListLoadMoreEvent>(_onProductListLoadMoreEvent);
    on<ProductChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<ProductListPullToRefreshEvent>(_onProductListPullToRefresh);
  }

  @override
  Future<void> close() {
    paginationScrollController.dispose();
    return super.close();
  }

  void getRouteData(BuildContext context) async {
    Map<RoutesData, dynamic>? data = context.routesData;
    if (data != null) {
      screenIdentifier = data[RoutesData.isPageFor] ?? ScreenIdentifier.productForRing;
    }
  }

  Future<void> _onInitialProductListEvent(InitialProductListEvent event, Emitter<ProductListState> emit) async {
    // assigning current userType
    userType = BlocProvider.of<AppBloc>(event.context).userType;

    if (!refreshCompleter.isCompleted) {
      refreshCompleter.complete(true);
    }

    emit(ReloadProductState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProductListLoadMoreEvent(currentPage, event.context));
      },
    );
    isGrid = true;
    getRouteData(event.context);

    if (screenIdentifier == ScreenIdentifier.productForRing) {
      appbarTitle = APPStrings.ring.tr;
      productList.clear();
      await fetchJewelleriesList(event.context, emit, true);
      // List.generate(
      //     20,
      //     (index) => productList.add(ProductDetails(
      //           imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
      //           name: "Diamond Vine Ring in 18k Rose Gold",
      //           originalPrice: '\$5,000.00',
      //           discountPercentage: "You have saved 10%",
      //           offerPrice: '\$3,000.00',
      //           company: "Martin Flyer",
      //           productSku: "DERS01XXSRR",
      //           isOutOfStock: index % 2 == 0,
      //         )));
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      appbarTitle = APPStrings.diamonds.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000.00",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      List.generate(
          20,
          (index) => productList.add(
                ProductDetails(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/Lk4H7Wj/image-7-1.png" : "https://i.ibb.co/Gxkhf7J/image-7.png",
                  name: "Diamond Vine Ring in 18k Yellow Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    }
    emit(const ProductListLoadedState());
  }

  Future<void> fetchJewelleriesList(BuildContext context, Emitter<ProductListState> emit, bool isLoadMore) async {
    String currency = StorageManager().getSelectedCurrencySymbol() ?? "";
    await AppRepository(context)
        .fetchJewelleryList(page: currentPage.toString(), isLoadMore: isLoadMore, limit: limit.toString(), type: '')
        .then((value) async {
      value?.fold((l) {
        Utils.showMessage(l.message ?? "");
      }, (r) {
        jewelleryDatumList = r.data;
        r.totalRecords ??= 0;
        totalNumberOfPages = (r.totalRecords! % limit == 0) ? (r.totalRecords ?? 0) ~/ limit : ((r.totalRecords ?? 0) ~/ limit) + 1;

        List.generate(jewelleryDatumList.length, (index) {
          productList.add(ProductDetails(
            imageUrl: "",
            name: jewelleryDatumList[index].productDescription ?? "",
            originalPrice: "$currency ${jewelleryDatumList[index].finalPrice ?? ""}",
            discountPercentage: "You have saved 10%",
            offerPrice: "$currency ${jewelleryDatumList[index].discountPrice ?? ""}",
            // company: jewelleryDatumList[index].company ?? "",
            // productSku: jewelleryDatumList[index].sku ?? "",
            // isOutOfStock: jewelleryDatumList[index].isOutOfStock ?? false,
          ));
        });

        // List.generate(
        //     20,
        //     (index) => productList.add(ProductDetails(
        //           imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
        //           name: "Diamond Vine Ring in 18k Rose Gold",
        //           originalPrice: '\$5,000.00',
        //           discountPercentage: "You have saved 10%",
        //           offerPrice: '\$3,000.00',
        //           company: "Martin Flyer",
        //           productSku: "DERS01XXSRR",
        //           isOutOfStock: index % 2 == 0,
        //         )));
      });
    });
  }

  Future<void> _onProductListLoadMoreEvent(ProductListLoadMoreEvent event, Emitter<ProductListState> emit) async {
    emit(ProductListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      currentPage++;
      await fetchJewelleriesList(event.context, emit, false);
      // List.generate(
      //     10,
      //     (index) => productList.add(ProductDetails(
      //           imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
      //           name: "Diamond Vine Ring in 18k Rose Gold",
      //           originalPrice: '\$5,000.00',
      //           discountPercentage: "You have saved 10%",
      //           offerPrice: '\$3,000.00',
      //           company: "Martin Flyer",
      //           productSku: "DERS01XXSRR",
      //           isOutOfStock: index % 2 == 0,
      //         )));
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetails(
                  diamond: "2.5 crt",
                  gram: "1.5 grms",
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
                  name: "2.00 Carat H VS1 Excellent Cut Round Setting",
                  originalPrice: "\$3,000.00",
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetails(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                  name: "Diamond Vine Ring in 18k Rose Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      List.generate(
          10,
          (index) => productList.add(
                ProductDetails(
                  imageUrl: index % 2 == 0 ? "https://i.ibb.co/Lk4H7Wj/image-7-1.png" : "https://i.ibb.co/Gxkhf7J/image-7.png",
                  name: "Diamond Vine Ring in 18k Yellow Gold",
                  originalPrice: '\$5,000.00',
                ),
              ));
    }
    paginationScrollController.isPageLoaded.complete(event.currentPage == totalNumberOfPages);
    emit(ProductListLoadedMoreState(event.currentPage + 1));
  }

  Future<void> _onProductListPullToRefresh(ProductListPullToRefreshEvent event, Emitter<ProductListState> emit) async {
    paginationScrollController.pullToRefresh();
    await Future.delayed(const Duration(seconds: 1));
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      appbarTitle = APPStrings.ring.tr;
      productList.clear();
      await fetchJewelleriesList(event.context, emit, true);
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      appbarTitle = APPStrings.diamonds.tr;
      productList.clear();
      productList = List.generate(
        20,
        (index) => ProductDetails(
          diamond: "2.5 crt",
          gram: "1.5 grms",
          imageUrl: index % 2 == 0 ? "https://i.ibb.co/FDQpQYW/image-7-1.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
          name: "2.00 Carat H VS1 Excellent Cut Round Setting",
          originalPrice: "\$3,000.00",
        ),
      ).toList();
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryGrey) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      productList = List.generate(
          20,
          (index) => ProductDetails(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
              )).toList();
    } else if (screenIdentifier == ScreenIdentifier.productForLibraryPlatinum) {
      appbarTitle = APPStrings.productLibrary.tr;
      productList.clear();
      productList = List.generate(
          20,
          (index) => ProductDetails(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/Lk4H7Wj/image-7-1.png" : "https://i.ibb.co/Gxkhf7J/image-7.png",
                name: "Diamond Vine Ring in 18k Yellow Gold",
                originalPrice: '\$5,000.00',
              )).toList();
    }
    refreshCompleter.complete(true);
    emit(const ProductListLoadedState());
  }

  Future<bool> pullToRefresh(BuildContext context) async {
    if (!refreshCompleter.isCompleted) {
      return false;
    }
    refreshCompleter = Completer<bool>();
    add(ProductListPullToRefreshEvent(context));
    bool result = await refreshCompleter.future;
    return result;
  }

  void _onChangeListingTypeEvent(ProductChangeListingTypeEvent event, Emitter<ProductListState> emit) {
    emit(ReloadProductState());
    isGrid = !isGrid;
    emit(ProductChangeListingTypeState());
  }
}
