part of 'compare_product_bloc.dart';

sealed class CompareProductState extends Equatable {
  const CompareProductState();
}

final class CompareProductInitial extends CompareProductState {
  const CompareProductInitial();

  @override
  List<Object> get props => [];
}

final class CompareProductAddedState extends CompareProductState {
  final List<String> productIdList;

  const CompareProductAddedState({required this.productIdList});

  @override
  List<Object> get props => [productIdList];
}

final class CompareProductReloadState extends CompareProductState {
  const CompareProductReloadState();

  @override
  List<Object> get props => [];
}

final class CompareProductLoadingState extends CompareProductState {
  const CompareProductLoadingState();

  @override
  List<Object> get props => [];
}

final class CompareProductsLoadedState extends CompareProductState {
  const CompareProductsLoadedState();

  @override
  List<Object> get props => [];
}

final class CompareProductErrorState extends CompareProductState {
  final String message;

  const CompareProductErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
