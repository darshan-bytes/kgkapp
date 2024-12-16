part of 'address_list_bloc.dart';

sealed class AddressListState extends Equatable {
  const AddressListState();
}

final class AddressListInitial extends AddressListState {
  @override
  List<Object> get props => [];
}

final class AddressListLoadedState extends AddressListState {
  final List<AddressDetails> addressList;
  final AddressDetails selectedShippingAddress;
  final AddressDetails selectedBillingAddress;
  final bool isBillingAndShippingSame;

  const AddressListLoadedState(
    this.addressList,
    this.selectedShippingAddress,
    this.selectedBillingAddress,
    this.isBillingAndShippingSame,
  );

  @override
  List<Object> get props => [addressList, selectedShippingAddress, selectedBillingAddress, isBillingAndShippingSame];
}

final class AddressListReloadState extends AddressListState {
  const AddressListReloadState();

  @override
  List<Object> get props => [];
}

final class ChangeSelectedAddressState extends AddressListState {
  final int index;
  final int oldIndex;

  final bool isBilling;

  const ChangeSelectedAddressState(this.index, this.oldIndex, {this.isBilling = false});

  @override
  List<Object> get props => [index, oldIndex];
}

final class EditAddressState extends AddressListState {
  final int index;

  const EditAddressState(this.index);

  @override
  List<Object> get props => [index];
}

final class DeleteAddressState extends AddressListState {
  const DeleteAddressState();

  @override
  List<Object> get props => [];
}

final class ToggleBillingAndShippingSameState extends AddressListState {
  final bool isBillingAndShippingSame;

  const ToggleBillingAndShippingSameState(this.isBillingAndShippingSame);

  @override
  List<Object> get props => [isBillingAndShippingSame];
}

final class ChangeProductListExpansionState extends AddressListState {
  final bool isProductListExpanded;

  const ChangeProductListExpansionState(this.isProductListExpanded);

  @override
  List<Object> get props => [isProductListExpanded];
}

final class AddNewAddressState extends AddressListState {
  final AddressDetails selectedAddress;

  const AddNewAddressState(this.selectedAddress);

  @override
  List<Object> get props => [selectedAddress];
}
