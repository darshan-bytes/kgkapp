part of 'saved_address_bloc.dart';

sealed class SavedAddressEvent extends Equatable {
  const SavedAddressEvent();
}

final class SavedAddressInitialEvent extends SavedAddressEvent {
  const SavedAddressInitialEvent();

  @override
  List<Object> get props => [];
}

final class SavedAddressChangeBillingAddressSameEvent extends SavedAddressEvent {
  final bool value;

  const SavedAddressChangeBillingAddressSameEvent(this.value);

  @override
  List<Object> get props => [value];
}
