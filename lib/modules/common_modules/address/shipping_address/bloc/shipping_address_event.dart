part of 'shipping_address_bloc.dart';

sealed class ShippingAddressEvent extends Equatable {
  const ShippingAddressEvent();
}

final class ShippingAddressInitialEvent extends ShippingAddressEvent {
  final BuildContext context;

  const ShippingAddressInitialEvent(this.context);

  @override
  List<Object> get props => [];
}

final class ChangeSelectedShippingAddressEvent extends ShippingAddressEvent {
  final int index;

  const ChangeSelectedShippingAddressEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class EditShippingAddressEvent extends ShippingAddressEvent {
  final int index;
  final BuildContext context;

  const EditShippingAddressEvent(this.index, this.context);

  @override
  List<Object> get props => [index, context];
}

final class DeleteShippingAddressEvent extends ShippingAddressEvent {
  final int index;

  const DeleteShippingAddressEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class SaveShippingAddressEvent extends ShippingAddressEvent {
  final BuildContext context;

  const SaveShippingAddressEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class AddShippingAddressEvent extends ShippingAddressEvent {
  final BuildContext context;

  const AddShippingAddressEvent(this.context);

  @override
  List<Object> get props => [context];
}
