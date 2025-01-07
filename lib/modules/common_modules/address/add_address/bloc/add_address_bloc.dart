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

  String? firstNameError;
  String? lastNameError;
  String? streetAddressError;
  String? apartmentError;
  String? cityError;
  String? stateError;
  String? countryError;
  String? zipCodeError;
  String? phoneError;

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

  List<AddressDetails> addressList = [];

  AddressDetails? address;

  AddAddressBloc() : super(const AddAddressInitial()) {
    on<AddAddressInitialEvent>(_onInitAddAddressEvent);
    on<AddAddressAddressChangeEvent>(_onChangeShippingAndBillingAddress);
    on<AddAddressAddressSameEvent>(_onChangeShippingAddressSame);
    on<AddAddressChangeCountryEvent>(_onChangeCountry);
    on<AddAddressChangeStateEvent>(_onChangeState);
    on<SaveAddressEvent>(_onSaveAddressEvent);
    on<AddAddressChangeCountryCodeEvent>(_onAddAddressChangeCountryCodeEvent);
    on<AddAddressFieldChangeEvent>(_onAddAddressFieldChangeEvent);
  }

  void getScreenIdentifier(BuildContext context) {
    Map<RoutesData, dynamic>? data = context.routesData;
    address = data?[RoutesData.addressDetails];
    isEditAddress = address != null;
    isFromCheckout = data?[RoutesData.isFromCheckout] ?? false;
  }

  Future<void> _onInitAddAddressEvent(AddAddressInitialEvent event, Emitter<AddAddressState> emit) async {
    if (_isInitialised) return;
    appBloc = BlocProvider.of<AppBloc>(event.context);
    emit(AddAddressReloadState());
    getScreenIdentifier(event.context);

    addAddressAppbarTitle = isEditAddress ? APPStrings.editAddress.tr : APPStrings.checkout.tr;
    addressList = await appBloc.fetchAddressList(event.context);
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
      if (selectedCountry != null) {
        add(AddAddressChangeCountryEvent(context: event.context, selectedCountry: selectedCountry!));
      }
    } else {
      if (address == null) return;

      firstNameController.text = address!.firstName ?? "";
      lastNameController.text = address!.lastName ?? "";
      apartmentController.text = address!.apartment ?? "";
      streetAddressController.text = address!.streetAddress ?? "";
      cityController.text = address!.city ?? "";
      zipCodeController.text = address!.zipCode ?? "";
      if (address!.phone.isNotEmpty) {
        phoneController.text = address!.phone.first.phoneNumber ?? "";
        selectedCountryCodes = Country.tryParse(address!.phone.first.phoneCode ?? '') ?? selectedCountryCodes;
      }
      CountryStateModel? countryStateModel =
          countryList.firstWhereOrNull((element) => element.name == address!.country || element.code == address!.country);
      if (countryStateModel != null) {
        selectedCountry = Country.tryParse(countryStateModel.code ?? '');
        if (selectedCountry != null) {
          arrState = await appBloc.getStateByCountryCode(event.context, selectedCountry!.countryCode);
          selectedState =
              arrState.firstWhereOrNull((element) => element.name == address!.state) ?? (arrState.isNotEmpty ? arrState.first : null);
        }
      }
    }

    emit(const AddAddressInitial());

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

    if (_validateAddress(emit)) {
      //TODO: Implement the logic to save the address and navigate to the previous screen with the saved address
      CommonResponse<AddressDetails>? addressDetails;
      if (isEditAddress) {
        if (address == null || address!.id.isNullOrEmpty) {
          return;
        }
        addressDetails = await updateAddressAPI(event.context, address!.id ?? "");
      } else {
        addressDetails = await saveAddressAPI(event.context);
      }
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

  void _onAddAddressFieldChangeEvent(AddAddressFieldChangeEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    switch (event.fieldType) {
      case FieldTypeValidationEnum.firstName:
        firstNameError = null;
        break;
      case FieldTypeValidationEnum.lastName:
        lastNameError = null;
        break;
      case FieldTypeValidationEnum.apartment:
        apartmentError = null;
        break;
      case FieldTypeValidationEnum.address:
        streetAddressError = null;
        break;
      case FieldTypeValidationEnum.city:
        cityError = null;
        break;
      case FieldTypeValidationEnum.state:
        stateError = null;
        break;
      case FieldTypeValidationEnum.country:
        countryError = null;
        break;
      case FieldTypeValidationEnum.zipcode:
        zipCodeError = null;
        break;
      case FieldTypeValidationEnum.contactNumber:
        phoneError = null;
        break;

      default:
        break;
    }

    emit(AddAddressFieldErrorState(fieldType: event.fieldType));
  }

  bool _validateAddress(Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    if (firstNameController.text.trim().isEmpty) {
      firstNameError = APPStrings.errorFirstNameRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.firstName, message: firstNameError));
    }
    if (lastNameController.text.trim().isEmpty) {
      lastNameError = APPStrings.errorLastNameRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.lastName, message: lastNameError));
    }

    if (apartmentController.text.trim().isEmpty) {
      apartmentError = APPStrings.errorApartmentRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.apartment, message: apartmentError));
    }

    if (streetAddressController.text.trim().isEmpty) {
      streetAddressError = APPStrings.errorStreetAddressRequired.tr;

      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.address, message: APPStrings.errorStreetAddressRequired.tr));
    }
    if (cityController.text.trim().isEmpty) {
      cityError = APPStrings.errorCityRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.city, message: cityError));
    }
    if (selectedState == null) {
      stateError = APPStrings.errorStateRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.state, message: stateError));
    }
    if (selectedCountry == null) {
      countryError = APPStrings.errorCountryRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.country, message: countryError));
    }
    if (zipCodeController.text.trim().isEmpty) {
      zipCodeError = APPStrings.errorZipCodeRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.zipcode, message: zipCodeError));
    } else if (!Utils.isValidZipCode(zipCodeController.text.trim())) {
      zipCodeError = APPStrings.errorZipCodeValid.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.zipcode, message: zipCodeError));
    }
    if (phoneController.text.trim().isEmpty) {
      phoneError = APPStrings.errorContactNumberRequired.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.contactNumber, message: phoneError));
    } else if (!CountryUtils.validatePhoneNumber(phoneController.text.trim(), "+${selectedCountryCodes.phoneCode}")) {
      phoneError = APPStrings.errorContactNumberValid.tr;
      emit(AddAddressFieldErrorState(fieldType: FieldTypeValidationEnum.contactNumber, message: phoneError));
    }

    return (firstNameError.isNullOrEmpty &&
        lastNameError.isNullOrEmpty &&
        apartmentError.isNullOrEmpty &&
        streetAddressError.isNullOrEmpty &&
        cityError.isNullOrEmpty &&
        stateError.isNullOrEmpty &&
        countryError.isNullOrEmpty &&
        zipCodeError.isNullOrEmpty &&
        phoneError.isNullOrEmpty);
  }

  Future<CommonResponse<AddressDetails>?> saveAddressAPI(BuildContext context) async {
    try {
      bool isFirstAddress = addressList.isEmpty;
      final Map<String, dynamic> body = {
        ApiKey.firstName_: firstNameController.text.trim(),
        ApiKey.lastName_: lastNameController.text.trim(),
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

        //TODO: Need to modify the below data in future with the UI changes for allowing user to select the default address for shipping and billing
        ApiKey.isDefaultShipping: isFirstAddress,
        ApiKey.isDefaultBilling: isFirstAddress,
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

  //updateAddressAPI
  Future<CommonResponse<AddressDetails>?> updateAddressAPI(BuildContext context, String addressId) async {
    try {
      final Map<String, dynamic> body = {
        ApiKey.id: address?.id,
        ApiKey.firstName_: firstNameController.text.trim(),
        ApiKey.lastName_: lastNameController.text.trim(),
        ApiKey.apartment: apartmentController.text.trim(),
        ApiKey.streetAddress: streetAddressController.text.trim(),
        ApiKey.city: cityController.text.trim(),
        ApiKey.state: selectedState?.name,
        ApiKey.country: selectedCountry?.countryCode,
        ApiKey.zipCode: zipCodeController.text.trim(),
        ApiKey.phone: [
          {
            ApiKey.phoneCode: selectedCountryCodes.phoneCode,
            ApiKey.phoneNumber: phoneController.text.trim(),
          }
        ],
      };

      final response = await AppRepository(context).updateAddress(addressId, body: body);
      return response?.fold((l) {
        Utils.showMessage(l.message);

        return null;
      }, (CommonResponse r) {
        address = address?.copyWith(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          apartment: apartmentController.text.trim(),
          streetAddress: streetAddressController.text.trim(),
          city: cityController.text.trim(),
          state: selectedState?.name,
          country: selectedCountry?.countryCode,
          zipCode: zipCodeController.text.trim(),
          phone: [
            CustomerPhoneNumber(
              phoneCode: selectedCountryCodes.phoneCode,
              phoneNumber: phoneController.text.trim(),
            ),
          ],
        );
        return CommonResponse<AddressDetails>(message: r.message, responseData: address, statusCode: r.statusCode);
      });
    } catch (e) {
      Utils.showMessage(e.toString());
    }
    return null;
  }
}
