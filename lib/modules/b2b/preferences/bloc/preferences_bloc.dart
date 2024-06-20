import 'package:kgk/kgk.dart';

part 'preferences_event.dart';

part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  List<CountryModel> countryList = [];
  List<LanguageModel> languageList = [];
  List<CurrencyModel> currencyList = [];

  CountryModel? selectedCountry;
  LanguageModel? selectedLanguage;
  CurrencyModel? selectedCurrency;

  PreferencesBloc() : super(PreferencesInitialState()) {
    on<PreferencesInitialEvent>(_onInitialEvent);
    on<PreferencesChangeCountryEvent>(_onChangeCountryEvent);
    on<PreferencesChangeLanguageEvent>(_onChangeLanguageEvent);
    on<PreferencesChangeCurrencyEvent>(_onChangeCurrencyEvent);
  }

  void _onInitialEvent(PreferencesInitialEvent event, Emitter<PreferencesState> emit) {
    countryList.clear();
    languageList.clear();
    currencyList.clear();

    countryList.add(CountryModel(name: "United States", code: "Usa"));
    countryList.add(CountryModel(name: "Afghanistan", code: "AF"));
    countryList.add(CountryModel(name: "India", code: "In"));
    countryList.add(CountryModel(name: "Australia", code: "AU"));

    languageList.add(LanguageModel(name: "English", symbol: "en"));
    languageList.add(LanguageModel(name: "Hindi", symbol: "hi"));
    languageList.add(LanguageModel(name: "Spanish", symbol: "es"));
    languageList.add(LanguageModel(name: "French", symbol: "fr"));

    currencyList.add(CurrencyModel(name: "Dollar (\$)"));
    currencyList.add(CurrencyModel(name: "Pound (£)"));
    currencyList.add(CurrencyModel(name: "Euro (€)"));
    currencyList.add(CurrencyModel(name: "Rupee (₹)"));

    selectedCountry = countryList.first;
    selectedLanguage = languageList.first;
    selectedCurrency = currencyList.first;

    emit(PreferencesReloadState());
    emit(PreferencesChangeCountryState());
    emit(PreferencesChangeLanguageState());
    emit(PreferencesChangeCurrencyState());
  }

  void _onChangeCountryEvent(PreferencesChangeCountryEvent event, Emitter<PreferencesState> emit) {
    emit(PreferencesReloadState());
    selectedCountry = event.country;
    emit(PreferencesChangeCountryState());
  }

  void _onChangeLanguageEvent(PreferencesChangeLanguageEvent event, Emitter<PreferencesState> emit) {
    emit(PreferencesReloadState());
    selectedLanguage = event.language;
    emit(PreferencesChangeLanguageState());
  }

  void _onChangeCurrencyEvent(PreferencesChangeCurrencyEvent event, Emitter<PreferencesState> emit) {
    emit(PreferencesReloadState());
    selectedCurrency = event.currency;
    emit(PreferencesChangeCurrencyState());
  }
}
