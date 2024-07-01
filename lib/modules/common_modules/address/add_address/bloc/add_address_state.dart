part of 'add_address_bloc.dart';

sealed class AddAddressState extends Equatable {
  const AddAddressState();
}

final class AddAddressInitial extends AddAddressState {
  const AddAddressInitial();

  @override
  List<Object> get props => [];
}

final class AddAddressChangeAddressState extends AddAddressState {
  const AddAddressChangeAddressState();

  @override
  List<Object> get props => [];
}

final class AddAddressChangeAddressSameState extends AddAddressState {
  final bool isShippingAndBillingAddressSame;

  const AddAddressChangeAddressSameState(this.isShippingAndBillingAddressSame);

  @override
  List<Object> get props => [isShippingAndBillingAddressSame];
}

final class AddAddressReloadState extends AddAddressState {
  @override
  List<Object> get props => [];
}

final class AddAddressChangeCountryState extends AddAddressState {
  const AddAddressChangeCountryState();

  @override
  List<Object> get props => [];
}

final class AddAddressChangeCityState extends AddAddressState {
  final City selectedCity;

  const AddAddressChangeCityState(this.selectedCity);

  @override
  List<Object> get props => [selectedCity];
}

final class AddAddressChangeStateState extends AddAddressState {
  final StateModel selectedState;

  const AddAddressChangeStateState(this.selectedState);

  @override
  List<Object> get props => [selectedState];
}

final class AddAddressChangeCountryCodeState extends AddAddressState {
  const AddAddressChangeCountryCodeState();

  @override
  List<Object> get props => [];
}
