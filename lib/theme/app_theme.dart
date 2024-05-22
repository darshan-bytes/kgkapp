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

  TabBarStyle get tabBarStyle;

  SplashScreenStyle get splashScreenStyle;

  CustomAppBarStyle get appBarStyle;

  SignInScreenStyle get signInScreenStyle;

  SmartRichTextStyle get smartRichTextStyle;
  
  CategoryTileStyle get categoryTileStyle;

  ForgotPasswordScreenStyle get forgotPasswordScreenStyle;
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

class TabBarStyle {
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Color indicatorColor;
  final Color backgroundColor;
  final Color borderColor;

  TabBarStyle({
    required this.labelStyle,
    required this.unselectedLabelStyle,
    required this.indicatorColor,
    required this.backgroundColor,
    required this.borderColor,
  });
}

class SplashScreenStyle {
  final TextStyle titleStyle;
  final Color activeBackgroundColor;
  final TextStyle skipTextStyle;

  SplashScreenStyle({
    required this.titleStyle,
    required this.skipTextStyle,
    required this.activeBackgroundColor,
  });
}

class CustomAppBarStyle {
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle titleStyle;

  CustomAppBarStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.borderColor,
  });
}

class SignInScreenStyle {
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final TextStyle subTitleStyle;
  final TextStyle lableStyle;
  final TextStyle forgotPasswordStyle;

  SignInScreenStyle({
    required this.lableStyle,
    required this.forgotPasswordStyle,
    required this.backgroundColor,
    required this.titleTextStyle,
    required this.subTitleStyle,
  });
}

class SmartRichTextStyle {
  final TextStyle textStyle;

  SmartRichTextStyle({required this.textStyle});
}

class ForgotPasswordScreenStyle {
  final TextStyle richSubTextStyle;
  final TextStyle resendTextStyle;
  final TextStyle didNotGetEmailTextStyle;

  ForgotPasswordScreenStyle({
    required this.richSubTextStyle,
    required this.resendTextStyle,
    required this.didNotGetEmailTextStyle,
  });
}

class CategoryTileStyle {
  final TextStyle lableStyle;
  final TextStyle detailStyle;
  final Color backgroundColor;
  final Color dividerLineColor;

  CategoryTileStyle({
    required this.lableStyle,
    required this.backgroundColor,
    required this.detailStyle,
    required this.dividerLineColor,
  });
} 
