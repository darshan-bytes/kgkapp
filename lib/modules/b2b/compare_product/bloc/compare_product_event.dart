part of 'compare_product_bloc.dart';

sealed class CompareProductEvent extends Equatable {
  const CompareProductEvent();
}

final class CompareProductAddProductEvent extends CompareProductEvent {
  final ProductDetailsModel product;
  final BuildContext context;

  final VoidCallback? onProductAdded;

  const CompareProductAddProductEvent({required this.context, required this.product, this.onProductAdded});

  @override
  List<Object?> get props => [
        context,
        product,
        onProductAdded,
      ];
}

final class CompareProductRemoveProductEvent extends CompareProductEvent {
  final String productId;
  final bool isFromCompareScreen;
  final BuildContext context;

  const CompareProductRemoveProductEvent({
    required this.context,
    required this.productId,
    this.isFromCompareScreen = false,
  });

  @override
  List<Object> get props => [
        context,
        productId,
        isFromCompareScreen,
      ];
}

final class CompareProductClearEvent extends CompareProductEvent {
  const CompareProductClearEvent();

  @override
  List<Object> get props => [];
}

final class CompareProductGenerateTableEvent extends CompareProductEvent {
  final BuildContext context;

  const CompareProductGenerateTableEvent({required this.context});

  @override
  List<Object> get props => [context];
}
