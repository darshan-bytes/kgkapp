import 'package:kgk/kgk.dart';

part 'shipping_address_event.dart';

part 'shipping_address_state.dart';

class ShippingAddressBloc extends Bloc<ShippingAddressEvent, ShippingAddressState> {
  late AppBloc appBloc;
  List<AddressDetails> addressList = [];
  AddressDetails? selectedAddress;
  String title = '';

  bool isShipping = false;

  AddressDetails? get defaultAddress =>
      addressList.firstWhereOrNull((element) => (isShipping ? element.isDefaultShipping : element.isDefaultBilling) ?? false);

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
    addressList = await appBloc.fetchAddressList(event.context);
    selectedAddress =
        addressList.firstWhereOrNull((element) => (isShipping ? element.isDefaultShipping : element.isDefaultBilling) ?? false) ??
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
        arguments: {RoutesData.addressId: selectedAddress?.id?.toString(), RoutesData.isShippingAddress: isShipping});
  }

  void _onDeleteShippingAddressEvent(DeleteShippingAddressEvent event, Emitter<ShippingAddressState> emit) {
    //TODO: Implement Delete Shipping Address
  }

  Future<void> _onSaveShippingAddressEvent(SaveShippingAddressEvent event, Emitter<ShippingAddressState> emit) async {
    await event.context.pop(arguments: {RoutesData.addressDetails: selectedAddress, RoutesData.isShippingAddress: isShipping});
  }

  Future<void> _onAddShippingAddressEvent(AddShippingAddressEvent event, Emitter<ShippingAddressState> emit) async {
    await event.context.pushNamed(AppRoutes.addAddressPage, arguments: {RoutesData.isShippingAddress: isShipping});
  }
}
