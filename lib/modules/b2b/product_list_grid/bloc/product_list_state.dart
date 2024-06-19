part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();
}

final class ProductListInitial extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ChangePageNumberState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ReloadProductState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductChangeListingTypeState extends ProductListState {
  @override
  List<Object> get props => [];
}
