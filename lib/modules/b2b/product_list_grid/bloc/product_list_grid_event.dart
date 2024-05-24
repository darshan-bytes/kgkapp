part of 'product_list_grid_bloc.dart';

sealed class ProductListGridEvent extends Equatable {
  const ProductListGridEvent();
}

final class InitialProductListGridEvent extends ProductListGridEvent {
  final BuildContext context;

  const InitialProductListGridEvent(this.context);

  @override
  List<Object> get props => [context];
}

class ChangePageNumberEvent extends ProductListGridEvent {
  final String pageNumber;

  const ChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class ProductChangeListingTypeEvent extends ProductListGridEvent {
  final bool isGrid;

  const ProductChangeListingTypeEvent(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}
