import 'package:kgk/kgk.dart';

part 'theme_state.dart';

///[ThemeCubit] This class use to App Theme Cubit
///[ThemeInitial] This is the state of ThemeCubit
class ThemeCubit extends Cubit<ThemeState> {
  final AppThemes appThemes = AppThemes();
  bool switchValue = false;

  ThemeCubit() : super(ThemeInitial(AppThemes().light()));

  Future<void> setThemeDataDark() async {
    await StorageManager().setThemeData('dark');
    switchValue = true;
    emit(ThemeDataState(appThemes.dark()));
  }

  Future<void> setThemeDataLight() async {
    // await Hive.box('themeBox').put('themeData', 'light');
    await StorageManager().setThemeData('light');
    switchValue = false;
    emit(ThemeDataState(appThemes.light()));
  }

  ///[getTheme] This method use to ThemeData of current app
  void getTheme() {
    final String theme = StorageManager().getThemeData();
    if (theme == 'dark') {
      switchValue = true;
      emit(ThemeDataState(appThemes.dark()));
    } else if (theme == 'light') {
      switchValue = false;
      emit(ThemeDataState(appThemes.light()));
    }
  }
}
