part of 'product_details_bloc.dart';

sealed class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
}

final class LoadProductDetailsEvent extends ProductDetailsEvent {
  final BuildContext context;

  const LoadProductDetailsEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ToggleCompareProductEvent extends ProductDetailsEvent {
  final bool? isCompare;
  final BuildContext? context;

  const ToggleCompareProductEvent({this.context, this.isCompare});

  @override
  List<Object?> get props => [context, isCompare];

  @override
  String toString() {
    return 'ToggleCompareProductEvent{isCompare: $isCompare, context: $context}';
  }
}

final class ProductCustomizationChangeEvent extends ProductDetailsEvent {
  final int index;
  final int childIndex;

  const ProductCustomizationChangeEvent({
    required this.index,
    required this.childIndex,
  });

  @override
  List<Object> get props => [index, childIndex];
}

final class RingDetailsToggleEvent extends ProductDetailsEvent {
  const RingDetailsToggleEvent();

  @override
  List<Object> get props => [];
}

final class ProductDiamondDetailsToggleEvent extends ProductDetailsEvent {
  const ProductDiamondDetailsToggleEvent();

  @override
  List<Object> get props => [];
}

final class GemstoneDetailsToggleEvent extends ProductDetailsEvent {
  const GemstoneDetailsToggleEvent();

  @override
  List<Object> get props => [];
}

final class ProductDetailsSuggestedLoadedEvent extends ProductDetailsEvent {
  const ProductDetailsSuggestedLoadedEvent();

  @override
  List<Object> get props => [];
}

final class ProductDetailsReviewsLoadedEvent extends ProductDetailsEvent {
  const ProductDetailsReviewsLoadedEvent();

  @override
  List<Object> get props => [];
}

final class ProductDetailsWriteReviewEvent extends ProductDetailsEvent {
  final BuildContext context;

  const ProductDetailsWriteReviewEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ProductDetailsAuctionStartTimerEvent extends ProductDetailsEvent {
  const ProductDetailsAuctionStartTimerEvent();

  @override
  List<Object> get props => [];
}

final class ProductDetailsAuctionTimerCompletedEvent extends ProductDetailsEvent {
  const ProductDetailsAuctionTimerCompletedEvent();

  @override
  List<Object> get props => [];
}

final class ProductDetailsAuctionUpdateTimerEvent extends ProductDetailsEvent {
  final Duration duration;

  const ProductDetailsAuctionUpdateTimerEvent(this.duration);

  @override
  List<Object> get props => [duration];
}

final class ProductDetailsAuctionPlaceBidEvent extends ProductDetailsEvent {
  final BuildContext context;
  final String amount;

  const ProductDetailsAuctionPlaceBidEvent(this.context, this.amount);

  @override
  List<Object> get props => [context, amount];
}

final class ProductDetailsPlaceBidFieldChangeEvent extends ProductDetailsEvent {
  final FieldTypeValidationEnum fieldType;

  const ProductDetailsPlaceBidFieldChangeEvent({required this.fieldType});

  @override
  List<Object> get props => [fieldType];
}
