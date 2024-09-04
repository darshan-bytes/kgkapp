part of 'wishlist_bloc.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();
}

class InitialWishlistEvent extends WishlistEvent {
  final BuildContext context;

  const InitialWishlistEvent(this.context);

  @override
  List<Object> get props => [context];
}

class LoadMoreWishlistEvent extends WishlistEvent {
  final BuildContext context;
  final int currentPage;

  const LoadMoreWishlistEvent(this.context,this.currentPage);

  @override
  List<Object> get props => [context,currentPage];
}

final class WishlistPullToRefreshEvent extends WishlistEvent {
  final BuildContext context;

  const WishlistPullToRefreshEvent(this.context);

  @override
  List<Object> get props => [context];
}
