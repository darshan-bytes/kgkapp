import 'package:kgk/kgk.dart';

part 'forgot_email_sent_event.dart';

part 'forgot_email_sent_state.dart';

class ForgotEmailSentBloc extends Bloc<ForgotEmailSentEvent, ForgotEmailSentState> {
  ForgotEmailSentBloc() : super(EmailSentInitial()) {
    on<ForgotEmailSentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
