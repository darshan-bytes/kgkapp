part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class InitialWishlistEvent extends WishlistEvent {
  const InitialWishlistEvent();

  @override
  List<Object> get props => [];
}

class LoadMoreWishlistEvent extends WishlistEvent {
  final int currentPage;

  const LoadMoreWishlistEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
