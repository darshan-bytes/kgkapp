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

  TextFieldStyle get textFieldStyle;

  CheckboxStyle get checkboxStyle;
}

class PrimaryButtonStyle {
  final Color activeBackgroundColor;
  final Color disableBackgroundColor;
  final TextStyle titleStyle;
  final TextStyle disableTitleStyle;

  PrimaryButtonStyle({
    required this.activeBackgroundColor,
    required this.disableBackgroundColor,
    required this.titleStyle,
    required this.disableTitleStyle,
  });
}

class TextFieldStyle {
  final TextStyle textStyle;
  final Color blackColor;
  final TextStyle labelStyle;
  final TextStyle errorStyle;
  final Color textFillColor;
  final Color disabledTextFieldBorderColor;
  final Color enabledTextFieldBorderColor;
  final Color focusedTextFieldBorderColor;
  final Color errorBorderColor;
  final TextStyle hintStyle;

  TextFieldStyle({
    required this.textStyle,
    required this.blackColor,
    required this.labelStyle,
    required this.errorStyle,
    required this.textFillColor,
    required this.disabledTextFieldBorderColor,
    required this.enabledTextFieldBorderColor,
    required this.focusedTextFieldBorderColor,
    required this.errorBorderColor,
    required this.hintStyle,
  });
}

class CheckboxStyle {
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final TextStyle textStyle;

  CheckboxStyle({
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.textStyle,
  });
}
