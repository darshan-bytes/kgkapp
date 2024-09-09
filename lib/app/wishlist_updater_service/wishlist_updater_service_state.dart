part of 'wishlist_updater_service_bloc.dart';

sealed class WishlistUpdaterServiceState extends Equatable {
  const WishlistUpdaterServiceState();
}

final class WishlistUpdaterServiceInitial extends WishlistUpdaterServiceState {
  @override
  List<Object> get props => [];
}

final class WishListUpdateProductState extends WishlistUpdaterServiceState {
  final String productId;
  final String wishlistId;

  const WishListUpdateProductState(this.productId, this.wishlistId);

  @override
  List<Object> get props => [productId, wishlistId];
}
