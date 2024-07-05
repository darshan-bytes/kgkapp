import 'package:kgk/kgk.dart';

part 'product_list_event.dart';

part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  // Identifies the source of the user: B2B or B2C.
  UserType userType = UserType.b2cUser;

  // For Product List view
  bool isGrid = true;

  // For Watchlist
  WatchlistSelectionModel? selectedWatchlistName;

  String appbarTitle = APPStrings.ring.tr;

  ScreenIdentifier screenIdentifier = ScreenIdentifier.productForRing;

  List<ProductDetails> productList = [];
  SmartPaginationScrollController paginationScrollController = SmartPaginationScrollController();

  // For Watchlist
  List<WatchlistSelectionModel> arrWatchlist = [
    WatchlistSelectionModel(name: "John Samanta"),
    WatchlistSelectionModel(name: "Jenny Wilson"),
    WatchlistSelectionModel(name: "Alex Williams"),
  ];

  List<WatchlistSelectionModel> arrSelectedWatchlist = [
    WatchlistSelectionModel(name: "Notify when product is in stock"),
    WatchlistSelectionModel(name: "Notify when price drops"),
    WatchlistSelectionModel(name: "Notify when discount is applied"),
  ];

  ProductListBloc() : super(ProductListInitial()) {
    on<InitialProductListEvent>(_onInitialProductListEvent);
    on<ProductListLoadMoreEvent>(_onProductListLoadMoreEvent);
    on<ProductChangeListingTypeEvent>(_onChangeListingTypeEvent);
    on<WatchlistChangeNameEvent>(_onChangeWatchList);
    on<WatchlistCheckEvent>(_onSelectedWatchlistEvent);
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

    emit(ReloadProductState());
    paginationScrollController.init(
      loadAction: (int currentPage) async {
        add(ProductListLoadMoreEvent(currentPage));
      },
    );
    isGrid = true;
    getRouteData(event.context);

    if (screenIdentifier == ScreenIdentifier.productForRing) {
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
    } else if (screenIdentifier == ScreenIdentifier.diamondForDefault) {
      appbarTitle = APPStrings.diamond.tr;
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

  Future<void> _onProductListLoadMoreEvent(ProductListLoadMoreEvent event, Emitter<ProductListState> emit) async {
    emit(ProductListLoadingMoreState());
    await Future.delayed(const Duration(seconds: 2));
    if (screenIdentifier == ScreenIdentifier.productForRing) {
      List.generate(
          10,
          (index) => productList.add(ProductDetails(
                imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/xStbncs/image-7-5.png",
                name: "Diamond Vine Ring in 18k Rose Gold",
                originalPrice: '\$5,000.00',
                discountPercentage: "You have saved 10%",
                offerPrice: '\$3,000.00',
              )));
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
    paginationScrollController.isPageLoaded.complete(event.currentPage == 3);
    emit(ProductListLoadedMoreState(event.currentPage + 1));
  }

  void _onChangeListingTypeEvent(ProductChangeListingTypeEvent event, Emitter<ProductListState> emit) {
    emit(ReloadProductState());
    isGrid = !isGrid;
    emit(ProductChangeListingTypeState());
  }

  void _onChangeWatchList(WatchlistChangeNameEvent event, Emitter<ProductListState> emit) {
    emit((ReloadProductState()));
    selectedWatchlistName = event.selectedWatchlist;
    if (selectedWatchlistName != null) {
      emit(WatchlistChangeNameState(selectedWatchlistName!));
    }
  }

  void _onSelectedWatchlistEvent(WatchlistCheckEvent event, Emitter<ProductListState> emit) {
    emit(ReloadProductState());
    final int index = arrSelectedWatchlist.indexWhere((element) => element == event.checkWatchlist);
    if (index != -1) {
      arrSelectedWatchlist[index].isSelected = !arrSelectedWatchlist[index].isSelected;
      emit(WatchlistSelectedState(arrSelectedWatchlist[index]));
    }
  }
}
