import 'package:kgk/kgk.dart';

part 'preferences_event.dart';

part 'preferences_state.dart';

class PreferencesBloc extends Bloc<PreferencesEvent, PreferencesState> {
  bool isIntialized = false;
  List<CountryModel> countryList = [];
  List<LanguageDatum> languageList = [];
  List<CurrencyListModel> currencyList = [];

  CountryModel? selectedCountry;
  LanguageDatum? selectedLanguage;
  CurrencyListModel? selectedCurrency;

  PreferencesBloc() : super(PreferencesInitialState()) {
    on<PreferencesInitialEvent>(_onInitialEvent);
    on<PreferencesChangeCountryEvent>(_onChangeCountryEvent);
    on<PreferencesChangeLanguageEvent>(_onChangeLanguageEvent);
    on<PreferencesChangeCurrencyEvent>(_onChangeCurrencyEvent);
    on<PreferencesSaveEvent>(_onSaveEvent);
  }

  void _onInitialEvent(PreferencesInitialEvent event, Emitter<PreferencesState> emit) async {
    countryList.clear();
    currencyList.clear();

    countryList.add(CountryModel(name: "United States", code: "Usa"));
    countryList.add(CountryModel(name: "Afghanistan", code: "AF"));
    countryList.add(CountryModel(name: "India", code: "In"));
    countryList.add(CountryModel(name: "Australia", code: "AU"));

    if (!isIntialized) {
      await _fetchLanguageData(event, emit);
      isIntialized = true;
    }

    currencyList = StorageManager().getCurrencyList();

    selectedCountry = countryList.first;
    selectedLanguage = languageList.firstWhereOrNull((element) => element.mobileSymbol == (StorageManager().getLocale() ?? 'en'));
    selectedCurrency =
        currencyList.firstWhereOrNull((element) => element.id == StorageManager().getSelectedCurrency()?.id) ?? currencyList.firstOrNull;

    emit(PreferencesDataFetchedState());
    emit(PreferencesReloadState());
    emit(PreferencesChangeCountryState());
    emit(PreferencesChangeLanguageState());
    emit(PreferencesChangeCurrencyState());
  }

  Future<void> _fetchLanguageData(PreferencesInitialEvent event, Emitter<PreferencesState> emit) async {
    emit(PreferencesLoadingState());
    Map<String, dynamic> body = {
      ApiKey.filters: {ApiKey.dynamicObject: {}},
      ApiKey.pagination: {ApiKey.limit: 50, ApiKey.page: 1},
      ApiKey.search: "",
      ApiKey.sort: {ApiKey.field: "", ApiKey.dir: ""}
    };

    await AppRepository(event.context).getLanguageList(body: body).then((response) {
      response?.fold((l) {
        Utils.showMessage(l.message);
      }, (data) {
        languageList = data.languageData;
      });
    });
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

  Future<void> _onChangeCurrencyEvent(PreferencesChangeCurrencyEvent event, Emitter<PreferencesState> emit) async {
    emit(PreferencesReloadState());
    selectedCurrency = event.currency;
    emit(PreferencesChangeCurrencyState());
  }

  Future<void> _onSaveEvent(PreferencesSaveEvent event, Emitter<PreferencesState> emit) async {
    if (selectedCurrency != null) {
      /// Save the selected currency and its symbol to storage
      await StorageManager().setSelectedCurrency(selectedCurrency!);
      await StorageManager().setSelectedCurrencySymbol(selectedCurrency!.symbol ?? '');
    }
    BlocProvider.of<AppBloc>(event.context).add(
      LanguageChangedEvent(
        selectedLanguage,
        context: event.context,
        callback: () {
          event.context.pop();
          Utils.showMessage(
            APPStrings.preferencesSaved.tr,
          );
        },
      ),
    );
  }
}
