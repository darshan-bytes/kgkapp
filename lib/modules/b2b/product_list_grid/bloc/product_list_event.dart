part of 'product_list_bloc.dart';

sealed class ProductListEvent extends Equatable {
  const ProductListEvent();
}

final class InitialProductListEvent extends ProductListEvent {
  final BuildContext context;

  const InitialProductListEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ProductChangeListingTypeEvent extends ProductListEvent {
  const ProductChangeListingTypeEvent();

  @override
  List<Object> get props => [];
}

final class ProductListLoadMoreEvent extends ProductListEvent {
  final int currentPage;
  final BuildContext context;

  const ProductListLoadMoreEvent(this.currentPage, this.context);

  @override
  List<Object> get props => [currentPage, context];
}

final class ProductListPullToRefreshEvent extends ProductListEvent {
  final BuildContext context;

  const ProductListPullToRefreshEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ProductListAddToWatchListEvent extends ProductListEvent {
  final String productId;
  final BuildContext context;

  const ProductListAddToWatchListEvent(this.productId, this.context);

  @override
  List<Object> get props => [productId, context];
}
