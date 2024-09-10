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
      // emailController.text = "ankita7@gmail.com";
      emailController.text = "ankita7@gmail.com";
      passwordController.text = "123";

      //B2B
      // emailController.text = "rakesh.abjewellers+18@yopmail.com";
      // passwordController.text = "123";
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
        Utils.showMessage(errorModel.message ?? '');
        emit(SignInErrorState(errorMessage: errorModel.message ?? ''));
        printWrapped('$value');
      }, (r) async {
        printWrapped(r.toString());
        await StorageManager().setAuthToken(r.accessToken ?? '');
        await StorageManager().setUserId(r.userId ?? '');
        if (r.userIdDetails != null) {
          await StorageManager().setUserData(r.userIdDetails!);
        }
        if (r.userIdDetails?.userTypeEnum != null) {
          emit(const SignInSuccessState());
          BlocProvider.of<AppBloc>(event.context).add(SetUserTypeEvent(r.userIdDetails!.userTypeEnum));
          event.context.pushNamedAndRemoveUntil(AppRoutes.landingPage, (route) => false);
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
}
