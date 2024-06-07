import 'package:kgk/kgk.dart';

part 'wishlist_event.dart';

part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  List<ProductDetails> productList = [];

  // List of numbers for the dropdown
  List<String> pageNumbers = ['01', '02', '03', '04', '05', '06', '07', '08', '09', '10'];

  // The selected number of pages, initialized to the first item
  String selectedPageNumber = '01';

  WishlistBloc() : super(WishlistInitial()) {
    on<InitialWishlistEvent>(onInitialWishlistEvent);
    on<ChangeWishlistPageNumberEvent>(onPageNumberChanged);
  }

  void onInitialWishlistEvent(InitialWishlistEvent event, Emitter<WishlistState> emit) {
    emit(WishlistReloadState());
    productList.clear();

    List.generate(
        20,
        (index) => productList.add(ProductDetails(
              imageUrl: index % 2 == 0 ? "https://i.ibb.co/zZ6y0w4/image-7-4.png" : "https://i.ibb.co/8xM4BxQ/image-7.png",
              name: "Diamond Vine Ring in 18k Rose Gold",
              originalPrice: '\$5,000.00',
              // offerPrice: '\$3,000.00',
            )));

    emit(WishlistDataFetchedState());
  }

  void onPageNumberChanged(ChangeWishlistPageNumberEvent event, Emitter<WishlistState> emit) {
    emit(WishlistReloadState());
    selectedPageNumber = event.pageNumber;
    emit(WishlistDataFetchedState());
  }
}
