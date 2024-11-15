import 'package:kgk/kgk.dart';

part 'add_address_event.dart';

part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  bool _isInitialised = false;
  late AppBloc appBloc;
  bool isEditAddress = false;
  bool isFromCheckout = false;

  String addAddressAppbarTitle = "";
  bool isShippingAndBillingAddressFilled = false;
  bool isShippingAddressSame = true;
  Country? selectedCountry;
  CountryStateModel? selectedState;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
  TextEditingController cityController = TextEditingController();
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

  Country selectedCountryCodes = Country.from(json: {
    "e164_cc": "91",
    "iso2_cc": "IN",
    "e164_sc": 0,
    "geographic": true,
    "level": 1,
    "name": "India",
    "example": "9123456789",
    "display_name": "India (IN) [+91]",
    "full_example_with_plus_sign": "+919123456789",
    "display_name_no_e164_cc": "India (IN)",
    "e164_key": "91-IN-0",
  });

  List<CountryStateModel> countryList = [];

  List<CountryStateModel> arrState = [];

  AddAddressBloc() : super(const AddAddressInitial()) {
    on<AddAddressInitialEvent>(_onInitAddAddressEvent);
    on<AddAddressAddressChangeEvent>(_onChangeShippingAndBillingAddress);
    on<AddAddressAddressSameEvent>(_onChangeShippingAddressSame);
    on<AddAddressChangeCountryEvent>(_onChangeCountry);
    on<AddAddressChangeStateEvent>(_onChangeState);
    on<SaveAddressEvent>(_onSaveAddressEvent);
    on<AddAddressChangeCountryCodeEvent>(_onAddAddressChangeCountryCodeEvent);
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    String? addressId = data?[RoutesData.addressId];
    isEditAddress = addressId != null;
    isFromCheckout = data?[RoutesData.isFromCheckout] ?? false;
  }

  Future<void> _onInitAddAddressEvent(AddAddressInitialEvent event, Emitter<AddAddressState> emit) async {
    if (_isInitialised) return;
    appBloc = BlocProvider.of<AppBloc>(event.context);
    emit(AddAddressReloadState());
    getScreenIdentifier(event.context);

    addAddressAppbarTitle = isEditAddress ? APPStrings.editAddress.tr : APPStrings.checkout.tr;
    countryList = await appBloc.getCountries(event.context);
    if (!isEditAddress) {
      firstNameController.clear();
      lastNameController.clear();
      apartmentController.clear();
      streetAddressController.clear();
      zipCodeController.clear();
      phoneController.clear();
      cityController.clear();
      selectedState = null;
      selectedCountry = Country.from(json: {
        "e164_cc": "91",
        "iso2_cc": "IN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "India",
        "example": "9123456789",
        "display_name": "India (IN) [+91]",
        "full_example_with_plus_sign": "+919123456789",
        "display_name_no_e164_cc": "India (IN)",
        "e164_key": "91-IN-0",
      });
    } else {
      firstNameController.text = "Gautam";
      lastNameController.text = "Singhania";
      apartmentController.text = "Apt 2";
      streetAddressController.text = "431 School House Road";
      cityController.text = "Fort Wayne";
      selectedState = arrState.first;
      selectedCountry = Country.from(json: {
        "e164_cc": "91",
        "iso2_cc": "IN",
        "e164_sc": 0,
        "geographic": true,
        "level": 1,
        "name": "India",
        "example": "9123456789",
        "display_name": "India (IN) [+91]",
        "full_example_with_plus_sign": "+919123456789",
        "display_name_no_e164_cc": "India (IN)",
        "e164_key": "91-IN-0",
      });
      zipCodeController.text = "46802";
      phoneController.text = "8504279498";
    }

    emit(const AddAddressInitial());
    if (selectedCountry != null) {
      add(AddAddressChangeCountryEvent(context: event.context, selectedCountry: selectedCountry!));
    }
    _isInitialised = true;
  }

  void _onChangeShippingAndBillingAddress(AddAddressAddressChangeEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());

    isShippingAndBillingAddressFilled = !isShippingAndBillingAddressFilled;

    emit(const AddAddressChangeAddressState());
  }

  void _onChangeShippingAddressSame(AddAddressAddressSameEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    isShippingAddressSame = event.isShippingAddressSame;
    emit(AddAddressChangeAddressSameState(isShippingAddressSame));
  }

  Future<void> _onChangeCountry(AddAddressChangeCountryEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressReloadState());
    selectedCountry = event.selectedCountry;
    if (selectedCountry != null) {
      arrState = await appBloc.getStateByCountryCode(event.context, selectedCountry!.countryCode);
      selectedState = arrState.isNotEmpty ? arrState.first : null;
      emit(AddAddressChangeCountryState(selectedCountry: selectedCountry!, arrStates: arrState));
    }
  }

  void _onChangeState(AddAddressChangeStateEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    selectedState = event.selectedState;
    if (selectedState != null) {
      emit(AddAddressChangeStateState(selectedState!));
    }
  }

  Future<void> _onSaveAddressEvent(SaveAddressEvent event, Emitter<AddAddressState> emit) async {
    emit(AddAddressReloadState());
    //TODO: Implement the logic to save the address and navigate to the previous screen with the saved address
    // here I've commented the code to pop the screen and pass the addressDetails to the previous screen. Uncomment when validation added
    // AddressDetails addressDetails = AddressDetails(
    //   firstName: firstNameController.text,
    //   lastName: lastNameController.text,
    //   contactNumber: phoneController.text,
    //   addressLine1: streetAddressController.text,
    //   addressLine2: apartmentController.text,
    //   city: selectedCity?.name ?? "",
    //   state: selectedState?.name ?? "",
    //   country: selectedCountry.name,
    //   zipCode: zipCodeController.text,
    // );
    // clearFormData();
    // event.context.pop(arguments: {RoutesData.addressDetails: addressDetails});
    // event.context.pop();
    // emit(const AddAddressChangeAddressState());

    if (_validateAddress()) {
      //TODO: Implement the logic to save the address and navigate to the previous screen with the saved address
      CommonResponse<AddressDetails>? addressDetails = await saveAddressAPI(event.context);
      if (addressDetails != null && addressDetails.responseData != null) {
        clearFormData();
        try {
          event.context.pop(arguments: {RoutesData.addressDetails: addressDetails.responseData});
          Utils.showMessage(addressDetails.message);
        } catch (e) {
          printWrapped(e.toString());
        }

        emit(const AddAddressChangeAddressState());
      }
    }
  }

  void clearFormData() {
    firstNameController.clear();
    lastNameController.clear();
    streetAddressController.clear();
    apartmentController.clear();
    zipCodeController.clear();
    phoneController.clear();
    cityController.clear();
    selectedState = null;
    selectedCountry = Country.from(json: {
      "e164_cc": "91",
      "iso2_cc": "IN",
      "e164_sc": 0,
      "geographic": true,
      "level": 1,
      "name": "India",
      "example": "9123456789",
      "display_name": "India (IN) [+91]",
      "full_example_with_plus_sign": "+919123456789",
      "display_name_no_e164_cc": "India (IN)",
      "e164_key": "91-IN-0",
    });
  }

  void _onAddAddressChangeCountryCodeEvent(AddAddressChangeCountryCodeEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    selectedCountryCodes = event.selectedCountry;
    emit(const AddAddressChangeCountryCodeState());
  }

  bool _validateAddress() {
    if (firstNameController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorFirstNameRequired.tr);
      return false;
    }
    if (lastNameController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorLastNameRequired.tr);
      return false;
    }

    if (apartmentController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorApartmentRequired.tr);
      return false;
    }

    if (streetAddressController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorStreetAddressRequired.tr);
      return false;
    }
    if (cityController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorCityRequired.tr);
      return false;
    }
    if (selectedState == null) {
      Utils.showMessage(APPStrings.errorStateRequired.tr);
      return false;
    }
    if (selectedCountry == null) {
      Utils.showMessage(APPStrings.errorCountryRequired.tr);
      return false;
    }
    if (zipCodeController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorZipCodeRequired.tr);
      return false;
    }
    if (phoneController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.errorContactNumberRequired.tr);
      return false;
    }

    return true;
  }

  Future<CommonResponse<AddressDetails>?> saveAddressAPI(BuildContext context) async {
    try {
      final Map<String, dynamic> body = {
        ApiKey.firstName: firstNameController.text.trim(),
        ApiKey.lastName: lastNameController.text.trim(),
        ApiKey.apartment: apartmentController.text.trim(),
        ApiKey.streetAddress: streetAddressController.text.trim(),
        ApiKey.city: cityController.text.trim(),
        ApiKey.state: selectedState?.name,
        ApiKey.country: selectedCountry?.name,
        ApiKey.zipCode: zipCodeController.text.trim(),
        ApiKey.phone: [
          {
            ApiKey.phoneCode: selectedCountryCodes.phoneCode,
            ApiKey.phoneNumber: phoneController.text.trim(),
          }
        ],
        ApiKey.isDefaultShipping: false,
        ApiKey.isDefaultBilling: false,
      };

      final response = await AppRepository(context).saveAddress(body: body);
      return response?.fold((l) {
        Utils.showMessage(l.message);
        return null;
      }, (r) => r);
    } catch (e) {
      Utils.showMessage(e.toString());
    }
    return null;
  }
}
