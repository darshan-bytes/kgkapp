import 'package:kgk/kgk.dart';

part 'email_sent_event.dart';
part 'email_sent_state.dart';

class EmailSentBloc extends Bloc<EmailSentEvent, EmailSentState> {
  EmailSentBloc() : super(EmailSentInitial()) {
    on<EmailSentEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
