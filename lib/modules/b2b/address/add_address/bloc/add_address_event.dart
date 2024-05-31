part of 'add_address_bloc.dart';

sealed class AddAddressEvent extends Equatable {
  const AddAddressEvent();
}

final class AddAddressAddressChangeEvent extends AddAddressEvent {
  const AddAddressAddressChangeEvent();

  @override
  List<Object> get props => [];
}

final class AddAddressAddressSameEvent extends AddAddressEvent {
  final bool isShippingAddressSame;

  const AddAddressAddressSameEvent(this.isShippingAddressSame);

  @override
  List<Object> get props => [isShippingAddressSame];
}

final class AddAddressChangeCountryEvent extends AddAddressEvent {
  final Country selectedCountry;

  const AddAddressChangeCountryEvent(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}

final class AddAddressChangeCityEvent extends AddAddressEvent {
  final City selectedCity;

  const AddAddressChangeCityEvent(this.selectedCity);

  @override
  List<Object> get props => [selectedCity];
}

final class AddAddressChangeStateEvent extends AddAddressEvent {
  final StateModel selectedState;

  const AddAddressChangeStateEvent(this.selectedState);

  @override
  List<Object> get props => [selectedState];
}

final class SaveAddressEvent extends AddAddressEvent {
  final BuildContext context;

  const SaveAddressEvent(this.context);

  @override
  List<Object> get props => [context];
}
