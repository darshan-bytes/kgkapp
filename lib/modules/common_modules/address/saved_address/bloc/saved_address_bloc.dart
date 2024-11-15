import 'package:kgk/kgk.dart';

part 'saved_address_event.dart';

part 'saved_address_state.dart';

class SavedAddressBloc extends Bloc<SavedAddressEvent, SavedAddressState> {
  List<AddressDetails> addressList = [];

  SavedAddressBloc() : super(const SavedAddressInitial()) {
    on<SavedAddressInitialEvent>(_onSavedAddressInitialEvent);
    on<SavedAddressChangeBillingAddressSameEvent>(_onSavedAddressChangeBillingAddressSameEvent);
    on<SavedAddressChangeShippingAddressEvent>(_onSavedAddressChangeShippingAddressEvent);
    on<SavedAddressAddNewAddressEvent>(_onSavedAddressAddNewAddressEvent);
  }

  AddressDetails? get defaultShippingAddress => addressList.firstWhereOrNull((element) => element.isDefaultShipping == true);

  AddressDetails? get defaultBillingAddress => addressList.firstWhereOrNull((element) => element.isDefaultBilling == true);

  bool get isBillingAddressSameAsShippingAddress => defaultBillingAddress == defaultShippingAddress;

  void _onSavedAddressInitialEvent(SavedAddressInitialEvent event, Emitter<SavedAddressState> emit) {
    addressList = [
      AddressDetails(
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

    emit(const SavedAddressLoadedState());
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
