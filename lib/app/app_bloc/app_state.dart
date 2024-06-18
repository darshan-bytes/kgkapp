part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();
}

final class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

final class ThemeDataState extends AppState {
  final ThemeData themeData;

  const ThemeDataState(this.themeData);

  @override
  List<Object> get props => [themeData];
}

final class ConnectivityState extends AppState {
  final bool isConnected;

  const ConnectivityState(this.isConnected);

  @override
  List<Object> get props => [isConnected];
}

final class LanguageState extends AppState {
  final Locale locale;

  const LanguageState(this.locale);

  @override
  List<Object> get props => [locale];
}

final class AppLoadingState extends AppState {
  final bool isLoading;

  const AppLoadingState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}
