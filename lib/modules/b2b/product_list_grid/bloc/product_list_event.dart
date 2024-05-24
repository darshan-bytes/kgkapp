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

class ChangePageNumberEvent extends ProductListEvent {
  final String pageNumber;

  const ChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}

class ProductChangeListingTypeEvent extends ProductListEvent {
  final bool isGrid;

  const ProductChangeListingTypeEvent(this.isGrid);

  @override
  List<Object> get props => [isGrid];
}
