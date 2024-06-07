import 'package:kgk/kgk.dart';

part 'reset_password_event.dart';

part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode confirmPasswordFocusNode = FocusNode();

  bool isFormFilled = false;

  ResetPasswordBloc() : super(ResetPasswordInitialState()) {
    on<ResetPasswordInitialEvent>(_onResetPasswordInitialEvent);
    on<ResetPasswordChangedEvent>(_onResetPasswordChangedEvent);
    on<ResetPasswordConfirmChangedEvent>(_onResetPasswordConfirmChangedEvent);
  }

  void newPassWordChanged() {
    add(ResetPasswordChangedEvent(newPasswordController.text));
  }

  void confirmPasswordChanged() {
    add(ResetPasswordConfirmChangedEvent(confirmPasswordController.text));
  }

  void _onResetPasswordInitialEvent(ResetPasswordInitialEvent event, Emitter<ResetPasswordState> emit) {
    newPasswordController.clear();
    confirmPasswordController.clear();
    newPasswordFocusNode.requestFocus();
    newPasswordController.addListener(newPassWordChanged);
    confirmPasswordController.addListener(confirmPasswordChanged);
    emit(ResetPasswordInitialState());
  }

  void _onResetPasswordChangedEvent(ResetPasswordChangedEvent event, Emitter<ResetPasswordState> emit) {
    isFormFilled = newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;
    emit(ResetPasswordChangedState(isFormFilled, newPasswordController.text.isNotEmpty));
  }

  void _onResetPasswordConfirmChangedEvent(ResetPasswordConfirmChangedEvent event, Emitter<ResetPasswordState> emit) {
    isFormFilled = newPasswordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty;
    emit(ResetPasswordConfirmChangedState(isFormFilled, confirmPasswordController.text.isNotEmpty));
  }
}
