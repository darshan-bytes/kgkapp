import 'package:kgk/kgk.dart';

part 'add_address_event.dart';

part 'add_address_state.dart';

class AddAddressBloc extends Bloc<AddAddressEvent, AddAddressState> {
  String addAddressAppbarTitle = "Checkout";
  bool isShippingAndBillingAddressFilled = false;
  bool isShippingAddressSame = true;
  late Country selectedCountry;
  City? selectedCity;
  StateModel? selectedState;

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController streetAddressController = TextEditingController();
  TextEditingController apartmentController = TextEditingController();
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

  List<Country> selectedCountryCodes = [
    Country.from(json: {
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
    })
  ];

  List<City> arrCity = [
    City(name: "Delhi"),
    City(name: "Mumbai"),
    City(name: "Chennai"),
    City(name: "Kolkata"),
    City(name: "Bangalore"),
    City(name: "Hyderabad"),
    City(name: "Pune"),
  ];

  List<StateModel> arrState = [
    StateModel(name: "India"),
    StateModel(name: "United States"),
    StateModel(name: "Canada"),
    StateModel(name: "Australia"),
    StateModel(name: "Japan"),
    StateModel(name: "China"),
    StateModel(name: "Korea")
  ];

  AddAddressBloc() : super(const AddAddressInitial()) {
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    on<AddAddressAddressChangeEvent>(_onChangeShippingAndBillingAddress);
    on<AddAddressAddressSameEvent>(_onChangeShippingAddressSame);
    on<AddAddressChangeCountryEvent>(_onChangeCountry);
    on<AddAddressChangeCityEvent>(_onChangeCity);
    on<AddAddressChangeStateEvent>(_onChangeState);
    on<SaveAddressEvent>(_onSaveAddressEvent);
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

  void _onChangeCountry(AddAddressChangeCountryEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    selectedCountry = event.selectedCountry;
    emit(AddAddressChangeCountryState(selectedCountry));
  }

  void _onChangeCity(AddAddressChangeCityEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    selectedCity = event.selectedCity;
    if (selectedCity != null) {
      emit(AddAddressChangeCityState(selectedCity!));
    }
  }

  void _onChangeState(AddAddressChangeStateEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    selectedState = event.selectedState;
    if (selectedState != null) {
      emit(AddAddressChangeStateState(selectedState!));
    }
  }

  void _onSaveAddressEvent(SaveAddressEvent event, Emitter<AddAddressState> emit) {
    emit(AddAddressReloadState());
    AddressDetails addressDetails = AddressDetails(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      contactNumber: phoneController.text,
      addressLine1: streetAddressController.text,
      addressLine2: apartmentController.text,
      city: selectedCity?.name ?? "",
      state: selectedState?.name ?? "",
      country: selectedCountry.name,
      zipCode: zipCodeController.text,
    );
    clearFormData();
    //TODO: Implement the logic to save the address and navigate to the previous screen with the saved address
    // here I've commented the code to pop the screen and pass the addressDetails to the previous screen. Uncomment when validation added
    // event.context.pop(arguments: {RoutesData.addressDetails: addressDetails});
    event.context.pop();
    emit(const AddAddressChangeAddressState());
  }

  void clearFormData() {
    firstNameController.clear();
    lastNameController.clear();
    streetAddressController.clear();
    apartmentController.clear();
    zipCodeController.clear();
    phoneController.clear();
    selectedCity = null;
    selectedState = null;
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
  }
}
