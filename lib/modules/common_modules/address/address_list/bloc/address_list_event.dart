part of 'address_list_bloc.dart';

sealed class AddressListEvent extends Equatable {
  const AddressListEvent();
}

final class LoadAddressListEvent extends AddressListEvent {
  const LoadAddressListEvent();

  @override
  List<Object> get props => [];
}

final class ChangeSelectedAddressEvent extends AddressListEvent {
  final int index;

  const ChangeSelectedAddressEvent(this.index);

  @override
  List<Object> get props => [index];
}

final class DeleteAddressEvent extends AddressListEvent {
  final int index;

  const DeleteAddressEvent(this.index);

  @override
  List<Object> get props => [index];
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
