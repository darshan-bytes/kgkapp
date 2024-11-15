import 'package:kgk/kgk.dart';

part 'saved_address_event.dart';

part 'saved_address_state.dart';

class SavedAddressBloc extends Bloc<SavedAddressEvent, SavedAddressState> {
  bool _isInitialised = false;
  late AppBloc appBloc;
  List<AddressDetails> addressList = [];

  SavedAddressBloc() : super(const SavedAddressInitial()) {
    on<SavedAddressInitialEvent>(
      _onSavedAddressInitialEvent,
    );
    on<SavedAddressChangeBillingAddressSameEvent>(_onSavedAddressChangeBillingAddressSameEvent);
    on<SavedAddressChangeShippingAddressEvent>(_onSavedAddressChangeShippingAddressEvent);
    on<SavedAddressAddNewAddressEvent>(_onSavedAddressAddNewAddressEvent);
  }

  AddressDetails? get defaultShippingAddress =>
      addressList.firstWhereOrNull((element) => element.isDefaultShipping == true) ?? addressList.firstOrNull;

  AddressDetails? get defaultBillingAddress =>
      addressList.firstWhereOrNull((element) => element.isDefaultBilling == true) ?? addressList.firstOrNull;

  bool get isBillingAddressSameAsShippingAddress => defaultBillingAddress == defaultShippingAddress;

  Future<void> _onSavedAddressInitialEvent(SavedAddressInitialEvent event, Emitter<SavedAddressState> emit) async {
    if (_isInitialised) return;
    appBloc = BlocProvider.of<AppBloc>(event.context);
    addressList = await appBloc.fetchAddressList(event.context, isForceFetch: true);

    emit(const SavedAddressLoadedState());
    _isInitialised = true;
  }

  void _onSavedAddressChangeBillingAddressSameEvent(SavedAddressChangeBillingAddressSameEvent event, Emitter<SavedAddressState> emit) {
    //TODO: Handle on change billing address same as shipping address
    /// Api call to set billing address same as shipping address
  }

  Future<void> _onSavedAddressChangeShippingAddressEvent(
      SavedAddressChangeShippingAddressEvent event, Emitter<SavedAddressState> emit) async {
    Map<RoutesData, dynamic>? result =
        await event.context.pushNamed(AppRoutes.shippingAddressPage, arguments: {RoutesData.isShippingAddress: event.isShipping});
    if (result != null) {
      //TODO: Handle changes
    }
  }

  Future<void> _onSavedAddressAddNewAddressEvent(SavedAddressAddNewAddressEvent event, Emitter<SavedAddressState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.isShippingAddress: event.isShipping});
  }
}
