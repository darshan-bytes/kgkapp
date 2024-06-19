import 'package:kgk/kgk.dart';

import '../model/shipping_address_model.dart';

sealed class ShippingAddressState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

final class InitialState extends ShippingAddressState {}

final class NoDataState extends ShippingAddressState {
  late final String message;

  NoDataState(this.message);

  @override
  List<Object> get props => [message];
}

final class LoadedState extends ShippingAddressState {
  late final List<ShippingAddressModel> data;

  LoadedState(this.data);

  @override
  List<Object> get props => [data];
}

final class ShippingAddressRemoveState extends ShippingAddressState {
  late final int index;

  @override
  List<Object> get props => [index];
}
