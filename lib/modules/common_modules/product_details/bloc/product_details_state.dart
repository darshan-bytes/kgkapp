part of 'product_details_bloc.dart';

sealed class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

final class ProductDetailsInitialState extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

final class ProductDetailsLoadingState extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

final class ProductDetailsLoadedState extends ProductDetailsState {
  final ProductDetails productDetails;

  const ProductDetailsLoadedState(this.productDetails);

  @override
  List<Object> get props => [productDetails];
}

final class ProductImagePageChangeState extends ProductDetailsState {
  final int current;

  const ProductImagePageChangeState(this.current);

  @override
  List<Object> get props => [current];
}

final class ProductCompareToggleState extends ProductDetailsState {
  final bool isCompare;

  const ProductCompareToggleState(this.isCompare);

  @override
  List<Object> get props => [isCompare];
}

final class ProductCustomizationChangeState extends ProductDetailsState {
  final int index;
  final int childIndex;
  final int oldChildIndex;

  const ProductCustomizationChangeState(this.index, this.childIndex, this.oldChildIndex);

  @override
  List<Object> get props => [index, childIndex, oldChildIndex];
}

final class RingDetailsToggleState extends ProductDetailsState {
  final bool isRingDetailsOpen;

  const RingDetailsToggleState(this.isRingDetailsOpen);

  @override
  List<Object> get props => [isRingDetailsOpen];
}

final class ProductDiamondDetailsToggleState extends ProductDetailsState {
  final bool isDiamondDetailsOpen;

  const ProductDiamondDetailsToggleState(this.isDiamondDetailsOpen);

  @override
  List<Object> get props => [isDiamondDetailsOpen];
}

final class GemstoneDetailsToggleState extends ProductDetailsState {
  final bool isGemstoneDetailsOpen;

  const GemstoneDetailsToggleState(this.isGemstoneDetailsOpen);

  @override
  List<Object> get props => [isGemstoneDetailsOpen];
}
