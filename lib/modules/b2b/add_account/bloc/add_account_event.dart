import 'package:kgk/kgk.dart';

abstract class AddAccountEvent extends Equatable {
  const AddAccountEvent();
}

final class AddAccountAddressChangeEvent extends AddAccountEvent {
  final bool isShippingAndBillingAddressFilled;

  const AddAccountAddressChangeEvent(this.isShippingAndBillingAddressFilled);

  @override
  List<Object> get props => [isShippingAndBillingAddressFilled];
}

final class AddAccountAddressSameEvent extends AddAccountEvent {
  final bool isShippingAddressSame;

  const AddAccountAddressSameEvent(this.isShippingAddressSame);

  @override
  List<Object> get props => [isShippingAddressSame];
}
