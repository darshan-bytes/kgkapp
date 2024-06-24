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

final class WishlistLoadingMoreState extends WishlistState {
  @override
  List<Object> get props => [];
}

final class WishlistLoadedMoreState extends WishlistState {
  final int currentPage;

  const WishlistLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}
