part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class InitialWishlistEvent extends WishlistEvent {
  const InitialWishlistEvent();

  @override
  List<Object> get props => [];
}

class ChangeWishlistPageNumberEvent extends WishlistEvent {
  final String pageNumber;

  const ChangeWishlistPageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
