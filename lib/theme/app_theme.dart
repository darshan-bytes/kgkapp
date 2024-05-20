import 'package:kgk/kgk.dart';

//AppStyle
abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    return LightModeTheme(Theme.of(context).colors);
  }

  AppColor get colors;

  TextStyle get interRegularTextStyle;

  TextStyle get interMediumBoldTextStyle;

  TextStyle get interSemiBoldTextStyle;

  TextStyle get interBoldTextStyle;

  TextStyle get eBGaramondRegularTextStyle;

  TextStyle get eBGaramondMediumTextStyle;

  TextStyle get eBGaramondSemiBoldTextStyle;

  TextStyle get eBGaramondBoldTextStyle;

  PrimaryButtonStyle get primaryButtonStyle;
}

class PrimaryButtonStyle {
  final Color activeBackgroundColor;
  final Color disableBackgroundColor;
  final TextStyle titleStyle;

  PrimaryButtonStyle({
    required this.activeBackgroundColor,
    required this.disableBackgroundColor,
    required this.titleStyle,
  });
}
