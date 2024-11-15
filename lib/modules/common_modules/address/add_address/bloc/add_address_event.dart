part of 'add_address_bloc.dart';

sealed class AddAddressEvent extends Equatable {
  const AddAddressEvent();
}

final class AddAddressInitialEvent extends AddAddressEvent {
  final BuildContext context;

  const AddAddressInitialEvent(this.context);

  @override
  List<Object> get props => [context];
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
  final BuildContext context;
  final Country selectedCountry;

  const AddAddressChangeCountryEvent({
    required this.context,
    required this.selectedCountry,
  });

  @override
  List<Object> get props => [context, selectedCountry];
}

final class AddAddressChangeStateEvent extends AddAddressEvent {
  final BuildContext context;
  final CountryStateModel selectedState;

  const AddAddressChangeStateEvent(this.context, this.selectedState);

  @override
  List<Object> get props => [context, selectedState];
}

final class SaveAddressEvent extends AddAddressEvent {
  final BuildContext context;

  const SaveAddressEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class AddAddressChangeCountryCodeEvent extends AddAddressEvent {
  final Country selectedCountry;

  const AddAddressChangeCountryCodeEvent(this.selectedCountry);

  @override
  List<Object> get props => [selectedCountry];
}
