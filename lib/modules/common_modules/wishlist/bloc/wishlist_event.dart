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

  const LoadMoreWishlistEvent(this.context, this.currentPage);

  @override
  List<Object> get props => [context, currentPage];
}

final class WishlistPullToRefreshEvent extends WishlistEvent {
  final BuildContext context;

  const WishlistPullToRefreshEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ProductRemoveFromWishlistEvent extends WishlistEvent {
  final ProductDetailsModel productDetails;

  const ProductRemoveFromWishlistEvent(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

final class WishlistFilterEvent extends WishlistEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const WishlistFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}
