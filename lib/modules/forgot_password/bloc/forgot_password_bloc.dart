import 'package:kgk/kgk.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final emailController = TextEditingController();

  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<ForgotPasswordSubmitEvent>(_onSendEmail);
  }

  Future<void> _onSendEmail(
    ForgotPasswordSubmitEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());
    await Future.delayed(const Duration(seconds: 3));
    // TODO: Send email
    emit(ForgotPasswordSent());
  }
}
