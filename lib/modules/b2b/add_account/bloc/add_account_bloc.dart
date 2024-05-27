import 'package:kgk/kgk.dart';

class AddAccountBloc extends Bloc<AddAccountEvent, AddAccountState> {
  final String addAccountAppbarTitle = "Checkout";
  bool isShippingAndBillingAddressFilled = false;
  bool isShippingAddressSame = true;
  late Country selectedCountry;
  City? selectedCity;
  StateModel? selectedState;

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

  AddAccountBloc() : super(const AddAccountInitial()) {
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    on<AddAccountAddressChangeEvent>(_onChangeShippingAndBillingAddress);
    on<AddAccountAddressSameEvent>(_onChangeShippingAddressSame);
    on<AddAccountChangeCountryEvent>(_onChangeCountry);
    on<AddAccountChangeCityEvent>(_onChangeCity);
    on<AddAccountChangeStateEvent>(_onChangeState);
  }

  void _onChangeShippingAndBillingAddress(AddAccountAddressChangeEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    isShippingAndBillingAddressFilled = event.isShippingAndBillingAddressFilled;
    emit(AddAccountChangeAddressState(isShippingAndBillingAddressFilled));
  }

  void _onChangeShippingAddressSame(AddAccountAddressSameEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    isShippingAddressSame = event.isShippingAddressSame;
    emit(AddAccountChangeAddressSameState(isShippingAddressSame));
  }

  void _onChangeCountry(AddAccountChangeCountryEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    selectedCountry = event.selectedCountry;
    emit(AddAccountChangeCountryState(selectedCountry));
  }

  void _onChangeCity(AddAccountChangeCityEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    selectedCity = event.selectedCity;
    if (selectedCity != null) {
      emit(AddAccountChangeCityState(selectedCity!));
    }
  }

  void _onChangeState(AddAccountChangeStateEvent event, Emitter<AddAccountState> emit) {
    emit(AddAccountRecordState());
    selectedState = event.selectedState;
    if (selectedState != null) {
      emit(AddAccountChangeStateState(selectedState!));
    }
  }
}
