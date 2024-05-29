part of 'my_bag_bloc.dart';

sealed class MyBagEvent extends Equatable {
  const MyBagEvent();
}

final class InitialMyBagEvent extends MyBagEvent {
  @override
  List<Object> get props => [];
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

final class MyBagRemoveProduct extends MyBagEvent {
  final int index;
  final ProductDetails productDetails;

  const MyBagRemoveProduct({required this.index, required this.productDetails});

  @override
  List<Object> get props => [index, productDetails];
}

final class MyBagSelectAllProductChangedEvent extends MyBagEvent {
  final bool selectAllProduct;

  const MyBagSelectAllProductChangedEvent({required this.selectAllProduct});

  @override
  List<Object> get props => [selectAllProduct];
}

final class MyBagSelectProductChangedEvent extends MyBagEvent {
  final int index;
  final bool isSelectedProduct;

  const MyBagSelectProductChangedEvent({required this.index, required this.isSelectedProduct});

  @override
  List<Object> get props => [index, isSelectedProduct];
}
