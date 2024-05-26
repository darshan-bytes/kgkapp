import 'package:kgk/kgk.dart';

abstract class AddAccountState extends Equatable {
  const AddAccountState();
}

final class AddAccountInitial extends AddAccountState {
  const AddAccountInitial();

  @override
  List<Object> get props => [];
}

final class AddAccountChangeAddressState extends AddAccountState {
  final bool isShippingAndBillingAddressFilled;

  const AddAccountChangeAddressState(this.isShippingAndBillingAddressFilled);

  @override
  List<Object> get props => [isShippingAndBillingAddressFilled];
}

final class AddAccountChangeAddressSameState extends AddAccountState {
  final bool isShippingAndBillingAddressSame;

  const AddAccountChangeAddressSameState(this.isShippingAndBillingAddressSame);

  @override
  List<Object> get props => [isShippingAndBillingAddressSame];
}

final class AddAccountRecordState extends AddAccountState {
  @override
  List<Object> get props => [];
}
