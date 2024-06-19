part of 'edit_shipping_address_bloc.dart';

sealed class EditShippingAddressState extends Equatable {
  const EditShippingAddressState();
}

final class EditShippingAddressInitial extends EditShippingAddressState {
  const EditShippingAddressInitial();

  @override
  List<Object> get props => [];
}

final class EditShippingAddressChangeAddressState extends EditShippingAddressState {
  const EditShippingAddressChangeAddressState();

  @override
  List<Object> get props => [];
}

final class EditShippingAddressChangeAddressSameState extends EditShippingAddressState {
  final bool isShippingAndBillingAddressSame;

  const EditShippingAddressChangeAddressSameState(this.isShippingAndBillingAddressSame);

  @override
  List<Object> get props => [isShippingAndBillingAddressSame];
}

final class EditShippingAddressReloadState extends EditShippingAddressState {
  @override
  List<Object> get props => [];
}

final class EditShippingAddressChangeCountryState extends EditShippingAddressState {
  final Country selectedCountry;

  const EditShippingAddressChangeCountryState(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}

final class EditShippingAddressChangeCityState extends EditShippingAddressState {
  final City selectedCity;

  const EditShippingAddressChangeCityState(this.selectedCity);

  @override
  List<Object> get props => [selectedCity];
}

final class EditShippingAddressChangeStateState extends EditShippingAddressState {
  final StateModel selectedState;

  const EditShippingAddressChangeStateState(this.selectedState);

  @override
  List<Object> get props => [selectedState];
}
