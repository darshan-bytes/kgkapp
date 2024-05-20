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
        fontWeight: FontWeight.w500,
        color: colors.white,
      ),
      activeBackgroundColor: colors.primary,
      disableBackgroundColor: colors.color303538);
}
