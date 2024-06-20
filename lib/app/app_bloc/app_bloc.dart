import 'package:kgk/kgk.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppThemes appThemes = AppThemes();
  bool languageSwitch = false;
  final Connectivity _connectivity = Connectivity();
  late Stream<List<ConnectivityResult>> _connectivityStream;
  ThemeData? themeData;
  Locale locale = const Locale(APPStrings.languageEn);

  bool isLoading = false;

  UserType userType = UserType.b2cUser;

  AppBloc() : super(AppInitial()) {
    on<LoadAppEvent>(_onLoadAppEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
    on<ConnectivityChangedEvent>(_onConnectivityChangedEvent);
    on<LanguageChangedEvent>(_onLanguageChangedEvent);
    on<SetAppLoadingEvent>(_onSetLoadingEvent);
    on<SetUserTypeEvent>(_onSetUserTypeEvent);
  }

  void _onLoadAppEvent(LoadAppEvent event, Emitter<AppState> emit) async {
    _connectivityStream = _connectivity.onConnectivityChanged;
    _connectivityStream.listen((result) {
      bool isConnected = result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi) ||
          result.contains(ConnectivityResult.ethernet);
      add(ConnectivityChangedEvent(isConnected));
    });

    final String theme = StorageManager().getThemeData();
    debugPrint("theme $theme");
    if (theme == 'dark') {
      languageSwitch = true;
      themeData = appThemes.dark();
      emit(ThemeDataState(appThemes.dark()));
    } else if (theme == 'light') {
      languageSwitch = false;
      themeData = appThemes.light();
      emit(ThemeDataState(appThemes.light()));
    } else if (theme == 'system') {
      //TODO: Need to change based on system theme
    }
  }

  void _onChangeThemeEvent(ChangeThemeEvent event, Emitter<AppState> emit) async {
    String theme = event.theme;
    if (theme == 'dark') {
      await setThemeDataDark(emit);
    } else if (theme == 'light') {
      await setThemeDataLight(emit);
    } else if (theme == 'system') {
      bool systemTheme = StorageManager().getSystemTheme();
      //TODO: Need to change based on system theme
      if (systemTheme) {
        await setThemeDataDark(emit);
      } else {
        await setThemeDataLight(emit);
      }
    }
  }

  Future<void> setThemeDataDark(Emitter<AppState> emit) async {
    themeData = appThemes.dark();
    await StorageManager().setThemeData('dark');
    languageSwitch = true;
    emit(ThemeDataState(appThemes.dark()));
  }

  Future<void> setThemeDataLight(Emitter<AppState> emit) async {
    themeData = appThemes.light();
    await StorageManager().setThemeData('light');
    languageSwitch = false;
    emit(ThemeDataState(appThemes.light()));
  }

  void _onConnectivityChangedEvent(ConnectivityChangedEvent event, Emitter<AppState> emit) {
    emit(ConnectivityState(event.connectivityResult));
  }

  Future<void> _onLanguageChangedEvent(LanguageChangedEvent event, Emitter<AppState> emit) async {
    if (event.languageCode.isNotEmpty) {
      await StorageManager().setLocale(event.languageCode);
    }
    await AppLocalizations.of(getNavigatorKeyContext)?.changeLocale();
    locale = AppLocalizations.of(getNavigatorKeyContext)?.locale ?? const Locale(APPStrings.languageEn);
    if (locale.languageCode == APPStrings.languageEn) {
      languageSwitch = false;
    } else {
      languageSwitch = true;
    }
    emit(LanguageState(locale));
  }

  void _onSetLoadingEvent(SetAppLoadingEvent event, Emitter<AppState> emit) {
    isLoading = event.isLoading;
    emit(AppLoadingState(isLoading));
  }

  void _onSetUserTypeEvent(SetUserTypeEvent event, Emitter<AppState> emit) {
    userType = event.userType;
    emit(UserTypeState(userType));
  }
}
