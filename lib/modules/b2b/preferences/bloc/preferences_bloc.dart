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
    on<PreferencesSaveEvent>(_onSaveEvent);
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
    languageList.add(LanguageModel(name: "French", symbol: "fr"));

    StorageManager().getCurrencyList().forEach((element) {
      currencyList.add(CurrencyModel(name: "${element.name ?? ''} (${element.symbol ?? ''})"));
    });

    selectedCountry = countryList.first;
    selectedLanguage = languageList.firstWhereOrNull((element) => element.symbol == (StorageManager().getLocale() ?? 'en'));
    selectedCurrency =
        currencyList.firstWhereOrNull((element) => element.name == (StorageManager().getSelectedCurrency() ?? currencyList.first.name));

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
    if (selectedCurrency != null) {
      StorageManager().setSelectedCurrency(selectedCurrency!.name);
    }
    emit(PreferencesChangeCurrencyState());
  }

  void _onSaveEvent(PreferencesSaveEvent event, Emitter<PreferencesState> emit) {
    BlocProvider.of<AppBloc>(event.context).add(LanguageChangedEvent(selectedLanguage?.symbol ?? 'en', context: event.context));
  }
}
