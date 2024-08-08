import 'package:kgk/kgk.dart';

part 'sign_in_event.dart';

part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  late BuildContext context;

  TextEditingController emailController = TextEditingController(text: kDebugMode ? "company@gmail.com" : '');
  TextEditingController passwordController = TextEditingController(text: kDebugMode ? "123" : '');

  SignInBloc() : super(SignInInitial()) {
    on<SignInButtonPressedEvent>(signInApiCall);
  }

  /// Sign in API call
  Future<void> signInApiCall(SignInButtonPressedEvent event, Emitter<SignInState> emit) async {
    if (!checkValidations()) return;

    event.context.pushNamedAndRemoveUntil(AppRoutes.userTypeSelection, (route) => false);

    // // Show loading state
    // emit(const SignInLoadingState());
    // Map<String, dynamic> params = {
    //   ApiKey.email: emailController.text.trim(),
    //   ApiKey.password: passwordController.text.trim(),
    //   ApiKey.rememberMe: true
    // };
    //
    // await UserRepository(event.context).loginUser(params).then((value) async {
    //   await value?.fold((l) {
    //     ErrorResponse errorModel = l;
    //     Utils.showMessage(errorModel.message ?? '');
    //     emit(SignInErrorState(errorMessage: errorModel.message ?? ''));
    //     printWrapped('$value');
    //   }, (r) async {
    //     printWrapped(r.toString());
    //     await StorageManager().setAuthToken(r.accessToken ?? '');
    //     emit(const SignInSuccessState());
    //     event.context.pushNamedAndRemoveUntil(AppRoutes.userTypeSelection, (route) => false);
    //   });
    // });
  }

  /// Check email & password validations as needed
  bool checkValidations() {
    if (emailController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.emailRequired.tr);
      return false;
    } else if (!Utils.isEmail(emailController.text.trim())) {
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
