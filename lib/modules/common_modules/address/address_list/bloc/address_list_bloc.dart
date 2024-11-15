import 'package:kgk/kgk.dart';

part 'address_list_event.dart';

part 'address_list_state.dart';

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  AddressListBloc() : super(AddressListInitial()) {
    on<LoadAddressListEvent>(_onLoadAddressListEvent);
    on<ChangeSelectedAddressEvent>(_onChangeSelectedAddressEvent);
    on<DeleteAddressEvent>(_onDeleteAddressEvent);
    on<EditAddressEvent>(_onEditAddressEvent);
    on<AddNewAddressEvent>(_onAddNewAddressEvent);
    on<ToggleBillingAndShippingSameEvent>(_onToggleBillingAndShippingSameEvent);
    on<ChangeProductListExpansionEvent>(_onChangeProductListExpansionEvent);
  }

  GlobalKey<SmartExpansionTileState> productsListExpansionKey = GlobalKey();
  bool isProductListExpanded = false;

  AddressDetails? selectedAddress;
  List<AddressDetails> addressList = [
    AddressDetails(
      id: '1',
      firstName: "Gautam",
      lastName: "Singhania",
      phone: [
        CustomerPhoneNumber(
          phoneCode: "+91",
          phoneNumber: "8504279498",
        ),
      ],
      apartment: "123, ABC Colony",
      streetAddress: "Near XYZ Park",
      city: "Delhi",
      state: "Delhi",
      country: "India",
      zipCode: "110001",
      isDefaultShipping: true,
    ),
    AddressDetails(
      id: '2',
      firstName: "Rahul",
      lastName: "Sharma",
      phone: [
        CustomerPhoneNumber(
          phoneCode: "+91",
          phoneNumber: "8504279498",
        ),
      ],
      apartment: "123, ABC Colony",
      streetAddress: "Near XYZ Park",
      city: "Mumbai",
      state: "Maharashtra",
      country: "India",
      zipCode: "400001",
      isDefaultBilling: true,
    ),
  ];

  bool isBillingAndShippingSame = true;

  void _onLoadAddressListEvent(LoadAddressListEvent event, Emitter<AddressListState> emit) {
    selectedAddress = addressList.first;
    emit(AddressListLoadedState(addressList, selectedAddress!, isBillingAndShippingSame));
  }

  void _onChangeSelectedAddressEvent(ChangeSelectedAddressEvent event, Emitter<AddressListState> emit) {
    int oldIndex = addressList.indexOf(selectedAddress ?? AddressDetails());
    selectedAddress = addressList[event.index];
    emit(ChangeSelectedAddressState(event.index, oldIndex));
  }

  void _onDeleteAddressEvent(DeleteAddressEvent event, Emitter<AddressListState> emit) {
    emit(const AddressListReloadState());
    if (selectedAddress == addressList[event.index] && addressList.length > 1) {
      selectedAddress = addressList.first;
    }
    addressList.removeAt(event.index);
    emit(const DeleteAddressState());
  }

  Future<void> _onEditAddressEvent(EditAddressEvent event, Emitter<AddressListState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.addressId: addressList[event.index].id?.toString()});
  }

  Future<void> _onAddNewAddressEvent(AddNewAddressEvent event, Emitter<AddressListState> emit) async {
    final Map<RoutesData, dynamic>? result =
        await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.isFromCheckout: true});
    if (result != null && result.containsKey(RoutesData.addressDetails) && result[RoutesData.addressDetails] is AddressDetails) {
      AddressDetails addressDetails = result[RoutesData.addressDetails];
      addressList.add(addressDetails);
      selectedAddress = addressDetails;
      emit(AddNewAddressState(addressDetails));
    }
  }

  void _onToggleBillingAndShippingSameEvent(ToggleBillingAndShippingSameEvent event, Emitter<AddressListState> emit) {
    isBillingAndShippingSame = !isBillingAndShippingSame;
    emit(ToggleBillingAndShippingSameState(isBillingAndShippingSame));
  }

  void _onChangeProductListExpansionEvent(ChangeProductListExpansionEvent event, Emitter<AddressListState> emit) {
    isProductListExpanded = !isProductListExpanded;
    emit(ChangeProductListExpansionState(isProductListExpanded));
  }
}
