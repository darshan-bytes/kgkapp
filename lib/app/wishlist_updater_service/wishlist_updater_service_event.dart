part of 'wishlist_updater_service_bloc.dart';

sealed class WishlistUpdaterServiceEvent extends Equatable {
  const WishlistUpdaterServiceEvent();
}

final class WishListUpdateProductEvent extends WishlistUpdaterServiceEvent {
  final String productId;
  final String wishlistId;

  const WishListUpdateProductEvent(this.productId, {this.wishlistId = ''});

  @override
  List<Object> get props => [productId, wishlistId];
}
