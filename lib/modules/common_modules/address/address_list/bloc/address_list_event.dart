part of 'address_list_bloc.dart';

sealed class AddressListEvent extends Equatable {
  const AddressListEvent();
}

final class LoadAddressListEvent extends AddressListEvent {
  final BuildContext context;

  const LoadAddressListEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ChangeSelectedAddressEvent extends AddressListEvent {
  final int index;
  final bool isBilling;

  const ChangeSelectedAddressEvent(this.index, {this.isBilling = false});

  @override
  List<Object> get props => [index, isBilling];
}

final class DeleteAddressEvent extends AddressListEvent {
  final BuildContext context;
  final int index;

  const DeleteAddressEvent({required this.context, required this.index});

  @override
  List<Object> get props => [context, index];
}

final class EditAddressEvent extends AddressListEvent {
  final int index;
  final BuildContext context;

  const EditAddressEvent(this.index, this.context);

  @override
  List<Object> get props => [index, context];
}

final class AddNewAddressEvent extends AddressListEvent {
  final BuildContext context;

  const AddNewAddressEvent(this.context);

  @override
  List<Object> get props => [context];
}

final class ToggleBillingAndShippingSameEvent extends AddressListEvent {
  const ToggleBillingAndShippingSameEvent();

  @override
  List<Object> get props => [];
}

final class ChangeProductListExpansionEvent extends AddressListEvent {
  const ChangeProductListExpansionEvent();

  @override
  List<Object> get props => [];
}

final class ContinueToPaymentEvent extends AddressListEvent {
  final BuildContext context;

  const ContinueToPaymentEvent({required this.context});

  @override
  List<Object> get props => [context];
}

final class OrderSummaryDataRefreshEvent extends AddressListEvent {
  final BuildContext context;
  const OrderSummaryDataRefreshEvent({required this.context});

  @override
  List<Object> get props => [];
}
