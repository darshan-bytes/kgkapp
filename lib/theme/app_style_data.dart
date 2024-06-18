import 'package:kgk/kgk.dart';

class LightModeTheme extends AppTheme {
  final AppColor initColors;

  LightModeTheme(this.initColors);

  @override
  AppColor get colors => initColors;

  @override
  TextStyle get interRegularTextStyle => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.interRegular,
        color: colors.color303538,
      );

  @override
  TextStyle get interMediumBoldTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.interMedium,
        color: colors.color303538,
      );

  @override
  TextStyle get interSemiBoldTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.interSemiBold,
        color: colors.color303538,
      );

  @override
  TextStyle get interBoldTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.interBold,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondRegularTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.eBGaramond,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondMediumTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.eBGaramondMedium,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondSemiBoldTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.eBGaramondSemiBold,
        color: colors.color303538,
      );

  @override
  TextStyle get eBGaramondBoldTextStyle => TextStyle(
        fontSize: 16.0.sp,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.eBGaramondBold,
        color: colors.color303538,
      );

  @override
  PrimaryButtonStyle get primaryButtonStyle => PrimaryButtonStyle(
        titleStyle: interMediumBoldTextStyle.copyWith(
          color: colors.white,
          fontSize: 16.sp,
        ),
        activeBackgroundColor: colors.primary,
        disableBackgroundColor: colors.colorF7F9FA,
        disableTitleStyle: interMediumBoldTextStyle.copyWith(
          color: colors.color8C8C8C,
          fontSize: 16.sp,
        ),
        activeImageColor: colors.white,
        disableImageColor: colors.color8C8C8C,
      );

  @override
  TextFieldStyle get textFieldStyle => TextFieldStyle(
        textStyle: interRegularTextStyle,
        blackColor: colors.color303538,
        labelStyle: interRegularTextStyle.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: colors.color303538,
        ),
        errorStyle: interRegularTextStyle.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          color: colors.colorF65D3C,
        ),
        textFillColor: colors.white,
        disabledTextFieldBorderColor: colors.color303538,
        enabledTextFieldBorderColor: colors.colorD3DAE0,
        focusedTextFieldBorderColor: colors.primary,
        errorBorderColor: colors.colorF65D3C,
        hintStyle: interRegularTextStyle.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: colors.color8C8C8C,
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
          fontSize: 12.sp,
          color: colors.color8C8C8C,
        ),
        labelStyle: interMediumBoldTextStyle.copyWith(
          fontSize: 12.sp,
          color: colors.color303538,
        ),
        indicatorColor: colors.primary,
        backgroundColor: colors.white,
        borderColor: colors.colorD3DAE0,
        boxShadowColor: colors.black.withOpacity(0.17),
      );

  @override
  SplashScreenStyle get splashScreenStyle => SplashScreenStyle(
        skipTextStyle: interMediumBoldTextStyle.copyWith(color: colors.white, fontSize: 16.sp),
        titleStyle: interMediumBoldTextStyle,
        activeBackgroundColor: colors.white,
      );

  @override
  CustomAppBarStyle get appBarStyle => CustomAppBarStyle(
        backgroundColor: colors.colorF7F9FA,
        titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 18.sp),
        borderColor: colors.colorD3DAE0,
        transparentColor: colors.transparent,
        searchBarTextStyle: interRegularTextStyle,
      );

  @override
  SignInScreenStyle get signInScreenStyle => SignInScreenStyle(
        backgroundColor: colors.white,
        titleTextStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32.sp),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
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
      labelStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp),
      detailStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp));

  @override
  ForgotPasswordScreenStyle get forgotPasswordScreenStyle => ForgotPasswordScreenStyle(
      richSubTextStyle: interSemiBoldTextStyle,
      resendTextStyle: interMediumBoldTextStyle.copyWith(color: colors.color083458),
      didNotGetEmailTextStyle: interRegularTextStyle);

  @override
  NotificationScreenStyle get notificationScreenStyle => NotificationScreenStyle(
      tabTitleStyle: interBoldTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
      selectedTabColor: colors.color303538,
      unselectedTabColor: colors.color8C8C8C);

  @override
  AllNotificationViewStyle get allNotificationViewStyle => AllNotificationViewStyle(
        titleStyle: interBoldTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: colors.color303538),
        descStyle: interRegularTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: colors.color303538),
        timeLabelStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        dotColor: colors.primary,
        searchHintStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
      );

  @override
  SettingViewStyle get settingViewStyle => SettingViewStyle(
      titleStyle: interBoldTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 16.sp, color: colors.color303538),
      descStyle: interRegularTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 14.sp, color: colors.color8C8C8C),
      thumbColor: colors.white,
      dividerColor: colors.colorD3DAE0);

  @override
  CollectionViewStyle get collectionViewStyle => CollectionViewStyle(
        headerBgColor: colors.colorC5DEEB,
        headerTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        headerSubTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32.sp, color: colors.color303538),
        collectionListTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 28.sp, color: colors.color303538),
      );

  @override
  SignUpStyle get signUpStyle => SignUpStyle(
        backgroundColor: colors.white,
        titleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32.sp),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        selectAccountStyle: interRegularTextStyle.copyWith(fontSize: 12.sp),
        selectedAccountTypeColor: colors.primary,
        selectedAccountTypeBorderColor: colors.primary,
        selectedAccountTypeIconColor: colors.white,
        selectedAccountTypeTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.white),
        unselectedAccountTypeColor: colors.white,
        unselectedAccountTypeBorderColor: colors.colorD3DAE0,
        unselectedAccountTypeIconColor: colors.primary,
        unselectedAccountTypeTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
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
        priceTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp),
        discountTextStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color50B83C),
        productBackgroundColor: colors.colorFAFAFA,
        checkedPriceStyle: interRegularTextStyle.copyWith(
          fontSize: 12.sp,
          color: colors.color8C8C8C,
          decoration: TextDecoration.lineThrough,
        ),
        borderColor: colors.colorD3DAE0,
        buttonTextStyle: interMediumBoldTextStyle.copyWith(color: colors.white, fontSize: 12.sp),
        diamondTextStyle: interMediumBoldTextStyle.copyWith(color: colors.color8C8C8C, fontSize: 12.sp),
        buttonWithIconTextStyle: interMediumBoldTextStyle.copyWith(
          color: colors.white,
          fontSize: 16.sp,
        ),
        transparentColor: colors.transparent,
        removeBagTextStyle: interMediumBoldTextStyle.copyWith(color: colors.color083458),
        myBagDividerColor: colors.colorD3DAE0,
        outOfStockBackgroundColor: colors.colorDDECF4,
        outOfStockStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp),
      );

  @override
  SmartDropDownStyle get smartDropDownStyle => SmartDropDownStyle(
        backgroundColor: colors.white,
        titleTextStyle: interSemiBoldTextStyle,
        borderColor: colors.colorD3DAE0,
        selectedBorderColor: colors.primary,
        unSelectedBorderColor: colors.colorD3DAE0,
        labelStyle: interSemiBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        selectedTitleTextStyle: interSemiBoldTextStyle.copyWith(color: colors.white),
      );

  @override
  CustomPageIndicatorStyle get customPageIndicatorStyle => CustomPageIndicatorStyle(
        dropDownBackgroundColor: colors.white,
        borderColor: colors.colorD3DAE0,
        textColor: colors.primary,
        textStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
      );

  @override
  SortStyle get sortStyle => SortStyle(
        backgroundColor: colors.white,
        selectedBorderColor: colors.primary,
        titleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        itemTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
      );

  @override
  FilterStyle get filterStyle => FilterStyle(
        backgroundColor: colors.white,
        subFilterBackgroundColor: colors.colorF7F9FA,
        titleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        selectedTitleStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        itemTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        selectedItemTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        selectedBackgroundColor: colors.white,
        itemBorderColor: colors.colorD3DAE0,
        closeButtonBackgroundColor: colors.white,
        closeButtonStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.primary),
        selectedImageColor: colors.primary,
        advancedFilterBackgroundColor: colors.colorD3DAE0,
        advancedFilterTitleStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp, color: colors.color303538),
      );

  @override
  DiyProgressViewStyle get diyProgressViewStyle => DiyProgressViewStyle(
        indexStyle: interMediumBoldTextStyle.copyWith(fontSize: 18.sp, color: colors.color303538),
        titleStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color303538),
        subTitleStyle: eBGaramondRegularTextStyle.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp, color: colors.color303538),
        selectedBorderColor: colors.color424445,
        unselectedBorderColor: colors.colorD3DAE0,
      );

  @override
  DiamondDetailScreenStyle get diamondDetailScreenStyle => DiamondDetailScreenStyle(
        skuStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        diamondNameStyle: eBGaramondMediumTextStyle.copyWith(fontSize: 28.sp, fontWeight: FontWeight.w400, color: colors.color303538),
        reviewStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        priceStyle: interBoldTextStyle.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500, color: colors.color303538),
        seeProductStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        orderSampleStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color303538),
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        shippingStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        selectDiamondStyle: interBoldTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: colors.white),
      );

  @override
  SettingDetailScreenStyle get settingDetailScreenStyle => SettingDetailScreenStyle(
        ringTypeStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.color8C8C8C),
        ringCodeStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        ringNameStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 28.sp, fontWeight: FontWeight.w400, color: colors.color303538),
        reviewStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        priceStyle: interBoldTextStyle.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w500, color: colors.color303538),
        metalHeaderStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.color303538),
        metalNameStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        selectedMetalNameStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        approxPriceLabelStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        approxPriceNoteStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        buyInBulkStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        askQuestionStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.color303538),
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        shippingStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        selectSettingStyle: interBoldTextStyle.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, color: colors.white),
        settingTypeStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        settingValueStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        settingHeaderStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500, color: colors.color303538),
        settingSelectionButtonColor: colors.colorF8F8F8,
        selectedSettingBorderColor: colors.primary,
        selectedSettingStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        settingSelectionValueStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
      );

  @override
  InquiryWidgetStyle get inquiryWidgetStyle => InquiryWidgetStyle(
        haveAQuestionStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        reachOutStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        phoneStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        emailStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
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
        productTypeStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        productCodeStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        dotColor: colors.color8C8C8C,
        productNameStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 20.sp, color: colors.color303538),
        ratingGlowColor: colors.primary,
        priceStyle: interSemiBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.color303538),
        detailsHeaderStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
      );

  @override
  SelectedSettingsStyle get selectedSettingsStyle => SelectedSettingsStyle(
        iconColor: colors.primary,
        titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        specialityStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        changeTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.primary),
      );

  @override
  ImageCarouselStyle get imageCarouselStyle => ImageCarouselStyle(
        dotColor: colors.colorC5DEEB,
        selectedDotColor: colors.primary,
      );

  @override
  WishListStyle get wishListStyle => WishListStyle(
        numberOfItemsStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 24.sp, color: colors.color303538),
        totalAmountStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
      );

  @override
  MyBagScreenStyle get myBagScreenStyle => MyBagScreenStyle(
        backgroundColor: colors.white,
        productsTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 24.sp),
        itemSelectedStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
        totalAmountStyle: interMediumBoldTextStyle,
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        bottomNavBarShadowColor: colors.black.withOpacity(0.08),
        bottomBarTotalTextStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        bottomBarTotalAmountTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 20.sp, color: colors.color303538),
        bottomBarMoreLessTextStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        textInfoValueStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
      );

  @override
  CompareProductStyle get compareProductStyle => CompareProductStyle(
        productTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        productSubTitleStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color303538),
        productPriceStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        productReviewStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        productRemoveStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        primaryColor: colors.primary,
      );

  @override
  RatingbarStyle get ratingbarStyle => RatingbarStyle(
        fillStarColor: colors.primary,
        emptyStarColor: colors.color8C8C8C,
      );

  @override
  AddAddressScreenStyle get addAddressScreenStyle => AddAddressScreenStyle(
        backgroundColor: colors.white,
        dotColor: colors.colorC5DEEB,
        filledDotColor: colors.primary,
        fillLineColor: colors.color424445,
        borderColor: colors.colorD3DAE0,
        shippingBillingAddressStyle: interRegularTextStyle,
        paymentStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        isSameAddressStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
      );

  @override
  CountryPickerStyle get countryPickerStyle => CountryPickerStyle(
      backgroundColor: colors.white,
      searchBorderColor: colors.color8C98A8.withOpacity(0.2),
      inputBorderColor: colors.colorD3DAE0,
      inputTextStyle: interRegularTextStyle,
      inputLableStyle: interRegularTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: colors.color303538,
      ));

  @override
  OrderSummaryStyle get orderSummaryStyle => OrderSummaryStyle(
        backgroundColor: colors.colorF7F9FA,
        orderSummaryTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 24.sp),
        orderSummaryItemStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        addPromoCodeStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        totalPriceStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        orderSummaryItemValueStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
      );

  @override
  ProductDetailsStyle get productDetailsStyle => ProductDetailsStyle(
        productTypeStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        productCodeStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        dotColor: colors.color8C8C8C,
        productNameStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 28.sp, color: colors.color303538),
        ratingGlowColor: colors.primary,
        compareProductStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        priceStyle: interSemiBoldTextStyle.copyWith(fontSize: 24.sp, color: colors.color303538),
        originalPriceStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        discountStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color50B83C),
        settingSelectionTitleStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        settingSelectionValueStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        selectedSettingStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        selectedSettingBorderColor: colors.primary,
        settingSelectionButtonColor: colors.colorF8F8F8,
        customiseBoxBorderColor: colors.colorD3DAE0,
        customiseBoxColor: colors.colorF7F9FA,
        diamondPurityStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        customerReviewTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 24.sp, color: colors.color303538),
        averageRatingStyle: interMediumBoldTextStyle.copyWith(fontSize: 24.sp, color: colors.color303538),
        viewAllReviewStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.primary),
        compareCountBGColor: colors.color4885A3,
        totalApproxStyle: interSemiBoldTextStyle.copyWith(fontSize: 18.sp, color: colors.color303538),
        totalApproxSubStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        orderSampleStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color303538),
      );

  @override
  ReviewDetailsStyle get reviewDetailsStyle => ReviewDetailsStyle(
        userNameStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color303538),
        dotColor: colors.color4885A3,
        createdDateStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
      );

  @override
  CheckOutStyle get checkOutStyle => CheckOutStyle(
        dividerColor: colors.colorD3DAE0,
      );

  @override
  PaymentStyle get paymentStyle => PaymentStyle(
        backgroundColor: colors.white,
        dotColor: colors.colorC5DEEB,
        filledDotColor: colors.primary,
        fillLineColor: colors.color424445,
        borderColor: colors.colorD3DAE0,
        shippingBillingAddressStyle: interRegularTextStyle,
        paymentStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        isSameAddressStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
        footerTotalStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C, fontSize: 16.sp),
        footerTotalAmountStyle: interSemiBoldTextStyle.copyWith(color: colors.color303538, fontSize: 16.sp),
      );

  @override
  MyBagDiamondItemStyle get myBagDiamondItemStyle => MyBagDiamondItemStyle(
      backgroundColor: colors.white,
      borderColor: colors.colorD3DAE0,
      headingStyle: interMediumBoldTextStyle,
      titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
      subTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
      richTextStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color50B83C),
      selectedBackgroundColor: colors.colorF7F9FA);

  @override
  AddressSelectionStyle get addressSelectionStyle => AddressSelectionStyle(
        addressNameStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        fullAddressStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        contactNumberStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
      );

  @override
  AddressListStyle get addressListStyle => AddressListStyle(
        backgroundColor: colors.colorF7F9FA,
        arrowColor: colors.primary,
        isSameAddressStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        nProductsTitleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 24.sp, color: colors.color303538),
        footerTotalAmountStyle: interSemiBoldTextStyle.copyWith(fontSize: 18.sp, color: colors.color303538),
        whiteColor: colors.white,
      );

  @override
  WriteReviewScreenStyle get writeReviewScreenStyle =>
      WriteReviewScreenStyle(whiteColor: colors.white, labelStyle: interRegularTextStyle, borderColor: colors.colorD3DAE0);

  @override
  OrderConfirmationStyle get orderConfirmationStyle => OrderConfirmationStyle(
        titleTextStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 28.sp),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
        orderNumberStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, decoration: TextDecoration.underline),
        descriptionStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
      );

  @override
  ProductMenuBottomSheetStyle get productMenuBottomSheetStyle => ProductMenuBottomSheetStyle(
        backgroundColor: colors.white,
        primaryColor: colors.primary,
        subTotalStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        moreDetailsStyle: interRegularTextStyle,
        totalAmountStyle: interMediumBoldTextStyle.copyWith(fontSize: 20.sp),
        imageLableStyle: interRegularTextStyle,
        diamondTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        diamondValueStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp),
      );

  @override
  AuctionScreenStyle get auctionScreenStyle => AuctionScreenStyle(
        bidPriceStyle: interSemiBoldTextStyle.copyWith(fontSize: 20.sp),
        bidPriceLableStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        primaryColor: colors.primary,
        borderColor: colors.colorD3DAE0,
        recentBidBackgroundColor: colors.colorF7F9FA,
        auctionTimerStyle: interRegularTextStyle,
        recentBidStyle: interMediumBoldTextStyle.copyWith(fontSize: 14.sp),
        recentBidValueStyle: interSemiBoldTextStyle.copyWith(fontSize: 14.sp),
        whiteColor: colors.white,
        allBidsTitleStyle: interMediumBoldTextStyle.copyWith(fontSize: 20.sp),
        myBidTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp),
        myBidBackgroundColor: colors.color9DCAE0,
        textFieldBorderColor: colors.colorD3DAE0,
        boxShadowColor: colors.black,
        compareCountBGColor: colors.color4885A3,
      );

  @override
  DiamondInfoPopupScreenStyle get diamondInfoPopupScreenStyle => DiamondInfoPopupScreenStyle(
        offerPriceStyle: interMediumBoldTextStyle.copyWith(fontSize: 20.sp),
        actualPriceStyle: interRegularTextStyle.copyWith(
            fontSize: 16.sp, color: colors.color8C8C8C, decoration: TextDecoration.lineThrough, decorationColor: colors.color8C8C8C),
        productNameStyle: interMediumBoldTextStyle,
        labelStyle: interMediumBoldTextStyle,
        itemTitleStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        itemValueStyle: interRegularTextStyle,
        viewMoreDetailsTextStyle: interMediumBoldTextStyle.copyWith(color: colors.primary),
      );

  @override
  QuotationRequestConfirmationStyle get quotationRequestConfirmationStyle => QuotationRequestConfirmationStyle(
        titleStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32.sp, color: colors.color303538),
        detailsTextStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        primaryColor: colors.primary,
      );

  @override
  ShowDoubleActionDialogStyle get showDoubleActionDialogStyle => ShowDoubleActionDialogStyle(
        titleStyle: interMediumBoldTextStyle,
        contentStyle: interRegularTextStyle,
        okButtonStyle: interMediumBoldTextStyle.copyWith(color: colors.primary),
      );

  @override
  SmartTabBarStyle get smartTabBarStyle => SmartTabBarStyle(
        selectedTabTextStyle: interMediumBoldTextStyle.copyWith(color: colors.primary),
        unselectedTabTextStyle: interMediumBoldTextStyle,
        primaryColor: colors.primary,
        tabDividerColor: colors.colorD3DAE0,
        labelColor: colors.color303538,
        unselectedLabelColor: colors.color8C8C8C,
      );

  @override
  StatusBadgeStyle get statusBadgeStyle => StatusBadgeStyle(
        activeBackgroundColor: colors.colorEBFFE7,
        activeTextColor: colors.color50B83C,
        inProgressBackgroundColor: colors.colorFFF2E7,
        inProgressTextColor: colors.colorF49342,
        statusTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp),
        lostBackgroundColor: colors.colorFCE1E1,
        lostTextColor: colors.colorE83535,
      );

  @override
  OrderCancelPopupStyle get orderCancelPopupStyle => OrderCancelPopupStyle(
      primaryColor: colors.primary,
      crossColor: colors.color8C8C8C,
      headerTitleStyle: interSemiBoldTextStyle.copyWith(fontSize: 18.sp, color: colors.color303538),
      subTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
      refundTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
      amountTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
      cancelReasonTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
      refundBgColor: colors.colorF7F9FA,
      whiteColor: colors.white);

  @override
  OrderPopupStyle get orderPopupStyle => OrderPopupStyle(
        optionTextStyle: interRegularTextStyle.copyWith(fontSize: 18.sp, color: colors.color303538),
        cancelTextStyle: interRegularTextStyle.copyWith(fontSize: 18.sp, color: colors.colorE83535),
        whiteColor: colors.white,
      );

  @override
  OrderDetailScreenStyle get orderDetailScreenStyle => OrderDetailScreenStyle(
        detailsTileColor: colors.colorF7F9FA,
        orderIdStyle: interMediumBoldTextStyle.copyWith(fontSize: 18.sp),
        orderDateStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        orderTotalStyle: interSemiBoldTextStyle.copyWith(fontSize: 16.sp),
        orderItemLabelStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        orderItemValueStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
        priceTextStyle: interSemiBoldTextStyle.copyWith(fontSize: 14.sp),
      );

  @override
  TrackOrderBottomSheetStyle get trackOrderBottomSheetStyle => TrackOrderBottomSheetStyle(
        backgroundColor: colors.white,
        orderInfoBackgroundColor: colors.colorF7F9FA,
        titleStyle: interSemiBoldTextStyle.copyWith(fontSize: 18.sp),
        orderIdStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        imageSubTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color8C8C8C),
        imageTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
        quantityStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
      );

  @override
  AuctionListItemStyle get auctionListItemStyle => AuctionListItemStyle(
        borderColor: colors.colorD3DAE0,
        primaryColor: colors.primary,
        titleStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        valueStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
        productNameStyle: interMediumBoldTextStyle,
      );

  @override
  ProfileScreenStyle get profilePageScreenStyle => ProfileScreenStyle(
      backgroundColor: colors.white,
      primaryColor: colors.primary,
      dividerColor: colors.colorF7F9FA,
      arrowRightColor: colors.color8C8C8C,
      titleStyle: interMediumBoldTextStyle.copyWith(
        fontSize: 20.sp,
      ),
      subTitleStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp),
      subTextStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
      listTitleStyle: interRegularTextStyle.copyWith(fontSize: 18.sp),
      expandTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
      fontTextStyle: interRegularTextStyle.copyWith(fontSize: 18.sp, color: colors.color8C8C8C),
      logoutTextStyle: interRegularTextStyle.copyWith(fontSize: 18.sp, color: colors.colorE83535),
      bottomTitleStyle: interSemiBoldTextStyle.copyWith(fontSize: 18.sp));

  @override
  SmartOptionTileStyle get smartOptionTileStyle => SmartOptionTileStyle(
        arrowRightColor: colors.color8C8C8C,
        transparentColor: colors.transparent,
        titleStyle: interRegularTextStyle.copyWith(fontSize: 18.sp),
        subTextStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        primaryColor: colors.primary,
      );

  @override
  OrderTimelineStyle get orderTimelineStyle => OrderTimelineStyle(
        whiteColor: colors.white,
        backgroundColor: colors.colorF7F9FA,
        titleStyle: interSemiBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 14.sp, color: colors.color303538),
        timeStyle: interMediumBoldTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        dateTagStyle: interRegularTextStyle.copyWith(fontSize: 12.sp, color: colors.color8C8C8C),
        dateTagBorderColor: colors.colorD3DAE0,
      );

  @override
  SmartTileLineStepperStyle get smartTileLineStepperStyle => SmartTileLineStepperStyle(
        completedIndicatorColor: colors.color50B83C,
        upcomingIndicatorColor: colors.color8C8C8C,
        titleStyle: interSemiBoldTextStyle,
        subtitleStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
      );

  @override
  LogoutPopupStyle get logoutPopupStyle => LogoutPopupStyle(
        titleStyle: interSemiBoldTextStyle.copyWith(fontSize: 18.sp),
        subTitleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color8C8C8C),
        whiteColor: colors.white,
        cancelTextStyle: interMediumBoldTextStyle.copyWith(fontSize: 16.sp, color: colors.color34415F),
      );

  @override
  SearchScreenStyle get searchScreenStyle => SearchScreenStyle(
        titleStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C),
        searchItemStyle: interRegularTextStyle.copyWith(fontSize: 16.sp),
      );

  @override
  SupportScreenStyle get supportScreenStyle => SupportScreenStyle(
      frequentlyAskedQuestionStyle: eBGaramondRegularTextStyle.copyWith(fontSize: 32.sp),
      questionStyle: interMediumBoldTextStyle,
      answerStyle: interRegularTextStyle.copyWith(color: colors.color8C8C8C));

  @override
  QrScannerStyle get qrScannerStyle => QrScannerStyle(
        titleStyle: interRegularTextStyle.copyWith(fontSize: 16.sp, color: colors.color303538),
        overLayColor: colors.black.withOpacity(0.5),
      );
}
