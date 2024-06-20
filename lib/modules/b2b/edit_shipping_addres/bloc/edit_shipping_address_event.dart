part of 'edit_shipping_address_bloc.dart';

sealed class EditShippingAddressEvent extends Equatable {
  const EditShippingAddressEvent();
}

final class EditShippingAddressChangeEvent extends EditShippingAddressEvent {
  const EditShippingAddressChangeEvent();

  @override
  List<Object> get props => [];
}

final class EditShippingAddressAddressSameEvent extends EditShippingAddressEvent {
  final bool isShippingAddressSame;

  const EditShippingAddressAddressSameEvent(this.isShippingAddressSame);

  @override
  List<Object> get props => [isShippingAddressSame];
}

final class EditShippingAddressChangeCountryEvent extends EditShippingAddressEvent {
  final Country selectedCountry;

  const EditShippingAddressChangeCountryEvent(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}

final class EditShippingAddressChangeCityEvent extends EditShippingAddressEvent {
  final City selectedCity;

  const EditShippingAddressChangeCityEvent(this.selectedCity);

  @override
  List<Object> get props => [selectedCity];
}

final class EditShippingAddressChangeStateEvent extends EditShippingAddressEvent {
  final StateModel selectedState;

  const EditShippingAddressChangeStateEvent(this.selectedState);

  @override
  List<Object> get props => [selectedState];
}

final class SaveEditShippingAddressEvent extends EditShippingAddressEvent {
  final BuildContext context;

  const SaveEditShippingAddressEvent(this.context);

  @override
  List<Object> get props => [context];
}
