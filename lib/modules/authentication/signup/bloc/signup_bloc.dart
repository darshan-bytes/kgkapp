import 'package:kgk/kgk.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  bool isIndividual = true;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<TextEditingController> contactNumberControllers = [TextEditingController()];
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController officeLocationController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  List<FocusNode> contactNumberFocusNodes = [FocusNode()];
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode companyNameFocusNode = FocusNode();
  FocusNode officeLocationFocusNode = FocusNode();

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
  late Country selectedCountry;
  List<BusinessType> businessTypes = [
    BusinessType(name: APPStrings.diamond.tr, code: APPStrings.diamond),
    BusinessType(name: APPStrings.gemstone.tr, code: APPStrings.gemstone),
    BusinessType(name: APPStrings.jewellery.tr, code: APPStrings.jewellery),
  ];

  BusinessType? selectedBusinessType;
  List<OfficeLocation> officeLocations = [
    OfficeLocation(name: "India", code: "india"),
    OfficeLocation(name: "United States", code: "us"),
  ];

  OfficeLocation? selectedOfficeLocation;

  SignUpBloc() : super(SignupInitial()) {
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    on<SignUpChangeAccountTypeEvent>(_onSignUpChangeAccountTypeEvent);
    on<SignUpChangeCountryCodeEvent>(_onSignUpChangeCountryCodeEvent);
    on<SignUpChangeCountryEvent>(_onSignUpChangeCountryEvent);
    on<SignUpBusinessTypeChangedEvent>(_onSignUpBusinessTypeChangedEvent);
    on<SignupAddContactEvent>(_onSignupAddContactEvent);
    on<SignUpRemoveContactEvent>(_onSignUpRemoveContactEvent);
    on<SignUpResetEvent>(_onSignUpResetEvent);
    on<SignUpChangeOfficeLocationEvent>(_onSignUpChangeOfficeLocationEvent);
  }

  void _onSignUpChangeAccountTypeEvent(SignUpChangeAccountTypeEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    isIndividual = event.isIndividual;
    emit(SignUpChangeAccountTypeState(isIndividual));
  }

  void _onSignUpChangeCountryCodeEvent(SignUpChangeCountryCodeEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    selectedCountryCodes[event.index] = event.country;
    emit(SignUpChangeCountryCodeState(country: selectedCountryCodes[event.index], index: event.index));
  }

  void _onSignUpBusinessTypeChangedEvent(SignUpBusinessTypeChangedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    selectedBusinessType = event.businessType;
    emit(SignUpBusinessTypeChangedState(selectedBusinessType));
  }

  void _onSignUpChangeCountryEvent(SignUpChangeCountryEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    selectedCountry = event.country;
    emit(SignUpChangeCountryState(selectedCountry));
  }

  void _onSignupAddContactEvent(SignupAddContactEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    contactNumberControllers.add(TextEditingController());
    contactNumberFocusNodes.add(FocusNode());
    selectedCountryCodes.add(Country.from(json: selectedCountryCodes.last.toJson()));
    emit(SignUpAddRemoveContactState(index: selectedCountryCodes.length - 1, country: selectedCountryCodes.last));
  }

  void _onSignUpRemoveContactEvent(SignUpRemoveContactEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    contactNumberControllers.removeAt(event.index);
    contactNumberFocusNodes.removeAt(event.index);
    Country country = selectedCountryCodes.removeAt(event.index);
    emit(SignUpAddRemoveContactState(isRemove: true, index: event.index, country: country));
  }

  void _onSignUpResetEvent(SignUpResetEvent event, Emitter<SignUpState> emit) {
    emit(SignupInitial());
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    contactNumberControllers.clear();
    contactNumberControllers.add(TextEditingController());
    passwordController.clear();
    confirmPasswordController.clear();
    companyNameController.clear();
    officeLocationController.clear();
    selectedCountryCodes = [
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
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    selectedBusinessType = null;
    isIndividual = true;
    emit(SignUpReloadState());
  }

  void _onSignUpChangeOfficeLocationEvent(SignUpChangeOfficeLocationEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    selectedOfficeLocation = event.officeLocation;
    if (selectedOfficeLocation != null) {
      emit(SignUpChangeOfficeLocationState(selectedOfficeLocation!));
    }
  }
}
