import 'package:kgk/kgk.dart';

class AddAccountBloc extends Bloc<AddAccountEvent, AddAccountState> {
  final String addAccountAppbarTitle = "Checkout";
  bool isShippingAndBillingAddressFilled = false;
  bool isShippingAddressSame = true;
  late Country selectedCountry;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode streetAddressFocusNode = FocusNode();
  FocusNode apartmentFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode countryFocusNode = FocusNode();
  FocusNode zipCodeFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  AddAccountBloc() : super(const AddAccountInitial()) {
    on<AddAccountAddressChangeEvent>(_onChangeShippingAndBillingAddress);
    on<AddAccountAddressSameEvent>(_onChangeShippingAddressSame);
  }

  void _onChangeShippingAndBillingAddress(
      AddAccountAddressChangeEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    isShippingAndBillingAddressFilled = event.isShippingAndBillingAddressFilled;
    emit(AddAccountChangeAddressState(isShippingAndBillingAddressFilled));
  }

  void _onChangeShippingAddressSame(
      AddAccountAddressSameEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    isShippingAddressSame = event.isShippingAddressSame;
    emit(AddAccountChangeAddressSameState(isShippingAddressSame));
  }
}
