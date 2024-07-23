import 'package:kgk/kgk.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  TextEditingController emailController = TextEditingController();

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitEvent>(_onSendEmail);
  }

  Future<void> _onSendEmail(ForgotPasswordSubmitEvent event, Emitter<ForgotPasswordState> emit) async {
    if (!checkValidations()) return;

    emit(ForgotPasswordLoadingState());

    Map<String, dynamic> params = {
      ApiKey.email: emailController.text.trim(),
    };

    await UserRepository(event.context).forgotPassword(params).then(
      (result) {
        result?.fold((l) {
          Utils.showMessage(l.message ?? '');
        }, (r) async {
          emit(ForgotPasswordSuccessState());
          event.context.pushNamed(AppRoutes.emailSentPage);
          clearData();
          await Future.delayed(const Duration(milliseconds: 500));
          Utils.showMessage(r.message ?? '');
        });
      },
    );
  }

  /// Check email & password validations as needed
  bool checkValidations() {
    if (emailController.text.trim().isEmpty) {
      Utils.showMessage(APPStrings.emailRequired.tr);

      return false;
    } else if (!Utils.isEmail(emailController.text.trim())) {
      Utils.showMessage(APPStrings.validEmail.tr);
      return false;
    }
    return true;
  }

  void clearData() {
    emailController.clear();
  }
}
