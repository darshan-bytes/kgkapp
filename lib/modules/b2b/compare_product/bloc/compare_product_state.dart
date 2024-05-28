part of 'compare_product_bloc.dart';

sealed class CompareProductState extends Equatable {
  const CompareProductState();
}

final class CompareProductInitial extends CompareProductState {
  @override
  List<Object> get props => [];
}
