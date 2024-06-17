import 'package:kgk/kgk.dart';

part 'notification_settings_event.dart';

part 'notification_settings_state.dart';

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  NotificationSettingsBloc() : super(NotificationSettingsInitial()) {
    on<NotificationSettingsEvent>((event, emit) {});
  }
}
