import 'package:kgk/kgk.dart';

part 'edit_shipping_address_event.dart';
part 'edit_shipping_address_state.dart';

class EditShippingAddressBloc extends Bloc<EditShippingAddressEvent, EditShippingAddressState> {
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

  EditShippingAddressBloc() : super(const EditShippingAddressInitial()) {
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    on<EditShippingAddressAddressChangeEvent>(_onChangeShippingAndBillingAddress);
    on<EditShippingAddressAddressSameEvent>(_onChangeShippingAddressSame);
    on<EditShippingAddressChangeCountryEvent>(_onChangeCountry);
    on<EditShippingAddressChangeCityEvent>(_onChangeCity);
    on<EditShippingAddressChangeStateEvent>(_onChangeState);
    on<SaveEditShippingAddressEvent>(_onSaveEditShippingAddressEvent);
  }

  void _onChangeShippingAndBillingAddress(EditShippingAddressAddressChangeEvent event, Emitter<EditShippingAddressState> emit) {
    emit(EditShippingAddressReloadState());
    isShippingAndBillingAddressFilled = !isShippingAndBillingAddressFilled;
    emit(const EditShippingAddressChangeAddressState());
  }

  void _onChangeShippingAddressSame(EditShippingAddressAddressSameEvent event, Emitter<EditShippingAddressState> emit) {
    emit(EditShippingAddressReloadState());
    isShippingAddressSame = event.isShippingAddressSame;
    emit(EditShippingAddressChangeAddressSameState(isShippingAddressSame));
  }

  void _onChangeCountry(EditShippingAddressChangeCountryEvent event, Emitter<EditShippingAddressState> emit) {
    emit(EditShippingAddressReloadState());
    selectedCountry = event.selectedCountry;
    emit(EditShippingAddressChangeCountryState(selectedCountry));
  }

  void _onChangeCity(EditShippingAddressChangeCityEvent event, Emitter<EditShippingAddressState> emit) {
    emit(EditShippingAddressReloadState());
    selectedCity = event.selectedCity;
    if (selectedCity != null) {
      emit(EditShippingAddressChangeCityState(selectedCity!));
    }
  }

  void _onChangeState(EditShippingAddressChangeStateEvent event, Emitter<EditShippingAddressState> emit) {
    emit(EditShippingAddressReloadState());
    selectedState = event.selectedState;
    if (selectedState != null) {
      emit(EditShippingAddressChangeStateState(selectedState!));
    }
  }

  void _onSaveEditShippingAddressEvent(SaveEditShippingAddressEvent event, Emitter<EditShippingAddressState> emit) {
    emit(EditShippingAddressReloadState());
    // TODO: Implement the logic to save the address and navigate to the previous screen with the saved address
    clearFormData();
    event.context.pop();
    emit(const EditShippingAddressChangeAddressState());
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
