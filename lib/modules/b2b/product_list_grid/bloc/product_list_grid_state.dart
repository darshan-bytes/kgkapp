part of 'product_list_grid_bloc.dart';

sealed class ProductListGridState extends Equatable {
  const ProductListGridState();
}

final class ProductListGridInitial extends ProductListGridState {
  @override
  List<Object> get props => [];
}

final class ChangePageNumberState extends ProductListGridState {
  @override
  List<Object> get props => [];
}

final class ReloadProductState extends ProductListGridState {
  @override
  List<Object> get props => [];
}
