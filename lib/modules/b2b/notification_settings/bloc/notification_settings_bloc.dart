import 'package:kgk/kgk.dart';

part 'notification_settings_event.dart';

part 'notification_settings_state.dart';

class NotificationSettingsBloc extends Bloc<NotificationSettingsEvent, NotificationSettingsState> {
  bool isAnnouncementsEnable = true;
  bool isFileShareEnable = true;
  bool isOrderStatusUpdateEnable = true;

  NotificationSettingsBloc() : super(NotificationSettingsInitial()) {
    on<NotificationAnnouncementToggledEvent>(_notificationAnnouncementToggledEvent);
    on<NotificationFileShareToggledEvent>(_notificationFileShareToggledEvent);
    on<NotificationOrderStatusToggledEvent>(_notificationOrderStatusToggledEvent);
  }

  Future<void> _notificationOrderStatusToggledEvent(
      NotificationOrderStatusToggledEvent event, Emitter<NotificationSettingsState> emit) async {
    emit(NotificationReloadState());
    isOrderStatusUpdateEnable = event.isEnable;
    emit(const NotificationOrderStatusToggledState());
  }

  Future<void> _notificationAnnouncementToggledEvent(
      NotificationAnnouncementToggledEvent event, Emitter<NotificationSettingsState> emit) async {
    emit(NotificationReloadState());
    isAnnouncementsEnable = event.isEnable;
    emit(const NotificationAnnouncementToggledState());
  }

  Future<void> _notificationFileShareToggledEvent(NotificationFileShareToggledEvent event, Emitter<NotificationSettingsState> emit) async {
    emit(NotificationReloadState());
    isFileShareEnable = event.isEnable;
    emit(const NotificationFileShareToggledState());
  }
}
