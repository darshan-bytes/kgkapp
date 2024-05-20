import 'package:kgk/kgk.dart';

class LightModeTheme extends AppTheme {
  final AppColor initcolors;

  LightModeTheme(this.initcolors);

  @override
  AppColor get colors => initcolors;

  @override
  TextStyle get interRegularTextStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.interRegular,
        color: colors.color303538,
      );

  @override
  TextStyle get interMediumBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.interRegular,
        color: colors.color303538,
      );

  @override
  TextStyle get interSemiBoldTextStyle =>
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: AppFonts.interRegular, color: colors.color303538);

  @override
  TextStyle get interBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.interRegular,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondRegularTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.eBGaramond,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondMediumTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.eBGaramond,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondSemiBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.eBGaramond,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.eBGaramond,
        color: colors.color303538,
      );

  @override
  PrimaryButtonStyle get primaryButtonStyle => PrimaryButtonStyle(
        titleStyle: interMediumBoldTextStyle.copyWith(
          color: colors.white,
          fontSize: 16,
        ),
        activeBackgroundColor: colors.primary,
        disableBackgroundColor: colors.colorF7F9FA,
        disableTitleStyle: interMediumBoldTextStyle.copyWith(
          color: colors.color8C8C8C,
          fontSize: 16,
        ),
      );

  @override
  TextFieldStyle get textFieldStyle => TextFieldStyle(
        textStyle: interRegularTextStyle,
        blackColor: colors.color303538,
        labelStyle: interRegularTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colors.color303538,
        ),
        errorStyle: interRegularTextStyle.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: colors.colorF65D3C,
        ),
        textFillColor: colors.white,
        disabledTextFieldBorderColor: colors.color303538,
        enabledTextFieldBorderColor: colors.colorD3DAE0,
        focusedTextFieldBorderColor: colors.primary,
        errorBorderColor: colors.colorF65D3C,
        hintStyle: interRegularTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: colors.color303538,
        ),
      );

  @override
  CheckboxStyle get checkboxStyle => CheckboxStyle(
        activeColor: colors.primary,
        checkColor: colors.white,
        borderColor: colors.colorD3DAE0,
        textStyle: interRegularTextStyle,
      );
}
