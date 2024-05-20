import 'package:kgk/kgk.dart';

AppColor colors(BuildContext context) => Theme.of(context).colors;

/// To get Light and dark mode.[AppThemes]
class AppThemes {
  late ThemeData selectedColor;
  AppColor appColor = const AppColor(
    primary: Color(0xFF083458),
    white: Color(0xFFFFFFFF),
    color303538: Color(0xFF303538),
  );

  ThemeData light({MaterialColor? theme}) {
    return ThemeData(
        useMaterial3: true,
        primaryColor: appColor.primary,
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
          trackColor: MaterialStateProperty.all(Colors.blue), // Change the track color here
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
  final Color color303538;

  const AppColor({
    required this.primary,
    required this.white,
    required this.color303538,
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
