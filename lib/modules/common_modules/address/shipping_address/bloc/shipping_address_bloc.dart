import 'package:kgk/kgk.dart';

part 'shipping_address_event.dart';

part 'shipping_address_state.dart';

class ShippingAddressBloc extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  late AppBloc appBloc;
  List<AddressDetails> addressList = [];
  AddressDetails? selectedAddress;
  String title = '';

  bool isShipping = false;

  bool canPop = false;
  bool isEdit = false;

  AddressDetails? get defaultAddress =>
      addressList.firstWhereOrNull((element) => (isShipping ? element.isDefaultShipping : element.isDefaultBilling));

  ShippingAddressBloc() : super(const ShippingAddressInitial()) {
    on<ShippingAddressInitialEvent>(_onShippingAddressInitialEvent);
    on<ChangeSelectedShippingAddressEvent>(_onChangeSelectedShippingAddressEvent);
    on<EditShippingAddressEvent>(_onEditShippingAddressEvent);
    on<DeleteShippingAddressEvent>(_onDeleteShippingAddressEvent);
    on<SaveShippingAddressEvent>(_onSaveShippingAddressEvent);
    on<AddShippingAddressEvent>(_onAddShippingAddressEvent);
  }

  Future<void> _onShippingAddressInitialEvent(ShippingAddressInitialEvent event, Emitter<ShippingAddressState> emit) async {
    emit(const ShippingAddressReloadState());
    appBloc = BlocProvider.of<AppBloc>(event.context);
    isShipping = event.context.routesData?[RoutesData.isShippingAddress] ?? false;
    title = (isShipping ? APPStrings.shippingAddress : APPStrings.billingAddress).tr;
    addressList =
        (await appBloc.fetchAddressList(event.context)).where((e) => isShipping ? e.isShippingAddress : e.isBillingAddress).toList();
    selectedAddress = addressList.firstWhereOrNull((element) => (isShipping ? element.isDefaultShipping : element.isDefaultBilling)) ??
        addressList.firstOrNull;
    emit(const ShippingAddressLoadedState());
  }

  void _onChangeSelectedShippingAddressEvent(ChangeSelectedShippingAddressEvent event, Emitter<ShippingAddressState> emit) {
    emit(const ShippingAddressReloadState());
    int oldIndex = addressList.indexOf(selectedAddress ?? AddressDetails());
    selectedAddress = addressList[event.index];
    emit(ChangeSelectedShippingAddressState(oldIndex, event.index));
  }

  Future<void> _onEditShippingAddressEvent(EditShippingAddressEvent event, Emitter<ShippingAddressState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage,
        arguments: {RoutesData.addressDetails: addressList[event.index], RoutesData.isShippingAddress: isShipping}).then(
      (value) {
        if (value != null) {
          try {
            selectedAddress = value[RoutesData.addressDetails];
            if (selectedAddress != null) {
              addressList[event.index] = selectedAddress!;
              isEdit = true;
            }
            emit(const ShippingAddressLoadedState());
          } catch (e) {
            debugPrint(e.toString());
          }
        }
      },
    );
  }

  Future<void> _onDeleteShippingAddressEvent(DeleteShippingAddressEvent event, Emitter<ShippingAddressState> emit) async {
    final response = await AppRepository(event.context).deleteAddress(addressList[event.index].id ?? '');
    response?.fold((l) {
      Utils.showMessage(l.message);
    }, (r) {
      AddressDetails address = addressList[event.index];
      addressList.removeAt(event.index);
      appBloc.savedAddressList.remove(address);
      emit(const ShippingAddressLoadedState());
    });
  }

  Future<void> _onSaveShippingAddressEvent(SaveShippingAddressEvent event, Emitter<ShippingAddressState> emit) async {
    if (selectedAddress == null) return;
    Map<String, dynamic> body = {};
    body = {
      isShipping ? ApiKey.isDefaultShipping : ApiKey.isDefaultBilling: true,
    };
    bool isSuccess = await _saveAddress(event.context, body: body, addressId: selectedAddress!.id ?? '');
    if (isSuccess) {
      selectedAddress = isShipping ? selectedAddress!.copyWith(isShippingDefault: true) : selectedAddress!.copyWith(isBillingDefault: true);
      await event.context.pop(arguments: {RoutesData.addressDetails: selectedAddress, RoutesData.isShippingAddress: isShipping});
    }
  }

  Future<void> _onAddShippingAddressEvent(AddShippingAddressEvent event, Emitter<ShippingAddressState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.isShippingAddress: isShipping}).then(
      (value) {
        if (value != null && value[RoutesData.addressDetails] is AddressDetails) {
          appBloc.savedAddressList.add(value[RoutesData.addressDetails]);
          emit(const ShippingAddressLoadedState());
        }
      },
    );
  }

  Future<bool> _saveAddress(BuildContext context, {required String addressId, required Map<String, dynamic> body}) async {
    bool result = false;
    if (addressId.isNotEmpty) {
      try {
        final response = await AppRepository(context).updateAddress(addressId, body: body);
        response?.fold((l) {}, (r) {
          result = true;
        });
      } catch (e) {
        result = false;
      }
    }
    return result;
  }

  void popWithData(BuildContext context) {
    canPop = true;
    context.pop(arguments: {RoutesData.isEdited: isEdit});
  }
}
