import 'package:kgk/kgk.dart';

part 'wishlist_updater_service_event.dart';

part 'wishlist_updater_service_state.dart';

class WishlistUpdaterServiceBloc extends Bloc<WishlistUpdaterServiceEvent, WishlistUpdaterServiceState> {
  WishlistUpdaterServiceBloc() : super(WishlistUpdaterServiceInitial()) {
    on<WishListUpdateProductEvent>(_onWishListUpdateProduct);
  }

  void _onWishListUpdateProduct(WishListUpdateProductEvent event, Emitter<WishlistUpdaterServiceState> emit) {
    emit(WishListUpdateProductState(event.productId, event.wishlistId));
  }
}
