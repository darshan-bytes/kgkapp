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
              imageUrl:
                  'https://s3-alpha-sig.figma.com/img/b565/a299/4cad8feb0dc565fcb23a5df4b8a8aa9f?Expires=1717372800&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=bngvfjokcYR5qP3qicAkkvvY9SxFgBLXhBlaL~4lqLjlUOko6k2LOmg5LT5GSAikSbdf4TJh64kIfhs59GcliNFg9UQU9Zstps6QkpWjHsgc~kInzl3rKyBeeFTQDGMFwLzBsLdjlnQiYh7uN3Y8xPpFeW7xewz~z9TST5RzBgFkAd2d-jyJiyrnlOc5ubcYsSlBG3DpKp7--GzK4OzkespCMjGgFO608x3N-~~CVZd5QeNBYTLTJODLe9DABhX~DDeTDyun-3Ihcp7jvxl7y9UbR9zLQDR6H67fYYxXN3WhLZshgLz8RVAT~RG-UDqKv2zTyMd-f8xi9E4CAy7sng__',
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
