import 'package:kgk/kgk.dart';

sealed class AddAccountEvent extends Equatable {
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

final class AddAccountChangeCountryEvent extends AddAccountEvent {
  final Country selectedCountry;

  const AddAccountChangeCountryEvent(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}

final class AddAccountChangeCityEvent extends AddAccountEvent {
  final City selectedCity;

  const AddAccountChangeCityEvent(this.selectedCity);

  @override
  List<Object> get props => [selectedCity];
}

final class AddAccountChangeStateEvent extends AddAccountEvent {
  final StateModel selectedState;

  const AddAccountChangeStateEvent(this.selectedState);

  @override
  List<Object> get props => [selectedState];
}
