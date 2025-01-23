part of 'product_list_bloc.dart';

sealed class ProductListState extends Equatable {
  const ProductListState();
}

final class ProductListInitial extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ReloadProductState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListLoadedState extends ProductListState {
  const ProductListLoadedState();

  @override
  List<Object> get props => [];
}

final class ProductChangeListingTypeState extends ProductListState {
  const ProductChangeListingTypeState();

  @override
  List<Object> get props => [];
}

final class ProductListLoadingMoreState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListLoadedMoreState extends ProductListState {
  final int currentPage;

  const ProductListLoadedMoreState(this.currentPage);

  @override
  List<Object> get props => [currentPage];
}

final class ProductListLoadingState extends ProductListState {
  @override
  List<Object> get props => [];
}

final class ProductListFilterLoadedState extends ProductListState {
  const ProductListFilterLoadedState();

  @override
  List<Object> get props => [];
}
