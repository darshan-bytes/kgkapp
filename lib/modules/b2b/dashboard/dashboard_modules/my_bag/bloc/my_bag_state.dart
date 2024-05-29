part of 'my_bag_bloc.dart';

sealed class MyBagState extends Equatable {
  const MyBagState();
}

final class MyBagInitial extends MyBagState {
  @override
  List<Object> get props => [];
}

final class MyBagReloadState extends MyBagState {
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

final class MyBagProductQuantityChangedState extends MyBagState {
  final int index;
  final CartProductQuantity productQuantity;

  const MyBagProductQuantityChangedState({required this.index, required this.productQuantity});

  @override
  List<Object> get props => [index, productQuantity];
}

final class MyBagProductRemovedState extends MyBagState {
  final int index;
  final ProductDetails productDetails;

  const MyBagProductRemovedState({required this.index, required this.productDetails});

  @override
  List<Object> get props => [index, productDetails];
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
