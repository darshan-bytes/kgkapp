import 'package:kgk/kgk.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  late BuildContext context;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInBloc() : super(SignInInitial()) {
    if (kDebugMode) {
      //B2C
      //emailController.text = "ankita7@yopmail.com";

      //B2B
       emailController.text = "joseph.murphy@yopmail.com";
      // emailController.text = "customer48008@kgkmail.com";
      // emailController.text = "jainamm.diamonds@yopmail.com"; //Diamond
      // emailController.text = "parash2@yopmail.com"; // Jewellery

     // passwordController.text = "Test@123";
       passwordController.text = "Admin@123";
    }
    on<SignInButtonPressedEvent>(signInApiCall);
  }

  /// Sign in API call
  Future<void> signInApiCall(SignInButtonPressedEvent event, Emitter<SignInState> emit) async {
    if (!checkValidations()) return;

    // Below code is commented for future use if we need to bypass login API
    // event.context.pushNamedAndRemoveUntil(AppRoutes.userTypeSelection, (route) => false);

    // Show loading state
    emit(const SignInLoadingState());
    Map<String, dynamic> params = {
      ApiKey.email: emailController.text.trim(),
      ApiKey.password: passwordController.text.trim(),
      ApiKey.rememberMe: true
    };

    await UserRepository(event.context).loginUser(params).then((value) async {
      await value?.fold((l) {
        ErrorResponse errorModel = l;
        Utils.showMessage(errorModel.message);
        emit(SignInErrorState(errorMessage: errorModel.message ?? ''));
      }, (r) async {
        await StorageManager().setAuthToken(r.accessToken ?? '');
        await StorageManager().setUserId(r.userId ?? '');
        await StorageManager().setUserResponse(r);
        if (r.customerOrganizationId.isNotNullNorEmpty) {
          await StorageManager().setCustomerOrgId(r.customerOrganizationId!.toString());
        }
        if (r.userIdDetails != null) {
          await StorageManager().setUserData(r.userIdDetails!);
        }
        if (r.bagId != null) {
          await StorageManager().setBagId(r.bagId!);
        }
        if (r.userIdDetails?.userTypeEnum != null) {
          clearAllFields();
          emit(const SignInSuccessState());
          await StorageManager().setIsSkipLogin(false);
          BlocProvider.of<AppBloc>(event.context).add(SetUserTypeEvent(r.userIdDetails!.userTypeEnum));
          await mergeCart(event.context);
          event.context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
        }
      });
    });
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

  /// Check email & password validations as needed
  bool checkValidations() {
    if (emailController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.emailRequired.tr);
      return false;
    } else if (!Utils.isValidEmail(emailController.text.trim())) {
      Utils.showMessage(APPStrings.validEmail.tr);
      return false;
    } else if (passwordController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.passwordRequired.tr);
      return false;
    } else if (passwordController.text.trim().length < 3) {
      Utils.showMessage(APPStrings.validPassword.tr);
      return false;
    }

    return true;
  }

  void onSkipLogin(BuildContext context) async {
    await StorageManager().setIsSkipLogin(true);
    BlocProvider.of<AppBloc>(context).add(const SetUserTypeEvent(UserType.b2cUser));
    context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
  }

  /// Clear all fields
  clearAllFields() {
    emailController.clear();
    passwordController.clear();
  }
}
