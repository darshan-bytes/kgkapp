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
  final bool isGrid;

  const ProductChangeListingTypeEvent({required this.isGrid});

  @override
  List<Object> get props => [isGrid];
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

final class ProductSortEvent extends ProductListEvent {
  final BuildContext context;
  final SortOptions sortData;

  const ProductSortEvent({required this.context, required this.sortData});

  @override
  List<Object> get props => [context, sortData];
}

final class ProductFilterEvent extends ProductListEvent {
  final BuildContext context;
  final List<FilterData> filterData;

  const ProductFilterEvent({required this.context, required this.filterData});

  @override
  List<Object> get props => [context, filterData];
}
