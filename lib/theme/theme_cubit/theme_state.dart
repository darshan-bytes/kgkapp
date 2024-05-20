part of 'theme_cubit.dart';

///[ThemeState] This abstract class use to ThemeState of main
abstract class ThemeState {
  final ThemeData themeData;

  ThemeState(this.themeData);
}

///[ThemeInitial] This class use to ThemeInitial of ThemeState
class ThemeInitial extends ThemeState {
  ThemeInitial(super.themeData);
}

class ThemeDataState extends ThemeState {
  ThemeDataState(super.themeData);
}
