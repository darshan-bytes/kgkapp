import 'package:kgk/kgk.dart';

sealed class AddAccountState extends Equatable {
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

final class AddAccountReloadState extends AddAccountState {
  @override
  List<Object> get props => [];
}

final class AddAccountChangeCountryState extends AddAccountState {
  final Country selectedCountry;

  const AddAccountChangeCountryState(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}

final class AddAccountChangeCityState extends AddAccountState {
  final City selectedCity;

  const AddAccountChangeCityState(this.selectedCity);

  @override
  List<Object> get props => [selectedCity];
}

final class AddAccountChangeStateState extends AddAccountState {
  final StateModel selectedState;

  const AddAccountChangeStateState(this.selectedState);

  @override
  List<Object> get props => [selectedState];
}
