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

  late AppBloc appBloc;

  GlobalKey<SmartExpansionTileState> productsListExpansionKey = GlobalKey();

  bool isProductListExpanded = false;

  AddressDetails? selectedAddress;
  List<AddressDetails> addressList = [];

  bool isBillingAndShippingSame = true;

  Future<void> _onLoadAddressListEvent(LoadAddressListEvent event, Emitter<AddressListState> emit) async {
    appBloc = BlocProvider.of<AppBloc>(event.context);
    await appBloc.fetchAddressList(event.context);
    addressList = appBloc.savedAddressList;
    selectedAddress = addressList.firstWhereOrNull((element) => element.isDefaultBilling) ?? addressList.firstOrNull;
    if (selectedAddress != null) {
      emit(AddressListLoadedState(addressList, selectedAddress!, isBillingAndShippingSame));
    }
  }

  void _onChangeSelectedAddressEvent(ChangeSelectedAddressEvent event, Emitter<AddressListState> emit) {
    int oldIndex = addressList.indexOf(selectedAddress ?? AddressDetails());
    selectedAddress = addressList[event.index];
    emit(ChangeSelectedAddressState(event.index, oldIndex));
  }

  Future<void> _onDeleteAddressEvent(DeleteAddressEvent event, Emitter<AddressListState> emit) async {
    emit(const AddressListReloadState());

    AddressDetails address = addressList[event.index];

    final response = await AppRepository(event.context).deleteAddress(address.id ?? '');
    response?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) {
        if (selectedAddress == address && addressList.length > 1 && event.index != 0) {
          selectedAddress = addressList.first;
        }
        addressList.removeAt(event.index);
        emit(AddressListLoadedState(addressList, selectedAddress!, isBillingAndShippingSame));
      },
    );

    emit(const DeleteAddressState());
  }

  Future<void> _onEditAddressEvent(EditAddressEvent event, Emitter<AddressListState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.addressDetails: addressList[event.index]}).then(
      (value) {
        if (value != null) {
          try {
            AddressDetails? addressDetails = value[RoutesData.addressDetails];

            if (addressDetails != null) {
              addressList[event.index] = addressDetails;
            }
            selectedAddress = addressList[event.index];
            emit(AddressListLoadedState(addressList, selectedAddress!, isBillingAndShippingSame));
          } catch (e) {
            printWrapped('Error in updating address: $e');
          }
        }
      },
    );
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
