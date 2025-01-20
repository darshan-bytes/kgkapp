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

final class CompleteProductCompareToggleState extends CompleteProductState {
  final bool isCompare;

  const CompleteProductCompareToggleState(this.isCompare);

  @override
  List<Object> get props => [isCompare];
}
