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
  final ProductDetailsModel productDetails;

  const ProductDetailsLoadedState(this.productDetails);

  @override
  List<Object> get props => [productDetails];
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

final class ProductDetailsSuggestedLoadedState extends ProductDetailsState {
  final List<ProductDetailsModel> suggestedProducts;

  const ProductDetailsSuggestedLoadedState(this.suggestedProducts);

  @override
  List<Object> get props => [suggestedProducts];
}

final class ReloadProductDetailsState extends ProductDetailsState {
  @override
  List<Object> get props => [];

  const ReloadProductDetailsState();
}

final class ProductDetailsRecentlyViewedLoadedState extends ProductDetailsState {
  const ProductDetailsRecentlyViewedLoadedState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsAuctionPlaceBidState extends ProductDetailsState {
  const ProductDetailsAuctionPlaceBidState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsAuctionTimerUpdateState extends ProductDetailsState {
  final Duration duration;

  const ProductDetailsAuctionTimerUpdateState(this.duration);

  @override
  List<Object> get props => [duration];
}

final class ProductDetailsAuctionTimerCompletedState extends ProductDetailsState {
  const ProductDetailsAuctionTimerCompletedState();

  @override
  List<Object> get props => [];
}

final class ProductDetailsAuctionLoadingState extends ProductDetailsState {
  @override
  List<Object> get props => [];
}

final class BidAmountFieldErrorState extends ProductDetailsState {
  final FieldTypeValidationEnum fieldType;

  const BidAmountFieldErrorState({required this.fieldType});

  @override
  List<Object> get props => [fieldType];
}
