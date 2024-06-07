import 'package:kgk/kgk.dart';

AppColor colors(BuildContext context) => Theme.of(context).colors;

/// To get Light and dark mode.[AppThemes]
class AppThemes {
  late ThemeData selectedColor;
  AppColor appColor = const AppColor(
    primary: Color(0xFF083458),
    white: Color(0xFFFFFFFF),
    transparent: Color(0x00000000),
    colorF65D3C: Color(0xFFF65D3C),
    color303538: Color(0xFF303538),
    colorD3DAE0: Color(0xFFD3DAE0),
    colorF7F9FA: Color(0xFFF7F9FA),
    color8C8C8C: Color(0xFF8C8C8C),
    color083458: Color(0xFF083458),
    colorECF4F9: Color(0xFFECF4F9),
    color111620: Color(0xFF111620),
    colorC5DEEB: Color(0xFFC5DEEB),
    color50B83C: Color(0xFF50B83C),
    colorFAFAFA: Color(0xFFFAFAFA),
    color424445: Color(0xFF424445),
    color8C98A8: Color(0xFF8C98A8),
    colorF8F8F8: Color(0xFFF8F8F8),
    color4885A3: Color(0xFF4885A3),
    colorDDECF4: Color(0xFFDDECF4),
    color64636D: Color(0xFF64636D),
    color9DCAE0: Color(0xFF9DCAE0),
    black: Color(0xFF000000),
  );

  ThemeData light({MaterialColor? theme}) {
    return ThemeData(
        useMaterial3: true,
        primaryColor: appColor.primary,
        scaffoldBackgroundColor: Colors.white,
        dividerTheme: DividerThemeData(color: appColor.colorD3DAE0, space: 1.h),
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStateProperty.all(Colors.blue), // Change the track color here
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: appColor.primary),
        textSelectionTheme: const TextSelectionThemeData(
            //TODO: will update this.
            // cursorColor: appColor.bg7AD6FF,
            // selectionColor: appColor.bg7AD6FF,
            // selectionHandleColor: appColor.bg7AD6FF,
            ))
      ..addThemeConfig(appColor);
  }

  ThemeData dark({MaterialColor? theme}) {
    return ThemeData(
        useMaterial3: true,
        primaryColor: appColor.primary,
        scrollbarTheme: ScrollbarThemeData(
          trackColor: WidgetStateProperty.all(Colors.blue), // Change the track color here
        ),
        scaffoldBackgroundColor: Colors.grey,
        colorScheme: ColorScheme.fromSeed(seedColor: appColor.primary),
        textSelectionTheme: const TextSelectionThemeData(
            //TODO: will update this.
            // cursorColor: appColor.bg7AD6FF,
            // selectionColor: appColor.bg7AD6FF,
            // selectionHandleColor: appColor.bg7AD6FF,
            ))
      ..addThemeConfig(appColor);
  }
}

class AppColor {
  final Color primary;
  final Color white;
  final Color black;
  final Color transparent;
  final Color colorF65D3C;
  final Color color303538;
  final Color colorD3DAE0;
  final Color colorF7F9FA;
  final Color color8C8C8C;
  final Color color083458;
  final Color color111620;
  final Color colorECF4F9;
  final Color colorC5DEEB;
  final Color color50B83C;
  final Color colorFAFAFA;
  final Color color424445;
  final Color color8C98A8;
  final Color colorF8F8F8;
  final Color color4885A3;
  final Color colorDDECF4;
  final Color color64636D;
  final Color color9DCAE0;

  const AppColor({
    required this.primary,
    required this.white,
    required this.colorF65D3C,
    required this.color303538,
    required this.colorD3DAE0,
    required this.colorF7F9FA,
    required this.color8C8C8C,
    required this.color083458,
    required this.colorECF4F9,
    required this.color111620,
    required this.colorC5DEEB,
    required this.color50B83C,
    required this.colorFAFAFA,
    required this.color424445,
    required this.transparent,
    required this.color8C98A8,
    required this.colorF8F8F8,
    required this.color4885A3,
    required this.colorDDECF4,
    required this.color64636D,
    required this.color9DCAE0,
    required this.black,
  });
}

extension ThemeDataExtensions on ThemeData {
  static final Map<InputDecorationTheme, AppColor> _colors = {};

  void addThemeConfig(AppColor theme) {
    _colors[inputDecorationTheme] = theme;
  }

  static AppColor? empty;

  // AppThemeData get  theme => _themeData[inputDecorationTheme] ?? AppThemeData.empty();
  AppColor get colors => _colors[inputDecorationTheme]!;
}
