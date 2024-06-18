part of 'notification_settings_bloc.dart';

sealed class NotificationSettingsState extends Equatable {
  const NotificationSettingsState();
}

final class NotificationSettingsInitial extends NotificationSettingsState {
  @override
  List<Object> get props => [];
}
