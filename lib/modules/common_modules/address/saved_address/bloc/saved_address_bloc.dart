import 'package:kgk/kgk.dart';

part 'saved_address_event.dart';

part 'saved_address_state.dart';

class SavedAddressBloc extends Bloc<SavedAddressEvent, SavedAddressState> {
  bool _isInitialised = false;
  late AppBloc appBloc;
  List<AddressDetails> _addressList = [];

  List<AddressDetails> get shippingAddressList =>
      _addressList.where((e) => e.type == AppConst.addressTypeIsShipping || e.type == AppConst.both).toList();

  List<AddressDetails> get billingAddressList =>
      _addressList.where((e) => e.type == AppConst.addressTypeIsBilling || e.type == AppConst.both).toList();

  SavedAddressBloc() : super(const SavedAddressInitial()) {
    on<SavedAddressInitialEvent>(_onSavedAddressInitialEvent);
    //TODO: Need to modify the below data in future with the UI changes for allowing user to select the default address for shipping and billing
    // on<SavedAddressChangeBillingAddressSameEvent>(_onSavedAddressChangeBillingAddressSameEvent);
    on<SavedAddressChangeShippingAddressEvent>(_onSavedAddressChangeShippingAddressEvent);
    on<SavedAddressAddNewAddressEvent>(_onSavedAddressAddNewAddressEvent);
  }

  AddressDetails? get defaultShippingAddress =>
      shippingAddressList.firstWhereOrNull((element) => element.isDefaultShipping == true) ?? shippingAddressList.firstOrNull;

  AddressDetails? get defaultBillingAddress =>
      billingAddressList.firstWhereOrNull((element) => element.isDefaultBilling == true) ?? billingAddressList.firstOrNull;

  //TODO: Need to modify the below data in future with the UI changes for allowing user to select the default address for shipping and billing
  // bool get isBillingAddressSameAsShippingAddress => defaultBillingAddress == defaultShippingAddress;

  Future<void> _onSavedAddressInitialEvent(SavedAddressInitialEvent event, Emitter<SavedAddressState> emit) async {
    if (_isInitialised) return;
    appBloc = BlocProvider.of<AppBloc>(event.context);
    _addressList = await appBloc.fetchAddressList(event.context, isForceFetch: true);

    emit(const SavedAddressLoadedState());
    _isInitialised = true;
  }

  //TODO: Need to modify the below data in future with the UI changes for allowing user to select the default address for shipping and billing
  // Future<void> _onSavedAddressChangeBillingAddressSameEvent(
  //     SavedAddressChangeBillingAddressSameEvent event, Emitter<SavedAddressState> emit) async {
  //   //TODO: Handle on change billing address same as shipping address
  //   /// Api call to set billing address same as shipping address
  //
  //   // emit(const SavedAddressReloadState());
  //   await onSameAsShippingClickAPI(event.context);
  //   _isInitialised = false;
  //   add(SavedAddressInitialEvent(event.context));
  // }

  Future<void> _onSavedAddressChangeShippingAddressEvent(
    SavedAddressChangeShippingAddressEvent event,
    Emitter<SavedAddressState> emit,
  ) async {
    Map<RoutesData, dynamic>? result = await event.context.pushNamed(
      AppRoutes.shippingAddressPage,
      arguments: {RoutesData.isShippingAddress: event.isShipping},
    );
    if (result != null) {
      bool isEdited = result[RoutesData.isEdited] ?? false;
      AddressDetails? address = result[RoutesData.addressDetails] as AddressDetails?;
      if (address != null) {
        int index = _addressList.indexWhere((element) => element.id == address.id);
        if (index != -1) {
          _addressList[index] =
              event.isShipping
                  ? _addressList[index].copyWith(isShippingDefault: true)
                  : _addressList[index].copyWith(isBillingDefault: true);
          _isInitialised = false;
          add(SavedAddressInitialEvent(event.context));
        }
      } else if (isEdited) {
        _isInitialised = false;
        add(SavedAddressInitialEvent(event.context));
      }
    }
  }

  Future<void> _onSavedAddressAddNewAddressEvent(SavedAddressAddNewAddressEvent event, Emitter<SavedAddressState> emit) async {
    try {
      await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.isShippingAddress: event.isShipping}).then((value) {
        if (value != null && value[RoutesData.addressDetails] is AddressDetails) {
          _isInitialised = false;
          add(SavedAddressInitialEvent(event.context));
        }
      });
    } catch (e) {
      Utils.showMessage(e.toString());
    }
  }

  Future<bool> onSameAsShippingClickAPI(BuildContext context) async {
    final Map<String, dynamic> body = {
      ApiKey.id: defaultShippingAddress?.id,
      ApiKey.isDefaultBilling: true,
      ApiKey.isDefaultShipping: true,
    };

    final response = await AppRepository(context).updateAddress(defaultShippingAddress?.id ?? '', body: body);
    return response?.fold(
          (l) {
            Utils.showMessage(l.message);
            return false;
          },
          (CommonResponse r) {
            return true;
          },
        ) ??
        false;
  }
}
