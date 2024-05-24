part of 'complete_product_bloc.dart';

sealed class CompleteProductEvent extends Equatable {
  const CompleteProductEvent();
}

final class CompleteProductImageChangeEvent extends CompleteProductEvent {
  final int index;

  const CompleteProductImageChangeEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class CompleteProductCompareToggle extends CompleteProductEvent {
  final bool isCompare;

  const CompleteProductCompareToggle(this.isCompare);

  @override
  List<Object> get props => [];
}

class ProductRingDetailsToggleEvent extends CompleteProductEvent {
  final bool isRingDetailsOpen;

  const ProductRingDetailsToggleEvent({required this.isRingDetailsOpen});

  @override
  List<Object> get props => [isRingDetailsOpen];
}

class ProductDiamondDetailsToggleEvent extends CompleteProductEvent {
  final bool isDiamondDetailsOpen;

  const ProductDiamondDetailsToggleEvent({required this.isDiamondDetailsOpen});

  @override
  List<Object> get props => [isDiamondDetailsOpen];
}
