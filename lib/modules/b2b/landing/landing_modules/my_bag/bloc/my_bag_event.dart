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

  const MyBagRemoveProductEvent({required this.index});

  @override
  List<Object> get props => [index];
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
