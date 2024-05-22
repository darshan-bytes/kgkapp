import 'package:kgk/kgk.dart';

class LightModeTheme extends AppTheme {
  final AppColor initColors;

  LightModeTheme(this.initColors);

  @override
  AppColor get colors => initColors;

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
        fontFamily: AppFonts.interMedium,
        color: colors.color303538,
      );

  @override
  TextStyle get interSemiBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.interSemiBold,
        color: colors.color303538,
      );

  @override
  TextStyle get interBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.interBold,
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
        fontFamily: AppFonts.eBGaramondMedium,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondSemiBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.eBGaramondSemiBold,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondBoldTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.eBGaramondBold,
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

  @override
  TabBarStyle get tabBarStyle => TabBarStyle(
        unselectedLabelStyle: interMediumBoldTextStyle.copyWith(
          fontSize: 12,
          color: colors.color8C8C8C,
        ),
        labelStyle: interMediumBoldTextStyle.copyWith(
          fontSize: 12,
          color: colors.color303538,
        ),
        indicatorColor: colors.primary,
        backgroundColor: colors.white,
        borderColor: colors.colorD3DAE0,
      );

  @override
  SplashScreenStyle get splashScreenStyle => SplashScreenStyle(
        skipTextStyle: interMediumBoldTextStyle.copyWith(color: colors.white, fontSize: 16),
        titleStyle: interMediumBoldTextStyle,
        activeBackgroundColor: colors.white,
      );

  @override
  CustomAppBarStyle get appBarStyle => CustomAppBarStyle(
        backgroundColor: colors.colorF7F9FA,
        titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 18),
        borderColor: colors.colorD3DAE0,
      );

  @override
  // TODO: implement signInScreenStyle
  SignInScreenStyle get signInScreenStyle => SignInScreenStyle(
        backgroundColor: colors.white,
        titleTextStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        lableStyle: interRegularTextStyle,
        forgotPasswordStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
      );

  @override
  SmartRichTextStyle get smartRichTextStyle =>
      SmartRichTextStyle(textStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color111620));

  // TODO: implement categoryTileStyle
  CategoryTileStyle get categoryTileStyle => CategoryTileStyle(
      backgroundColor: colors.colorF7F9FA,
      dividerLineColor: colors.colorD3DAE0,
      lableStyle: interMediumBoldTextStyle.copyWith(fontSize: 12),
      detailStyle: interMediumBoldTextStyle.copyWith(fontSize: 16));


  @override
  ForgotPasswordScreenStyle get forgotPasswordScreenStyle => ForgotPasswordScreenStyle(
      richSubTextStyle: interSemiBoldTextStyle,
      resendTextStyle: interMediumBoldTextStyle.copyWith(color: colors.color083458),
      didNotGetEmailTextStyle: interRegularTextStyle);

  @override
  NotificationScreenStyle get notificationScreenStyle => NotificationScreenStyle(
    tabTitleStyle: interBoldTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14),
    selectedTabColor: colors.color303538,
    unselectedTabColor: colors.color8C8C8C
  );

  @override
  AllNotificationViewStyle get allNotificationViewStyle => AllNotificationViewStyle(
      titleStyle: interBoldTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: colors.color303538),
      descStyle: interRegularTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: colors.color303538),
      timeLabelStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
      dotColor: colors.primary,
      searchHintStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color8C8C8C),
  );

  @override
  SettingViewStyle get settingViewStyle => SettingViewStyle(
    titleStyle: interBoldTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16, color: colors.color303538),
    descStyle: interRegularTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14, color: colors.color8C8C8C),
    thumbColor: colors.white,
    dividerColor: colors.colorD3DAE0
  );
}
