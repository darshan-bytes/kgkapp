import 'package:kgk/kgk.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AppThemes appThemes = AppThemes();
  bool switchValue = false;
  final Connectivity _connectivity = Connectivity();
  late Stream<List<ConnectivityResult>> _connectivityStream;
  ThemeData? themeData;

  AppBloc() : super(AppInitial()) {
    on<LoadAppEvent>(_onLoadAppEvent);
    on<ChangeThemeEvent>(_onChangeThemeEvent);
    on<ConnectivityChangedEvent>(_onConnectivityChangedEvent);
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
      switchValue = true;
      themeData = appThemes.dark();
      emit(ThemeDataState(appThemes.dark()));
    } else if (theme == 'light') {
      switchValue = false;
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
    switchValue = true;
    emit(ThemeDataState(appThemes.dark()));
  }

  Future<void> setThemeDataLight(Emitter<AppState> emit) async {
    themeData = appThemes.light();
    await StorageManager().setThemeData('light');
    switchValue = false;
    emit(ThemeDataState(appThemes.light()));
  }

  void _onConnectivityChangedEvent(ConnectivityChangedEvent event, Emitter<AppState> emit) {
    emit(ConnectivityState(event.connectivityResult));
  }
}
