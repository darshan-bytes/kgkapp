part of 'preferences_bloc.dart';

sealed class PreferencesState extends Equatable {
  const PreferencesState();
}

final class PreferencesInitialState extends PreferencesState {
  @override
  List<Object> get props => [];
}

final class PreferencesReloadState extends PreferencesState {
  @override
  List<Object> get props => [];
}

final class PreferencesChangeCountryState extends PreferencesState {
  @override
  List<Object> get props => [];
}

final class PreferencesChangeLanguageState extends PreferencesState {
  @override
  List<Object> get props => [];
}

final class PreferencesChangeCurrencyState extends PreferencesState {
  @override
  List<Object> get props => [];
}

final class PreferencesLoadingState extends PreferencesState {
  @override
  List<Object> get props => [];
}

final class PreferencesDataFetchedState extends PreferencesState {
  @override
  List<Object> get props => [];
}
