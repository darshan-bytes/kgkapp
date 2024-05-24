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
        activeImageColor: colors.white,
        disableImageColor: colors.color8C8C8C,
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
  SignInScreenStyle get signInScreenStyle => SignInScreenStyle(
        backgroundColor: colors.white,
        titleTextStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        labelStyle: interRegularTextStyle,
        forgotPasswordStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        registerTextStyle: interRegularTextStyle.copyWith(color: colors.color083458),
      );

  @override
  SmartRichTextStyle get smartRichTextStyle => SmartRichTextStyle(textStyle: interRegularTextStyle);

  @override
  CategoryTileStyle get categoryTileStyle => CategoryTileStyle(
      backgroundColor: colors.colorF7F9FA,
      dividerLineColor: colors.colorD3DAE0,
      labelStyle: interMediumBoldTextStyle.copyWith(fontSize: 12),
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
      unselectedTabColor: colors.color8C8C8C);

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
      dividerColor: colors.colorD3DAE0);

  @override
  CollectionViewStyle get collectionViewStyle => CollectionViewStyle(
        headerBgColor: colors.colorC5DEEB,
        headerTitleStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color303538),
        headerSubTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32, color: colors.color303538),
        collectionListTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 28, color: colors.color303538),
      );

  @override
  SignUpStyle get signUpStyle => SignUpStyle(
        backgroundColor: colors.white,
        titleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        selectAccountStyle: interRegularTextStyle.copyWith(fontSize: 12),
        selectedAccountTypeColor: colors.primary,
        selectedAccountTypeBorderColor: colors.primary,
        selectedAccountTypeIconColor: colors.white,
        selectedAccountTypeTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16, color: colors.white),
        unselectedAccountTypeColor: colors.white,
        unselectedAccountTypeBorderColor: colors.colorD3DAE0,
        unselectedAccountTypeIconColor: colors.primary,
        unselectedAccountTypeTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16, color: colors.color303538),
      );

  @override
  RadioButtonStyle get radioButtonStyle => RadioButtonStyle(
        activeColor: colors.primary,
        checkColor: colors.white,
        borderColor: colors.colorD3DAE0,
        textStyle: interRegularTextStyle,
      );

  @override
  ProductItemStyle get productItemStyle => ProductItemStyle(
      backgroundColor: colors.white,
      productNameStyle: interRegularTextStyle,
      priceTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 14),
      discountTextStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color50B83C),
      productBackgroundColor: colors.colorFAFAFA,
      checkedPriceStyle: interRegularTextStyle.copyWith(
        fontSize: 12,
        color: colors.color8C8C8C,
        decoration: TextDecoration.lineThrough,
      ),
      borderColor: colors.colorD3DAE0,
      buttonTextStyle: interMediumBoldTextStyle.copyWith(color: colors.white, fontSize: 12),
      diamondTextStyle: interMediumBoldTextStyle.copyWith(color: colors.color8C8C8C, fontSize: 12),
      buttonWithIconTextStyle: interMediumBoldTextStyle.copyWith(color: colors.white, fontSize: 16));

  @override
  SmartDropDownStyle get smartDropDownStyle => SmartDropDownStyle(
        backgroundColor: colors.white,
        titleTextStyle: interSemiBoldTextStyle,
        borderColor: colors.colorD3DAE0,
        selectedBorderColor: colors.primary,
        unSelectedBorderColor: colors.colorD3DAE0,
        labelStyle: interSemiBoldTextStyle.copyWith(fontSize: 16, color: colors.color303538),
      );

  @override
  CustomPageIndicatorStyle get customPageIndicatorStyle => CustomPageIndicatorStyle(
        borderColor: colors.colorD3DAE0,
        textColor: colors.primary,
        textStyle: interRegularTextStyle.copyWith(fontSize: 16),
      );

  @override
  SortStyle get sortStyle => SortStyle(
        backgroundColor: colors.white,
        selectedBorderColor: colors.primary,
        titleStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        itemTitleStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color303538),
      );

  @override
  FilterStyle get filterStyle => FilterStyle(
        backgroundColor: colors.white,
        subFilterBackgroundColor: colors.colorF7F9FA,
        titleStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        selectedTitleStyle: interMediumBoldTextStyle.copyWith(fontSize: 14, color: colors.color303538),
        itemTitleStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        selectedItemTitleStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color303538),
        selectedBackgroundColor: colors.white,
        itemBorderColor: colors.colorD3DAE0,
        closeButtonBackgroundColor: colors.white,
        closeButtonStyle: interMediumBoldTextStyle.copyWith(fontSize: 16, color: colors.primary),
      );

  @override
  DiyProgressViewStyle get diyProgressViewStyle => DiyProgressViewStyle(
        indexStyle: interMediumBoldTextStyle.copyWith(fontSize: 18, color: colors.color303538),
        titleStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color303538),
        subTitleStyle: eBGaramondRegularTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 16, color: colors.color303538),
        selectedBorderColor: colors.color424445,
        unselectedBorderColor: colors.colorD3DAE0,
      );

  @override
  DiamondDetailScreenStyle get diamondDetailScreenStyle => DiamondDetailScreenStyle(
        skuStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        diamondNameStyle: eBGaramondMediumTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w400, color: colors.color303538),
        reviewStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        priceStyle: interBoldTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w500, color: colors.color303538),
        seeProductStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        orderSampleStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color303538),
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color8C8C8C),
        shippingStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color8C8C8C),
        selectDiamondStyle: interBoldTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: colors.white),
      );

  @override
  SettingDetailScreenStyle get settingDetailScreenStyle => SettingDetailScreenStyle(
        ringTypeStyle: interMediumBoldTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color8C8C8C),
        ringCodeStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        ringNameStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w400, color: colors.color303538),
        reviewStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        priceStyle: interBoldTextStyle.copyWith(fontSize: 24, fontWeight: FontWeight.w500, color: colors.color303538),
        metalHeaderStyle: interBoldTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
        metalNameStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        selectedMetalNameStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color303538),
        approxPriceLabelStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        approxPriceNoteStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        buyInBulkStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        askQuestionStyle: interRegularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color8C8C8C),
        shippingStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color8C8C8C),
        selectSettingStyle: interBoldTextStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: colors.white),
        settingTypeStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        settingValueStyle: interRegularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
        settingHeaderStyle: interRegularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
      );
  @override
  InquiryWidgetStyle get inquiryWidgetStyle => InquiryWidgetStyle(
        haveAQuestionStyle: interRegularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
        reachOutStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        phoneStyle: interRegularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
        emailStyle: interRegularTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: colors.color303538),
      );

  @override
  SelectionButtonStyle get selectionButtonStyle => SelectionButtonStyle(
      selectedButtonBorderColor: colors.primary,
      selectedButtonColor: colors.primary,
      selectedButtonIconColor: colors.white,
      selectedButtonTextStyle: interMediumBoldTextStyle.copyWith(color: colors.white),
      unselectedButtonBorderColor: colors.colorD3DAE0,
      unselectedButtonColor: colors.white,
      unselectedButtonIconColor: colors.primary,
      unselectedButtonTextStyle: interMediumBoldTextStyle.copyWith(
        color: colors.color303538,
      ));

  @override
  DiamondListingStyle get diamondListingStyle => DiamondListingStyle(
        gridIconColor: colors.primary,
        listIconColor: colors.color8C8C8C,
        filterProductCountTextStyle: interRegularTextStyle,
        gridBackgroundColor: colors.colorD3DAE0,
        gridBorderColor: colors.transparent,
        listBackgroundColor: colors.white,
        listBorderColor: colors.colorD3DAE0,
        menuBackgroundColor: colors.white,
        menuBorderColor: colors.colorD3DAE0,
      );

  @override
  FilterBottomActionBarStyle get filterBottomActionBarStyle => FilterBottomActionBarStyle(
        borderColor: colors.colorD3DAE0,
        transparentColor: colors.transparent,
        dividerColor: colors.colorD3DAE0,
      );

  @override
  CompleteProductStyle get completeProductStyle => CompleteProductStyle(
        productTypeStyle: interMediumBoldTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        productCodeStyle: interRegularTextStyle.copyWith(fontSize: 12, color: colors.color8C8C8C),
        dotColor: colors.color8C8C8C,
        productNameStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 20, color: colors.color303538),
        ratingGlowColor: colors.primary,
        priceStyle: interSemiBoldTextStyle.copyWith(fontSize: 20, color: colors.color303538),
        detailsHeaderStyle: interMediumBoldTextStyle.copyWith(fontSize: 14, color: colors.color303538),
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16, color: colors.color8C8C8C),
      );

  @override
  SelectedSettingsStyle get selectedSettingsStyle => SelectedSettingsStyle(
        iconColor: colors.primary,
        titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 16, color: colors.color303538),
        specialityStyle: interRegularTextStyle.copyWith(fontSize: 14, color: colors.color8C8C8C),
        changeTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16, color: colors.primary),
      );

  @override
  ImageCarouselStyle get imageCarouselStyle => ImageCarouselStyle(
        dotColor: colors.colorC5DEEB,
        selectedDotColor: colors.primary,
      );
}
