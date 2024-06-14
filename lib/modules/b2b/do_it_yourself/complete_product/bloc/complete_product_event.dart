part of 'complete_product_bloc.dart';

sealed class CompleteProductEvent extends Equatable {
  const CompleteProductEvent();
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

class CompleteProductDiamondDetailsToggleEvent extends CompleteProductEvent {
  const CompleteProductDiamondDetailsToggleEvent();

  @override
  List<Object> get props => [];
}

class CompleteProductGemstoneDetailsToggleEvent extends CompleteProductEvent {
  const CompleteProductGemstoneDetailsToggleEvent();

  @override
  List<Object> get props => [];
}
