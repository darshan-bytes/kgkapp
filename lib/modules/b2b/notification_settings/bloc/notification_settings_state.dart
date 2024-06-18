part of 'notification_settings_bloc.dart';

sealed class NotificationSettingsState extends Equatable {
  const NotificationSettingsState();
}

final class NotificationSettingsInitial extends NotificationSettingsState {
  @override
  List<Object> get props => [];
}

final class NotificationAnnouncementToggledState extends NotificationSettingsState {
  const NotificationAnnouncementToggledState();

  @override
  List<Object> get props => [];
}

final class NotificationFileShareToggledState extends NotificationSettingsState {
  const NotificationFileShareToggledState();

  @override
  List<Object> get props => [];
}

final class NotificationOrderStatusToggledState extends NotificationSettingsState {
  const NotificationOrderStatusToggledState();

  @override
  List<Object> get props => [];
}

final class NotificationReloadState extends NotificationSettingsState {
  @override
  List<Object> get props => [];
}
