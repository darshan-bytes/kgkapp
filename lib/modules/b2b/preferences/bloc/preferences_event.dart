part of 'preferences_bloc.dart';

sealed class PreferencesEvent extends Equatable {
  const PreferencesEvent();
}

class PreferencesInitialEvent extends PreferencesEvent {
  @override
  List<Object> get props => [];
}

class PreferencesReloadEvent extends PreferencesEvent {
  @override
  List<Object> get props => [];
}

class PreferencesChangeCountryEvent extends PreferencesEvent {
  final CountryModel country;

  const PreferencesChangeCountryEvent(this.country);

  @override
  List<Object> get props => [country];
}

class PreferencesChangeLanguageEvent extends PreferencesEvent {
  final LanguageModel language;

  const PreferencesChangeLanguageEvent(this.language);

  @override
  List<Object> get props => [language];
}

class PreferencesChangeCurrencyEvent extends PreferencesEvent {
  final CurrencyModel currency;

  const PreferencesChangeCurrencyEvent(this.currency);

  @override
  List<Object> get props => [currency];
}
