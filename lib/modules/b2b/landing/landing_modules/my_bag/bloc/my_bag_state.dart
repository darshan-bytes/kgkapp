part of 'my_bag_bloc.dart';

sealed class MyBagState extends Equatable {
  const MyBagState();
}

final class MyBagInitial extends MyBagState {
  @override
  List<Object> get props => [];
}

final class MyBagReloadState extends MyBagState {
  const MyBagReloadState();

  @override
  List<Object> get props => [];
}

final class MyBagLoadedState extends MyBagState {
  const MyBagLoadedState();

  @override
  List<Object> get props => [];
}

final class MyBagProductQualityChangedState extends MyBagState {
  final int index;
  final CartProductQuality productQuality;

  const MyBagProductQualityChangedState({required this.index, required this.productQuality});

  @override
  List<Object> get props => [index, productQuality];
}

final class MyBagProductRemovedState extends MyBagState {
  final int index;

  const MyBagProductRemovedState({required this.index});

  @override
  List<Object> get props => [index];
}

final class MyBagSelectAllProductChangedState extends MyBagState {
  final bool selectAllProduct;

  const MyBagSelectAllProductChangedState({required this.selectAllProduct});

  @override
  List<Object> get props => [selectAllProduct];
}

final class MyBagSelectProductChangedState extends MyBagState {
  final int index;
  final bool isSelectedProduct;

  const MyBagSelectProductChangedState({required this.index, required this.isSelectedProduct});

  @override
  List<Object> get props => [index, isSelectedProduct];
}

final class ShowFullProductDetailsState extends MyBagState {
  @override
  List<Object> get props => [];
}

final class MyBagPaymentConditionChangedState extends MyBagState {
  final PaymentCondition paymentCondition;

  const MyBagPaymentConditionChangedState({required this.paymentCondition});

  @override
  List<Object> get props => [paymentCondition];
}

final class MyBagToggleViewModeState extends MyBagState {
  const MyBagToggleViewModeState();

  @override
  List<Object> get props => [];
}

final class MyBagSalesmanListLoadedState extends MyBagState {
  const MyBagSalesmanListLoadedState();

  @override
  List<Object> get props => [];
}

final class MyBagOrderSummaryDataLoadedState extends MyBagState {
  const MyBagOrderSummaryDataLoadedState();

  @override
  List<Object> get props => [];
}

final class MyBagCheckoutState extends MyBagState {
  const MyBagCheckoutState();

  @override
  List<Object> get props => [];
}

final class MyBagPaymentConditionsLoadedState extends MyBagState {
  const MyBagPaymentConditionsLoadedState();

  @override
  List<Object> get props => [];
}
