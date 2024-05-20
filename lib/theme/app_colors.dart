import 'package:kgk/kgk.dart';

AppColor colors(BuildContext context) => Theme.of(context).colors;

/// To get Light and dark mode.[AppThemes]
class AppThemes {
  late ThemeData selectedColor;
  AppColor appColor = const AppColor(
    primary: Color(0xFF005568),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    text364A4E: Color(0xFF364A4E),
    bgColor: Color(0xFFF4FCFF),
    text123036: Color(0xFF123036),
    error: Color(0xffF65D3C),
    border009788: Color(0xFF009788),
    bgECECEC: Color(0xffECECEC),
    text9AB3B8: Color(0xff9AB3B8),
    bg009788: Color(0xff009788),
    text005668: Color(0xff005668),
    bg17BA77: Color(0xff17BA77),
    bgFFFAF6: Color(0xFFFFFAF6),
    text091E42: Color(0xFF091E42),
    borderF58220: Color(0xFFF58220),
    borderF3F3F3: Color(0xFFF3F3F3),
    border9AB3B8: Color(0xFF9AB3B8),
    bgf3f3f3: Color(0xfff3f3f3),
    bgD0E4E9: Color(0xffD0E4E9),
    textF58220: Color(0xffF58220),
    bg14005668: Color(0x14005668),
    bgF8F8F8: Color(0xffF8F8F8),
    bgFFF9F5: Color(0xFFFFF9F5),
    textC4D82E: Color(0xffC4D82E),
    text4BBE9F: Color(0xff4BBE9F),
    text6FC8C2: Color(0xff6FC8C2),
    text182125: Color(0xFF182125),
    bgF9FDFF: Color(0xFFF9FDFF),
    textC7AEB9: Color(0xFFC7AEB9),
    bgF3FFFC: Color(0xFFF3FFFC),
    bgFFF6E8: Color(0xFFFFF6E8),
    bgFAA41A: Color(0xFFFAA41A),
    border005568: Color(0xFF005568),
    bgFBFDE1: Color(0xFFFBFDE1),
    grey: Color(0xFF9E9E9E),
    bgF2FFFB: Color(0xFFF2FFFB),
    bgF4F9FA: Color(0xFFF4F9FA),
    bgFFF8F2: Color(0xFFFFF8F2),
    transparent: Color(0x00000000),
    bgDDD0BC: Color(0xFFDDD0BC),
    bgFFF0E4: Color(0xFFFFF0E4),
    bgFF8220: Color(0xFFFF8220),
    bgE9F3F8: Color(0xEBE9F3F8),
    text2F383D: Color(0xFF2F383D),
    bgFFCC00: Color(0xFFFFCC00),
  );

  ThemeData light({MaterialColor? theme}) {
    return ThemeData(
        useMaterial3: true,
        primaryColor: appColor.primary,
        scrollbarTheme: ScrollbarThemeData(
          trackColor: MaterialStateProperty.all(Colors.blue), // Change the track color here
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
  final Color black;
  final Color grey;
  final Color bgColor;
  final Color text364A4E;
  final Color text123036;
  final Color error;
  final Color border009788;
  final Color bgECECEC;
  final Color bg009788;
  final Color text9AB3B8;
  final Color text005668;
  final Color bg17BA77;
  final Color bgFFFAF6;
  final Color text091E42;
  final Color borderF58220;
  final Color borderF3F3F3;
  final Color border9AB3B8;
  final Color bgf3f3f3;
  final Color bgD0E4E9;
  final Color textF58220;
  final Color bg14005668;
  final Color bgF8F8F8;
  final Color bgFFF9F5;
  final Color textC4D82E;
  final Color text4BBE9F;
  final Color text6FC8C2;
  final Color text182125;
  final Color bgF9FDFF;
  final Color textC7AEB9;
  final Color bgF3FFFC;
  final Color bgFFF6E8;
  final Color bgFAA41A;
  final Color border005568;
  final Color bgFBFDE1;
  final Color bgF2FFFB;
  final Color bgF4F9FA;
  final Color bgFFF8F2;
  final Color transparent;
  final Color bgDDD0BC;
  final Color bgFFF0E4;
  final Color bgFF8220;
  final Color bgE9F3F8;
  final Color text2F383D;
  final Color bgFFCC00;

  const AppColor({
    required this.primary,
    required this.white,
    required this.black,
    required this.text364A4E,
    required this.bgColor,
    required this.text123036,
    required this.error,
    required this.border009788,
    required this.bgECECEC,
    required this.text9AB3B8,
    required this.bg009788,
    required this.text005668,
    required this.bg17BA77,
    required this.bgFFFAF6,
    required this.text091E42,
    required this.borderF58220,
    required this.borderF3F3F3,
    required this.border9AB3B8,
    required this.bgf3f3f3,
    required this.bgD0E4E9,
    required this.textF58220,
    required this.bg14005668,
    required this.bgF8F8F8,
    required this.bgF9FDFF,
    required this.textC4D82E,
    required this.text4BBE9F,
    required this.text6FC8C2,
    required this.bgFFF9F5,
    required this.text182125,
    required this.textC7AEB9,
    required this.bgF3FFFC,
    required this.bgFFF6E8,
    required this.bgFAA41A,
    required this.border005568,
    required this.bgFBFDE1,
    required this.grey,
    required this.bgF2FFFB,
    required this.bgF4F9FA,
    required this.bgFFF8F2,
    required this.transparent,
    required this.bgDDD0BC,
    required this.bgFF8220,
    required this.bgFFF0E4,
    required this.bgE9F3F8,
    required this.text2F383D,
    required this.bgFFCC00,
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
