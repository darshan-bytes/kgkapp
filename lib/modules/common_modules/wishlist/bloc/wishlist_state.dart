part of 'wishlist_bloc.dart';

sealed class WishlistState extends Equatable {
  const WishlistState();
}

final class WishlistInitial extends WishlistState {
  @override
  List<Object> get props => [];
}

final class WishlistReloadState extends WishlistState {
  @override
  List<Object> get props => [];
}

final class WishlistDataFetchedState extends WishlistState {
  @override
  List<Object> get props => [];
}

final class ChangeWishlistPageNumberState extends WishlistState {
  @override
  List<Object> get props => [];
}
