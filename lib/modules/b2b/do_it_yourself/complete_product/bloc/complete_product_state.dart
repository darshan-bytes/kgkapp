part of 'complete_product_bloc.dart';

sealed class CompleteProductState extends Equatable {
  const CompleteProductState();
}

final class CompleteProductInitial extends CompleteProductState {
  @override
  List<Object> get props => [];
}

final class CompleteProductLoadedState extends CompleteProductState {
  const CompleteProductLoadedState();

  @override
  List<Object> get props => [];
}
