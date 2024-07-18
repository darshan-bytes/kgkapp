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

  const ProductListLoadMoreEvent(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ProductListPullToRefreshEvent extends ProductListEvent {
  const ProductListPullToRefreshEvent();

  @override
  List<Object> get props => [];
}
