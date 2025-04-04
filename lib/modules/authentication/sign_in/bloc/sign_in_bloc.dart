import 'package:kgk/kgk.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  bool isFromLoginRequired = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  SignInBloc() : super(SignInInitial()) {
    if (kDebugMode) {
      //B2C
      emailController.text = "ankita7@yopmail.com";
      emailController.text = "chudasama985@yopmail.com";
      // emailController.text = "user.email+16@yopmail.com";

      // Client's User B2C
      // emailController.text = "ramesh.kumar@sparklesoft.co.in";
      emailController.text = "bhati.rmb+3@gmail.com";
      // emailController.text = "mohammadhusain@yopmail.com";
      // emailController.text = "sivaraj.dharuman@sparklesoft.co.in";
      // emailController.text = "darshan.vachhani+112@bytestechnolab.com";
      // emailController.text = "ankitachudasama99@yopmail.com";

      //B2B
      // emailController.text = "joseph.murphy@yopmail.com";

      // emailController.text = "customer48008@kgkmail.com";
      // emailController.text = "kachinbali@yopmail.com";

      // emailController.text = "customer48008@kgkmail.com";
      //  emailController.text = "kachinbali@yopmail.com";
      // emailController.text = "mohammadhusain@yopmail.com";
      // emailController.text = "jainamm.diamonds@yopmail.com"; //Diamond
      // emailController.text = "parash2@yopmail.com"; // Jewellery

      passwordController.text = "Asdf@1234";
      // passwordController.text = "Test@123";
      // passwordController.text = "Admin@123";
      // passwordController.text = "123";
    }
    on<SignInButtonPressedEvent>(signInApiCall);
    on<SignInInitialEvent>(_onSignInInitialEvent);
  }

  Future<void> _onSignInInitialEvent(SignInInitialEvent event, Emitter<SignInState> emit) async {
    event.context;

    isFromLoginRequired = event.context.routesData?[RoutesData.isFromLoginRequired] ?? false;
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
        if (r.isVerified == false) {
          //TODO: Handle OTP Verification
          Utils.showMessage(APPStrings.yourAccountIsNotVerified.tr);
          event.context.pushNamed(AppRoutes.otpVerificationPage, arguments: {
            RoutesData.email: emailController.text.trim(),
            RoutesData.isFromSignIn: true,
          });
        } else {
          await Utils.handleAuthSuccessResponse(event.context, r, isFromLoginRequired);
          clearAllFields();
          emit(const SignInSuccessState());
        }
      });
    });
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
    await StorageManager.instance.setIsSkipLogin(true);
    BlocProvider.of<AppBloc>(context).add(const SetUserTypeEvent(UserType.b2cUser));
    BlocProvider.of<LandingBloc>(context).add(LandingLogoutEvent());
    context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
  }

  /// Clear all fields
  clearAllFields() {
    emailController.clear();
    passwordController.clear();
  }
}
