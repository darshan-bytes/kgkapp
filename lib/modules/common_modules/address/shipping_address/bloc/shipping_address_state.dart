part of 'shipping_address_bloc.dart';

sealed class ShippingAddressState extends Equatable {
  const ShippingAddressState();
}

final class ShippingAddressInitial extends ShippingAddressState {
  const ShippingAddressInitial();

  @override
  List<Object> get props => [];
}

final class ShippingAddressReloadState extends ShippingAddressState {
  const ShippingAddressReloadState();

  @override
  List<Object> get props => [];
}

final class ShippingAddressLoadedState extends ShippingAddressState {
  const ShippingAddressLoadedState();

  @override
  List<Object> get props => [];
}

final class ChangeSelectedShippingAddressState extends ShippingAddressState {
  final int oldIndex;
  final int newIndex;

  const ChangeSelectedShippingAddressState(this.oldIndex, this.newIndex);

  @override
  List<Object> get props => [oldIndex, newIndex];
}
