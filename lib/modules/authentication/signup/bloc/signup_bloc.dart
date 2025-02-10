import 'package:kgk/kgk.dart';

part 'signup_event.dart';

part 'signup_state.dart';

enum ValidationFieldType { email, phoneNumber }

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  /// Indicates whether the SignUpBloc has been initialized.
  ///
  /// This flag is used to prevent re-initialization of the bloc's state and data fetching operations.
  /// It is set to `true` once the initial setup and data loading are completed.
  bool _isInitialised = false;
  bool isIndividual = true;
  bool isBusinessTypeListFetched = false;
  bool isOfficeLocationListFetched = false;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  List<TextEditingController> contactNumberControllers = [TextEditingController()];
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController officeLocationController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipcodeController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  List<FocusNode> contactNumberFocusNodes = [FocusNode()];
  FocusNode contactNumberFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();
  FocusNode companyNameFocusNode = FocusNode();
  FocusNode officeLocationFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode cityFocusNode = FocusNode();
  FocusNode stateFocusNode = FocusNode();
  FocusNode zipcodeFocusNode = FocusNode();

  String? firstNameError;
  String? lastNameError;
  String? emailError;
  List<String?> contactNumberErrors = [null];
  String? passwordError;
  String? confirmPasswordError;
  String? companyNameError;
  String? businessTypeError;
  String? officeLocationError;
  String? addressError;
  String? cityError;
  String? stateError;
  String? zipcodeError;

  Completer<bool> isEmailUsed = Completer<bool>();
  Completer<bool> isPhoneNumberUsed = Completer<bool>();

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
  List<BusinessType> businessTypes = [];

  List<OfficeLocation> officeLocations = [];

  OfficeLocation? selectedOfficeLocation;

  bool get isSignupButtonEnabled => isBusinessTypeListFetched && isOfficeLocationListFetched;

  SignUpBloc() : super(SignupInitial()) {
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    on<SignUpInitialEvent>(_onSignUpInitialEvent);
    on<SignUpChangeAccountTypeEvent>(_onSignUpChangeAccountTypeEvent);
    on<SignUpChangeCountryCodeEvent>(_onSignUpChangeCountryCodeEvent);
    on<SignUpChangeCountryEvent>(_onSignUpChangeCountryEvent);
    on<SignUpBusinessTypeChangedEvent>(_onSignUpBusinessTypeChangedEvent);
    on<SignupAddContactEvent>(_onSignupAddContactEvent);
    on<SignUpRemoveContactEvent>(_onSignUpRemoveContactEvent);
    on<SignUpResetEvent>(_onSignUpResetEvent);
    on<SignUpChangeOfficeLocationEvent>(_onSignUpChangeOfficeLocationEvent);
    on<SignUpSubmitEvent>(_onSignUpSubmit);
    on<SignUpEmailValidationEvent>(_onSignUpEmailValidationEvent);
    on<SignUpPhoneNumberValidationEvent>(_onSignUpPhoneNumberValidationEvent);
    on<SignUpFieldChangeEvent>(_onSignUpFieldChangeEvent);
  }

  Future<void> _onSignUpInitialEvent(SignUpInitialEvent event, Emitter<SignUpState> emit) async {
    if (_isInitialised) {
      return;
    }
    _isInitialised = true;
    emit(const SignUpLoadingState());
    isBusinessTypeListFetched = await getBusinessTypeList(event, emit);
    isOfficeLocationListFetched = await getOfficeLocations(event, emit);

    emit(const SignUpLoadedState());
  }

  Future<bool> getBusinessTypeList(SignUpInitialEvent event, Emitter<SignUpState> emit) async {
    Either<ErrorResponse, List<BusinessType>>? businessTypeResponse = await UserRepository(event.context).getBusinessTypes();
    return businessTypeResponse?.fold(
          (l) {
            emit(SignUpErrorState(l.message ?? ''));
            Utils.showMessage(l.message);
            return false;
          },
          (r) {
            businessTypes = r;
            selectFirstBusinessLocation();
            return true;
          },
        ) ??
        false;
  }

  Future<bool> getOfficeLocations(SignUpInitialEvent event, Emitter<SignUpState> emit) async {
    Either<ErrorResponse, List<OfficeLocation>>? officeLocationResponse = await UserRepository(event.context).getOfficeLocations();
    return officeLocationResponse?.fold(
          (l) {
            emit(SignUpErrorState(l.message ?? ''));
            Utils.showMessage(l.message);
            return false;
          },
          (r) {
            officeLocations = r;
            if (officeLocations.isNotEmpty) {
              selectedOfficeLocation = officeLocations.first;
            }
            return true;
          },
        ) ??
        false;
  }

  Future<void> _onSignUpChangeAccountTypeEvent(SignUpChangeAccountTypeEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpReloadState());
    if (emailController.text.trim().isNotEmpty) {
      add(SignUpEmailValidationEvent(email: emailController.text.trim(), context: event.context));
    }
    if (contactNumberController.text.trim().isNotEmpty) {
      add(SignUpPhoneNumberValidationEvent(phoneNumber: contactNumberController.text.trim(), context: event.context));
    }
    if (isIndividual == event.isIndividual) return;
    await Utils.showSmartModalBottomSheet(
      context: event.context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r), topRight: Radius.circular(20.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(8.0.h),
        child: ConfirmationDialog(
          title: APPStrings.areYouSureChangeAccountType.tr,
          onApproved: () {
            context.pop();
            clearField();
            isIndividual = event.isIndividual;
            emit(SignUpChangeAccountTypeState(isIndividual));
          },
          onDenied: () => context.pop(),
          onApprovedText: APPStrings.yes.tr,
          onDeniedText: APPStrings.no.tr,
        ),
      ),
    );
  }

  void _onSignUpChangeCountryCodeEvent(SignUpChangeCountryCodeEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    selectedCountryCodes[event.index] = event.country;
    contactNumberErrors[event.index] = null;
    emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.contactNumber));
    emit(SignUpChangeCountryCodeState(country: selectedCountryCodes[event.index], index: event.index));
  }

  void _onSignUpBusinessTypeChangedEvent(SignUpBusinessTypeChangedEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());

    if (event.index == 2) {
      if (!businessTypes[0].isSelected && !businessTypes[1].isSelected) {
        businessTypes[event.index].isSelected = event.isSelected;
        emit(SignUpBusinessTypeChangedState(event.index, event.isSelected));
      }
    } else {
      if (!businessTypes[2].isSelected) {
        businessTypes[event.index].isSelected = event.isSelected;
        emit(SignUpBusinessTypeChangedState(event.index, event.isSelected));
      }
    }
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
    contactNumberErrors.add(null);
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
    for (BusinessType element in businessTypes) {
      element.isSelected = false;
    }
    isIndividual = true;
    selectFirstBusinessLocation();
    emit(SignUpReloadState());
  }

  void selectFirstBusinessLocation() {
    //TODO: Remove when business types UI is done
    if (businessTypes.isNotEmpty) {
      businessTypes.first.isSelected = true;
    }
  }

  void _onSignUpChangeOfficeLocationEvent(SignUpChangeOfficeLocationEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    selectedOfficeLocation = event.officeLocation;
    if (selectedOfficeLocation != null) {
      emit(SignUpChangeOfficeLocationState(selectedOfficeLocation!));
    }
  }

  Future<void> _onSignUpSubmit(SignUpSubmitEvent event, Emitter<SignUpState> emit) async {
    emit(SignUpReloadState());
    bool isValidate = _validateForm(emit);
    bool isPhoneNumberUsed = await this.isPhoneNumberUsed.future;
    bool isEmailUsed = await this.isEmailUsed.future;
    if (isValidate && !isPhoneNumberUsed && !isEmailUsed) {
      emit(const SignUpLoadingState());
      await _callSignUpApi(event: event);
    }
  }

  bool _validateForm(Emitter<SignUpState> emit) {
    bool isValidate = true;
    if (isIndividual) {
      if (firstNameController.text.isEmpty) {
        firstNameError = APPStrings.errorFirstNameRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.firstName));
        isValidate = false;
      }
      if (lastNameController.text.isEmpty) {
        lastNameError = APPStrings.errorLastNameRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.lastName));
        isValidate = false;
      }
      if (emailController.text.isEmpty) {
        emailError = APPStrings.emailRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.email));
        isValidate = false;
      } else if (!Utils.isValidEmail(emailController.text)) {
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.email));
        emailError = APPStrings.validEmail.tr;
        isValidate = false;
      }
      if (contactNumberControllers.any((element) => element.text.isEmpty)) {
        contactNumberErrors = List.generate(contactNumberControllers.length, (index) {
          if (contactNumberControllers[index].text.isEmpty) {
            return APPStrings.errorContactNumberRequired.tr;
          }
          return null;
        });
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.contactNumber));
        isValidate = false;
      } else {
        for (int i = 0; i < contactNumberControllers.length; i++) {
          contactNumberErrors = List.generate(contactNumberControllers.length, (index) {
            if (!CountryUtils.validatePhoneNumber(contactNumberControllers[index].text, "+${selectedCountryCodes[index].phoneCode}")) {
              isValidate = false;
              return APPStrings.errorContactNumberValid.tr;
            }
            return null;
          });
          emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.contactNumber));
        }
      }
      if (passwordController.text.trim().isEmpty) {
        passwordError = APPStrings.errorPasswordRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.password));
        isValidate = false;
      } else if (!Utils.isValidPassword(passwordController.text.trim())) {
        passwordError = APPStrings.validPassword.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.password));
        isValidate = false;
      }
      if (confirmPasswordController.text.trim().isEmpty) {
        confirmPasswordError = APPStrings.errorConfirmPasswordRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
        isValidate = false;
      } else if (passwordController.text != confirmPasswordController.text) {
        confirmPasswordError = APPStrings.errorPasswordNotMatch.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
        isValidate = false;
      }
    } else {
      if (companyNameController.text.isEmpty) {
        companyNameError = APPStrings.errorCompanyNameRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.companyName));
        isValidate = false;
      }
      if (selectedOfficeLocation == null) {
        officeLocationError = APPStrings.errorOfficeLocationRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.officeLocation));
        isValidate = false;
      }
      if (businessTypes.every((element) => !element.isSelected)) {
        businessTypeError = APPStrings.errorBusinessTypeRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.businessType));
        isValidate = false;
      }
      if (firstNameController.text.isEmpty) {
        firstNameError = APPStrings.errorFirstNameRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.firstName));
        isValidate = false;
      }
      if (lastNameController.text.isEmpty) {
        lastNameError = APPStrings.errorLastNameRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.lastName));
        isValidate = false;
      }
      if (emailController.text.isEmpty) {
        emailError = APPStrings.emailRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.email));
        isValidate = false;
      } else if (!Utils.isValidEmail(emailController.text)) {
        emailError = APPStrings.validEmail.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.email));
        isValidate = false;
      }
      if (contactNumberControllers.any((element) => element.text.isEmpty)) {
        contactNumberErrors = List.generate(contactNumberControllers.length, (index) {
          if (contactNumberControllers[index].text.isEmpty) {
            return APPStrings.errorContactNumberRequired.tr;
          }
          return null;
        });
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.contactNumber));
        isValidate = false;
        isValidate = false;
      } else {
        for (int i = 0; i < contactNumberControllers.length; i++) {
          contactNumberErrors = List.generate(contactNumberControllers.length, (index) {
            if (!CountryUtils.validatePhoneNumber(contactNumberControllers[index].text, "+${selectedCountryCodes[index].phoneCode}")) {
              isValidate = false;
              return APPStrings.errorContactNumberValid.tr;
            }
            return null;
          });
          emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.contactNumber));
        }
      }

      if (addressController.text.trim().isEmpty) {
        addressError = APPStrings.errorStreetAddressRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.address));
        isValidate = false;
      }

      if (cityController.text.trim().isEmpty) {
        cityError = APPStrings.errorCityRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.city));
        isValidate = false;
      }

      if (stateController.text.trim().isEmpty) {
        stateError = APPStrings.errorStateRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.state));
        isValidate = false;
      }

      if (zipcodeController.text.trim().isEmpty) {
        zipcodeError = APPStrings.errorZipCodeRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.zipcode));
        isValidate = false;
      }

      if (passwordController.text.trim().isEmpty) {
        passwordError = APPStrings.errorPasswordRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.password));
        isValidate = false;
      } else if (!Utils.isValidPassword(passwordController.text.trim())) {
        passwordError = APPStrings.validPassword.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.password));
        isValidate = false;
      }
      if (confirmPasswordController.text.trim().isEmpty) {
        confirmPasswordError = APPStrings.errorConfirmPasswordRequired.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
        isValidate = false;
      } else if (passwordController.text != confirmPasswordController.text) {
        confirmPasswordError = APPStrings.errorPasswordNotMatch.tr;
        emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
        isValidate = false;
      }
    }

    return isValidate;
  }

  Future<void> _callSignUpApi({required SignUpSubmitEvent event}) async {
    Map<String, dynamic> params = {
      ApiKey.accountType: isIndividual ? UserType.b2cUser.value : UserType.b2bUser.value,
      ApiKey.userType: AccountType.customer.value,
      ApiKey.firstName_: firstNameController.text.trim(),
      ApiKey.lastName_: lastNameController.text.trim(),
      ApiKey.email: emailController.text.trim(),
      ApiKey.password: passwordController.text.trim(),
      ApiKey.phone:
          contactNumberControllers.map((e) => {ApiKey.phoneCode: selectedCountry.phoneCode, ApiKey.phoneNumber: e.text.trim()}).toList(),
      ApiKey.businessType: businessTypes.where((element) => element.isSelected).map((e) => e.id).toList(),
      ApiKey.countryCode: '',
      ApiKey.status: 'pending',
    };

    if (!isIndividual) {
      params[ApiKey.organizationName] = companyNameController.text.trim();
      params[ApiKey.officeLocationCode] = selectedOfficeLocation?.code;
      params[ApiKey.countryCode] = selectedCountry.countryCode;
      params[ApiKey.city] = cityController.text;
      params[ApiKey.address] = addressController.text;
      params[ApiKey.zipCode] = zipcodeController.text;
      params[ApiKey.state] = stateController.text;
    }

    Either<ErrorResponse, CommonResponse>? signUpResponse = await UserRepository(event.context).signUpCustomer(params);
    signUpResponse?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        add(const SignUpResetEvent());
        if (isIndividual) {
          event.context.pushNamedAndRemoveUntil(AppRoutes.otpVerificationPage, (route) => route.settings.name == AppRoutes.signInPage,
              arguments: {RoutesData.email: emailController.text.trim(), RoutesData.isFromSignIn: false});
        } else {
          event.context.popUntil((route) => (route.settings.name == AppRoutes.signInPage));
        }

        Utils.showMessage(r.message);
      },
    );
  }

  Future<void> _onSignUpEmailValidationEvent(SignUpEmailValidationEvent event, Emitter<SignUpState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!emit.isDone) {
      isEmailUsed = Completer<bool>();
      if (event.email.isNotEmpty && Utils.isValidEmail(event.email)) {
        Map<String, dynamic> params = {ApiKey.email: event.email.trim()};
        Either<ErrorResponse, CommonResponse>? emailValidationResponse = await UserRepository(event.context).validateEmail(params);

        if (!emit.isDone) {
          await emailValidationResponse?.fold((l) {
            Utils.showMessage(l.message);
          }, (r) async {
            if (isEmailUsed.isCompleted) {
              isEmailUsed = Completer<bool>();
            }
            isEmailUsed.complete(r.responseData['isEmailUsed']);
            emit(SignUpEmailValidationState(emailValidationFieldType: ValidationFieldType.email, isError: await isEmailUsed.future));
          });
        }
      }
    }
  }

  Future<void> _onSignUpPhoneNumberValidationEvent(SignUpPhoneNumberValidationEvent event, Emitter<SignUpState> emit) async {
    isPhoneNumberUsed = Completer<bool>();
    await Future.delayed(const Duration(milliseconds: 500));

    if (!emit.isDone) {
      if (event.phoneNumber.isNotEmpty && event.phoneNumber.length >= 10) {
        Either<ErrorResponse, CommonResponse>? phoneNumberValidationResponse =
            await UserRepository(event.context).validatePhoneNumber(code: selectedCountry.phoneCode, phoneNumber: event.phoneNumber);

        if (!emit.isDone) {
          await phoneNumberValidationResponse?.fold((l) {
            Utils.showMessage(l.message);
          }, (r) async {
            if (isPhoneNumberUsed.isCompleted) {
              isPhoneNumberUsed = Completer<bool>();
            }
            isPhoneNumberUsed.complete(r.responseData);
            emit(SignUpPhoneNumberValidationState(
                phoneNumberValidationFieldType: ValidationFieldType.phoneNumber, isError: await isPhoneNumberUsed.future));
          });
        }
      }
    }
  }

  void _onSignUpFieldChangeEvent(SignUpFieldChangeEvent event, Emitter<SignUpState> emit) {
    emit(SignUpReloadState());
    switch (event.fieldType) {
      case FieldTypeValidationEnum.firstName:
        firstNameError = null;
        break;
      case FieldTypeValidationEnum.lastName:
        lastNameError = null;
        break;
      case FieldTypeValidationEnum.email:
        emailError = null;
        break;
      case FieldTypeValidationEnum.contactNumber:
        emit(SignUpPhoneNumberValidationState(phoneNumberValidationFieldType: ValidationFieldType.phoneNumber, isError: false));
        if (event.index < 0) break;
        contactNumberErrors[event.index] = null;
        break;
      case FieldTypeValidationEnum.password:
        passwordError = null;
        if (passwordController.text.trim().isEmpty) {
          passwordError = APPStrings.errorPasswordRequired.tr;
          emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.password));
        } else if (!Utils.isValidPassword(passwordController.text.trim())) {
          passwordError = APPStrings.validPassword.tr;
          emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.password));
        } else {
          if (confirmPasswordController.text.trim().isNotEmpty && passwordController.text == confirmPasswordController.text) {
            confirmPasswordError = null;
            emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
          }
        }
        break;
      case FieldTypeValidationEnum.confirmPassword:
        confirmPasswordError = null;
        if (confirmPasswordController.text.trim().isEmpty) {
          confirmPasswordError = APPStrings.errorConfirmPasswordRequired.tr;
          emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
        } else if (passwordController.text != confirmPasswordController.text) {
          confirmPasswordError = APPStrings.errorPasswordNotMatch.tr;
          emit(SignUpFieldValidationState(fieldType: FieldTypeValidationEnum.confirmPassword));
        }
        break;
      case FieldTypeValidationEnum.companyName:
        companyNameError = null;
        break;
      case FieldTypeValidationEnum.businessType:
        businessTypeError = null;
        break;
      case FieldTypeValidationEnum.officeLocation:
        officeLocationError = null;
        break;
      case FieldTypeValidationEnum.address:
        addressError = null;
        break;
      case FieldTypeValidationEnum.city:
        cityError = null;
        break;
      case FieldTypeValidationEnum.state:
        stateError = null;
        break;
      case FieldTypeValidationEnum.zipcode:
        zipcodeError = null;
        break;
      default:
        break;
    }
    emit(SignUpFieldValidationState(fieldType: event.fieldType));
  }

  void clearField() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    contactNumberControllers = [TextEditingController()];
    contactNumberController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedOfficeLocation = null;
    companyNameController.clear();
    addressController.clear();
    cityController.clear();
    stateController.clear();
    zipcodeController.clear();
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
    selectFirstBusinessLocation();
    firstNameError = null;
    lastNameError = null;
    emailError = null;
    contactNumberErrors = [null];
    passwordError = null;
    confirmPasswordError = null;
    companyNameError = null;
    businessTypeError = null;
    officeLocationError = null;
    addressError = null;
    cityError = null;
    stateError = null;
    zipcodeError = null;
  }
}
