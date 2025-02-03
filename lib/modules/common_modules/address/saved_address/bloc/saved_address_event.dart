part of 'saved_address_bloc.dart';

sealed class SavedAddressEvent extends Equatable {
  const SavedAddressEvent();
}

final class SavedAddressInitialEvent extends SavedAddressEvent {
  final BuildContext context;

  const SavedAddressInitialEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class SavedAddressChangeBillingAddressSameEvent extends SavedAddressEvent {
  final bool value;
  final BuildContext context;

  const SavedAddressChangeBillingAddressSameEvent({
    required this.context,
    required this.value,
  });

  @override
  List<Object> get props => [
        context,
        value,
      ];
}

final class SavedAddressChangeShippingAddressEvent extends SavedAddressEvent {
  final bool isShipping;
  final BuildContext context;

  const SavedAddressChangeShippingAddressEvent(this.context, {this.isShipping = false});

  @override
  List<Object> get props => [];
}

final class SavedAddressAddNewAddressEvent extends SavedAddressEvent {
  final BuildContext context;
  final bool isShipping;

  const SavedAddressAddNewAddressEvent(this.context, {this.isShipping = false});

  @override
  List<Object> get props => [context, isShipping];
}
