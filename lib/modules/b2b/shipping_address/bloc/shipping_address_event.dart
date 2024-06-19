import 'package:kgk/modules/b2b/shipping_address/model/shipping_address_model.dart';

import '../../../../kgk.dart';

sealed class ShippingAddressEvent extends Equatable {
  const ShippingAddressEvent();

  @override
  List<Object?> get props => [];
}

final class ShippingAddressInitialEvent extends ShippingAddressEvent {
  final BuildContext context;

  const ShippingAddressInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ShippingAddressLoadedEvent extends ShippingAddressEvent {}

final class ShippingAddressEditEvent extends ShippingAddressEvent {}

final class ShippingAddressDeleteAddressEvent extends ShippingAddressEvent {
  final ShippingAddressModel address;

  const ShippingAddressDeleteAddressEvent(this.address);

  @override
  List<Object> get props => [address];
}

final class SelectShippingAddressEvent extends ShippingAddressEvent {
  final int id;

  const SelectShippingAddressEvent(this.id);

  @override
  List<Object> get props => [id];
}

final class ShippingNoData extends ShippingAddressEvent {
  final String message;

  const ShippingNoData(this.message);

  @override
  List<Object> get props => [message];
}
