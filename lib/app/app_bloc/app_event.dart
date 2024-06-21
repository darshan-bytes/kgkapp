part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

class LoadAppEvent extends AppEvent {
  @override
  List<Object> get props => [];
}

class ChangeThemeEvent extends AppEvent {
  final String theme;

  const ChangeThemeEvent(this.theme);

  @override
  List<Object> get props => [theme];
}

class ConnectivityChangedEvent extends AppEvent {
  final bool connectivityResult;

  const ConnectivityChangedEvent(this.connectivityResult);

  @override
  List<Object> get props => [connectivityResult];
}

class LanguageChangedEvent extends AppEvent {
  final String languageCode;

  const LanguageChangedEvent(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}

class SetAppLoadingEvent extends AppEvent {
  final bool isLoading;

  const SetAppLoadingEvent(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class SetUserTypeEvent extends AppEvent {
  final UserType userType;

  const SetUserTypeEvent(this.userType);

  @override
  List<Object> get props => [userType];
}
