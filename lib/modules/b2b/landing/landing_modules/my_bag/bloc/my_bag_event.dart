part of 'my_bag_bloc.dart';

sealed class MyBagEvent extends Equatable {
  const MyBagEvent();
}

final class InitialMyBagEvent extends MyBagEvent {
  final BuildContext context;

  const InitialMyBagEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class MyBagChangeProductQuality extends MyBagEvent {
  final int index;
  final CartProductQuality productQuality;

  const MyBagChangeProductQuality({required this.index, required this.productQuality});

  @override
  List<Object> get props => [index, productQuality];
}

final class MyBagChangeProductQuantity extends MyBagEvent {
  final int index;
  final CartProductQuantity productQuantity;

  const MyBagChangeProductQuantity({required this.index, required this.productQuantity});

  @override
  List<Object> get props => [index, productQuantity];
}

final class MyBagRemoveProductEvent extends MyBagEvent {
  final int index;
  final BuildContext context;

  const MyBagRemoveProductEvent({required this.index, required this.context});

  @override
  List<Object> get props => [index, context];
}

final class MyBagSelectAllProductChangedEvent extends MyBagEvent {
  final bool selectAllProduct;

  const MyBagSelectAllProductChangedEvent({required this.selectAllProduct});

  @override
  List<Object> get props => [selectAllProduct];
}

final class MyBagSelectProductChangedEvent extends MyBagEvent {
  final int index;

  const MyBagSelectProductChangedEvent({required this.index});

  @override
  List<Object> get props => [index];
}

final class ShowFullProductDetailsEvent extends MyBagEvent {
  const ShowFullProductDetailsEvent();

  @override
  List<Object> get props => [];
}

final class MyBagPaymentConditionChangedEvent extends MyBagEvent {
  final PaymentCondition paymentCondition;

  const MyBagPaymentConditionChangedEvent({required this.paymentCondition});

  @override
  List<Object> get props => [paymentCondition];
}

final class MyBagToggleReadMoreDetailsEvent extends MyBagEvent {
  const MyBagToggleReadMoreDetailsEvent();

  @override
  List<Object> get props => [];
}

final class MyBagToggleViewModeEvent extends MyBagEvent {
  final int index;

  const MyBagToggleViewModeEvent({required this.index});

  @override
  List<Object> get props => [index];
}

final class MyBagMoveToWishListEvent extends MyBagEvent {
  final int index;
  final BuildContext context;

  const MyBagMoveToWishListEvent({required this.index, required this.context});

  @override
  List<Object> get props => [index, context];
}

final class MyBagRemovePromoCodeEvent extends MyBagEvent {
  final BuildContext context;

  const MyBagRemovePromoCodeEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class MyBagApplyPromoCodeEvent extends MyBagEvent {
  final String promoCode;
  final BuildContext context;

  const MyBagApplyPromoCodeEvent({required this.promoCode, required this.context});

  @override
  List<Object> get props => [promoCode, context];
}

final class MyBagCheckoutEvent extends MyBagEvent {
  final BuildContext context;

  const MyBagCheckoutEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class MyBagProductQuantityChangedEvent extends MyBagEvent {
  final BuildContext context;
  final int index;
  final int quantity;

  const MyBagProductQuantityChangedEvent({required this.context, required this.index, required this.quantity});

  @override
  List<Object> get props => [context, index, quantity];
}

final class ClearMyBagEvent extends MyBagEvent {
  final BuildContext context;

  const ClearMyBagEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class MyBagYourDiscountChangedEvent extends MyBagEvent {
  final BuildContext context;
  final int index;
  final String yourDiscount;

  const MyBagYourDiscountChangedEvent({required this.context, required this.index, required this.yourDiscount});

  @override
  List<Object> get props => [context, index, yourDiscount];
}

final class FetchOrderSummaryDataEvent extends MyBagEvent {
  final BuildContext context;

  const FetchOrderSummaryDataEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class MyBagRemoveAllProductEvent extends MyBagEvent {
  final BuildContext context;

  const MyBagRemoveAllProductEvent({required this.context});

  @override
  List<Object> get props => [context];
}
