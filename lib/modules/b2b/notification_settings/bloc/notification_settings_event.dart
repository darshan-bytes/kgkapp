part of 'notification_settings_bloc.dart';

sealed class NotificationSettingsEvent extends Equatable {
  const NotificationSettingsEvent();
}

class NotificationAnnouncementToggledEvent extends NotificationSettingsEvent {
  final bool isEnable;

  const NotificationAnnouncementToggledEvent(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class NotificationFileShareToggledEvent extends NotificationSettingsEvent {
  final bool isEnable;

  const NotificationFileShareToggledEvent(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class NotificationOrderStatusToggledEvent extends NotificationSettingsEvent {
  final bool isEnable;

  const NotificationOrderStatusToggledEvent(this.isEnable);

  @override
  List<Object> get props => [isEnable];
}

class NotificationReloadEvent extends NotificationSettingsEvent {
  @override
  List<Object> get props => [];
}
