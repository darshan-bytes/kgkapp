part of 'complete_product_bloc.dart';

sealed class CompleteProductState extends Equatable {
  const CompleteProductState();
}

final class CompleteProductInitial extends CompleteProductState {
  @override
  List<Object> get props => [];
}

final class CompleteProductCompareToggleState extends CompleteProductState {
  final bool isCompare;

  const CompleteProductCompareToggleState(this.isCompare);

  @override
  List<Object> get props => [isCompare];
}

class CompleteProductRingDetailsToggleState extends CompleteProductState {
  final bool isRingDetailsOpen;

  const CompleteProductRingDetailsToggleState(this.isRingDetailsOpen);

  @override
  List<Object> get props => [isRingDetailsOpen];
}

class CompleteProductDiamondDetailsToggleState extends CompleteProductState {
  final bool isDiamondDetailsOpen;

  const CompleteProductDiamondDetailsToggleState(this.isDiamondDetailsOpen);

  @override
  List<Object> get props => [isDiamondDetailsOpen];
}

class CompleteProductGemstoneDetailsToggleState extends CompleteProductState {
  final bool isGemstoneDetailsOpen;

  const CompleteProductGemstoneDetailsToggleState(this.isGemstoneDetailsOpen);

  @override
  List<Object> get props => [isGemstoneDetailsOpen];
}
