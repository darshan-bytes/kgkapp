part of 'product_list_grid_bloc.dart';

sealed class ProductListGridEvent extends Equatable {
  const ProductListGridEvent();
}

class ChangePageNumberEvent extends ProductListGridEvent {
  final String pageNumber;

  const ChangePageNumberEvent(this.pageNumber);

  @override
  List<Object> get props => [pageNumber];
}
