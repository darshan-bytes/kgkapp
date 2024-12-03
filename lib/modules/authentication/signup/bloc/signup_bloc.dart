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
    if (_validateForm()) {
      emit(const SignUpLoadingState());
      await _callSignUpApi(event: event);
    }
  }

  bool _validateForm() {
    if (isIndividual) {
      if (firstNameController.text.isEmpty) {
        Utils.showMessage(APPStrings.errorFirstNameRequired.tr);
        return false;
      } else if (lastNameController.text.isEmpty) {
        Utils.showMessage(APPStrings.errorLastNameRequired.tr);
        return false;
      } else if (emailController.text.isEmpty) {
        Utils.showMessage(APPStrings.emailRequired.tr);
        return false;
      } else if (!Utils.isValidEmail(emailController.text)) {
        Utils.showMessage(APPStrings.validEmail.tr);
        return false;
      } else if (contactNumberControllers.any((element) => element.text.isEmpty)) {
        Utils.showMessage(APPStrings.errorContactNumberRequired.tr);
        return false;
      } else if (passwordController.text.trim().isEmpty) {
        Utils.showMessage(APPStrings.errorPasswordRequired.tr);
        return false;
      } else if (!Utils.isValidPassword(passwordController.text.trim())) {
        Utils.showMessage(APPStrings.validPassword.tr);
        return false;
      } else if (confirmPasswordController.text.trim().isEmpty) {
        Utils.showMessage(APPStrings.errorConfirmPasswordRequired.tr);
        return false;
      } else if (passwordController.text != confirmPasswordController.text) {
        Utils.showMessage(APPStrings.errorPasswordNotMatch.tr);
        return false;
      }

      return true;
    } else {
      if (companyNameController.text.isEmpty) {
        Utils.showMessage(APPStrings.errorCompanyNameRequired.tr);
        return false;
      } else if (selectedOfficeLocation == null) {
        Utils.showMessage(APPStrings.errorOfficeLocationRequired.tr);
        return false;
      } else if (businessTypes.every((element) => !element.isSelected)) {
        Utils.showMessage(APPStrings.errorBusinessTypeRequired.tr);
        return false;
      } else if (firstNameController.text.isEmpty) {
        Utils.showMessage(APPStrings.errorFirstNameRequired.tr);
        return false;
      } else if (lastNameController.text.isEmpty) {
        Utils.showMessage(APPStrings.errorLastNameRequired.tr);
        return false;
      } else if (emailController.text.isEmpty) {
        Utils.showMessage(APPStrings.emailRequired.tr);
        return false;
      } else if (!Utils.isValidEmail(emailController.text)) {
        Utils.showMessage(APPStrings.validEmail.tr);
        return false;
      } else if (contactNumberControllers.any((element) => element.text.isEmpty)) {
        Utils.showMessage(APPStrings.errorContactNumberRequired.tr);
        return false;
      } else if (passwordController.text.trim().isEmpty) {
        Utils.showMessage(APPStrings.errorPasswordRequired.tr);
        return false;
      } else if (!Utils.isValidPassword(passwordController.text.trim())) {
        Utils.showMessage(APPStrings.validPassword.tr);
        return false;
      } else if (confirmPasswordController.text.trim().isEmpty) {
        Utils.showMessage(APPStrings.errorConfirmPasswordRequired.tr);
        return false;
      } else if (passwordController.text != confirmPasswordController.text) {
        Utils.showMessage(APPStrings.errorPasswordNotMatch.tr);
        return false;
      }
      return true;
    }
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

    Either<ErrorResponse, CommonResponse<UserResponse>>? signUpResponse = await UserRepository(event.context).signUpCustomer(params);
    signUpResponse?.fold(
      (l) {
        Utils.showMessage(l.message);
      },
      (r) async {
        add(const SignUpResetEvent());
        if (isIndividual) {
          UserResponse userResponse = r.responseData;
          await StorageManager().setAuthToken(userResponse.accessToken ?? '');
          await StorageManager().setUserId(userResponse.userId ?? '');
          await StorageManager().setUserResponse(userResponse);
          if (userResponse.customerOrganizationId.isNotNullNorEmpty) {
            await StorageManager().setCustomerOrgId(userResponse.customerOrganizationId!.toString());
          }
          if (userResponse.userIdDetails != null) {
            await StorageManager().setUserData(userResponse.userIdDetails!);
          }
          if (userResponse.bagId != null) {
            await StorageManager().setBagId(userResponse.bagId!);
          }
          if (userResponse.userIdDetails?.userTypeEnum != null) {
            await StorageManager().setIsSkipLogin(false);
            BlocProvider.of<AppBloc>(event.context).add(SetUserTypeEvent(userResponse.userIdDetails!.userTypeEnum));
            await mergeCart(event.context);
            event.context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
          }
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
      if (event.email.isNotEmpty && Utils.isValidEmail(event.email)) {
        Map<String, dynamic> params = {ApiKey.email: event.email.trim()};
        Either<ErrorResponse, CommonResponse>? emailValidationResponse = await UserRepository(event.context).validateEmail(params);

        if (!emit.isDone) {
          emailValidationResponse?.fold((l) {
            Utils.showMessage(l.message);
          }, (r) {
            bool isEmailUsed = r.responseData['isEmailUsed'];
            emit(SignUpEmailValidationState(emailValidationFieldType: ValidationFieldType.email, isError: isEmailUsed));
          });
        }
      }
    }
  }

  Future<void> _onSignUpPhoneNumberValidationEvent(SignUpPhoneNumberValidationEvent event, Emitter<SignUpState> emit) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (!emit.isDone) {
      if (event.phoneNumber.isNotEmpty && event.phoneNumber.length >= 10) {
        Either<ErrorResponse, CommonResponse>? phoneNumberValidationResponse =
            await UserRepository(event.context).validatePhoneNumber(code: selectedCountry.phoneCode, phoneNumber: event.phoneNumber);

        if (!emit.isDone) {
          phoneNumberValidationResponse?.fold((l) {
            Utils.showMessage(l.message);
          }, (r) {
            bool isPhoneNumberUsed = r.responseData;
            emit(SignUpPhoneNumberValidationState(
                phoneNumberValidationFieldType: ValidationFieldType.phoneNumber, isError: isPhoneNumberUsed));
          });
        }
      }
    }
  }

  Future<void> mergeCart(BuildContext context) async {
    MyBagDataModel? myBagDataModel = StorageManager().getBagData();
    if (myBagDataModel != null) {
      Map<String, dynamic> body = {
        ApiKey.id: myBagDataModel.sId ?? '',
      };
      await AppRepository(context).mergeBag(body: body).then((value) {
        value?.fold((l) {
          Utils.showMessage(l.message);
        }, (r) async {
          if (r.responseData != null) {
            await StorageManager().clearBagData();
          }
        });
      });
    }
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
    selectedCountry = Country.from(json: selectedCountryCodes.first.toJson());
    selectFirstBusinessLocation();
  }
}
