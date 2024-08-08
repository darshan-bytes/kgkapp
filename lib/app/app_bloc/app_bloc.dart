import 'package:kgk/kgk.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppThemes appThemes = AppThemes();
  final Connectivity _connectivity = Connectivity();
  late Stream<List<ConnectivityResult>> _connectivityStream;
  List<Locale> supportedLocales = const [
    Locale(APPStrings.languageEn, ''), // English
    Locale(APPStrings.languageFr, ''),
    Locale(APPStrings.languageHi, ''),
  ];
  List<LocalizationsDelegate<Object>> localizationsDelegates = const [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    AppLocalizations.delegate,
    CountryLocalizations.delegate,
  ];
  ThemeData? themeData;
  Locale locale = const Locale(APPStrings.languageEn);

  bool isLoading = false;

  UserType userType = UserType.b2cUser;

  int notificationCount = 1;

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
      themeData = appThemes.dark();
      emit(ThemeDataState(appThemes.dark()));
    } else if (theme == 'light') {
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
    emit(ThemeDataState(appThemes.dark()));
  }

  Future<void> setThemeDataLight(Emitter<AppState> emit) async {
    themeData = appThemes.light();
    await StorageManager().setThemeData('light');
    emit(ThemeDataState(appThemes.light()));
  }

  void _onConnectivityChangedEvent(ConnectivityChangedEvent event, Emitter<AppState> emit) {
    emit(ConnectivityState(event.connectivityResult));
  }

  Future<void> _onLanguageChangedEvent(LanguageChangedEvent event, Emitter<AppState> emit) async {
    if (event.languageCode.isNotEmpty) {
      await StorageManager().setLocale(event.languageCode);
      await _languageLabelApiCall(event.context);
    }
    await AppLocalizations.of(getNavigatorKeyContext)?.changeLocale();
    locale = AppLocalizations.of(getNavigatorKeyContext)?.locale ?? const Locale(APPStrings.languageEn);
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

  Future<void> _languageLabelApiCall(BuildContext context) async {
    await UserRepository(context).getLanguageLabels(showLoader: true).then((value) async {
      await value?.fold((l) {
        Utils.showMessage(l.message ?? '');
      }, (r) async {
        StorageManager().setLanguageLabels(r.responseData);
      });
    });
  }
}

extension LoadingExtension on BuildContext {
  void setAppLoading(bool isLoading) {
    BlocProvider.of<AppBloc>(this).add(SetAppLoadingEvent(isLoading));
  }
}
