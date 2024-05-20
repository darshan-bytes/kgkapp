import 'package:kgk/kgk.dart';

class LightModeTheme extends AppTheme {
  final AppColor initcolors;

  LightModeTheme(this.initcolors);

  @override
  AppColor get colors => initcolors;

  @override
  TextStyle get detailTextStyle => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        fontFamily: AppFonts.barlowRegular,
        color: colors.text364A4E,
      );

  @override
  TextStyle get primarySemiTitle =>
      TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, fontFamily: AppFonts.barlowSemiBold, color: colors.text364A4E);

  @override
  TextStyle get mediumTitleTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        fontFamily: AppFonts.barlowMedium,
        color: colors.text364A4E,
      );

  @override
  TextStyle get boldTitleTextStyle => TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        fontFamily: AppFonts.barlowBold,
        color: colors.text364A4E,
      );

  @override
  SignInStyle get signInStyle => SignInStyle(
        skipStyle: detailTextStyle.copyWith(
          decoration: TextDecoration.underline,
          fontFamily: AppFonts.barlowMedium,
          fontSize: 12,
        ),
        buttonBackground: colors.primary,
        titleText: boldTitleTextStyle.copyWith(fontSize: 28, color: colors.text123036),
        signinDetail: detailTextStyle.copyWith(
          fontSize: 16,
        ),
        highlightTextStyle: mediumTitleTextStyle.copyWith(color: colors.text364A4E, fontFamily: AppFonts.barlowBold),
      );

  @override
  SignUpStyle get signUpStyle =>
      SignUpStyle(informativeText: detailTextStyle.copyWith(fontSize: 10, fontFamily: AppFonts.barlowRegular, color: colors.text364A4E));

  @override
  PrimaryButtonStyle get primaryButtonStyle => PrimaryButtonStyle(
      blackColor: colors.text364A4E,
      titleStyle: mediumTitleTextStyle.copyWith(
        fontFamily: AppFonts.barlowSemiBold,
        fontWeight: FontWeight.w500,
        color: colors.white,
      ),
      whiteColor: colors.white,
      activeBackgroundColor: colors.primary,
      disableBackgroundColor: colors.text364A4E);

  @override
  TextFieldStyle get textFieldStyle => TextFieldStyle(
        textFillColor: colors.white,
        labelStyle: detailTextStyle.copyWith(fontWeight: FontWeight.w600, fontFamily: AppFonts.barlowRegular),
        hintStyle: mediumTitleTextStyle.copyWith(fontSize: 13, color: colors.text123036),
        textStyle: mediumTitleTextStyle.copyWith(fontWeight: FontWeight.w500, color: colors.text123036, fontFamily: AppFonts.barlowRegular),
        blackColor: colors.text123036,
        iconColor: colors.text123036,
        inputTextStyle:
            mediumTitleTextStyle.copyWith(fontWeight: FontWeight.w500, color: colors.primary, fontFamily: AppFonts.barlowRegular),
        errorStyle: detailTextStyle.copyWith(color: colors.error),
        disabledTextFieldBorderColor: colors.border005568,
      );

  @override
  SmartRichTextStyle get smartRichTextStyle => SmartRichTextStyle(
      subTextStyle: mediumTitleTextStyle.copyWith(fontWeight: FontWeight.w500, color: colors.text364A4E, fontFamily: AppFonts.barlowBold),
      textStyle: mediumTitleTextStyle.copyWith(fontWeight: FontWeight.w400, color: colors.text364A4E));

  @override
  CheckboxStyle get checkboxStyle => CheckboxStyle(
      activeColor: colors.primary,
      checkColor: colors.white,
      textStyle: mediumTitleTextStyle.copyWith(fontWeight: FontWeight.w400, color: colors.primary),
      borderColor: colors.primary);

  @override
  CardDeliveryStyle get cardDeliveryStyle => CardDeliveryStyle(
      titleStyle: mediumTitleTextStyle.copyWith(
          fontSize: 23, fontWeight: FontWeight.w700, fontFamily: AppFonts.barlowBold, color: colors.text123036),
      methodTitleStyle: mediumTitleTextStyle.copyWith(fontSize: 15, fontFamily: AppFonts.barlowSemiBold));

  @override
  CustomAppBarStyle get appBarStyle => CustomAppBarStyle(
      whiteColor: colors.white,
      titleStyle: boldTitleTextStyle.copyWith(color: colors.text123036),
      appBarShadow: const BoxShadow(color: Color.fromRGBO(178, 189, 194, 0.25), offset: Offset(0, 0), blurRadius: 10.0, spreadRadius: 0),
      skipTextStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 16, decoration: TextDecoration.underline),
      titleTextStyle: mediumTitleTextStyle.copyWith());

  @override
  ProductStyle get productStyle => ProductStyle(
      backgroundColor: colors.white,
      ratingBackgroundColor: colors.bgECECEC,
      ratingStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 12),
      productNameStyle: mediumTitleTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
      priceTextStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontSize: 12),
      outOfStockTextStyle: primarySemiTitle.copyWith(color: colors.text9AB3B8, fontSize: 18),
      offerTextStyle: boldTitleTextStyle.copyWith(
          color: colors.text9AB3B8, fontSize: 12, decoration: TextDecoration.lineThrough, decorationColor: colors.text9AB3B8),
      lableStyle: detailTextStyle.copyWith(fontSize: 10));

  @override
  BottomNavigationBarStyle get bottomNavigationBarStyle => BottomNavigationBarStyle(
        whiteColor: colors.white,
        fabBackgroundColor: colors.bg009788,
        navBarTextStyle: detailTextStyle.copyWith(fontSize: 11),
        navBarUnSelectedColor: colors.text364A4E,
        navBarSelectedColor: colors.text005668,
        navBarSelectedIconColor: colors.black,
        transparent: Colors.transparent,
      );

  @override
  CommonAppStyle get commonAppStyle => CommonAppStyle(
        snackBatTextStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontFamily: AppFonts.barlowMedium),
      );

  @override
  StoreInfoStyle get storeInfoStyle => StoreInfoStyle(
      headingStyle: detailTextStyle.copyWith(fontWeight: FontWeight.w700, color: colors.text123036),
      titleStyle: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        fontFamily: AppFonts.barlowRegular,
        color: colors.text123036,
      ),
      subTitleStyle: detailTextStyle.copyWith(
        fontSize: 10,
        fontFamily: AppFonts.barlowRegular,
        color: colors.text123036,
      ),
      tileColor: colors.bgFFFAF6,
      workTimeStyle: TextStyle(
        fontSize: 10,
        fontFamily: AppFonts.barlowMedium,
        color: colors.text091E42,
        fontWeight: FontWeight.w500,
      ),
      seeAllStyle: TextStyle(
        fontSize: 10,
        fontFamily: AppFonts.barlowRegular,
        color: colors.text091E42,
        fontWeight: FontWeight.w400,
      ),
      outOfStockStyle: TextStyle(
        fontSize: 10,
        fontFamily: AppFonts.barlowMedium,
        color: colors.textF58220,
        fontWeight: FontWeight.w500,
      ));

  @override
  SearchScreenStyle get searchScreenStyle => SearchScreenStyle(
      hintStyle: mediumTitleTextStyle.copyWith(fontWeight: FontWeight.w400, color: colors.text123036),
      enabledBorderColor: colors.primary,
      searchesStyle: detailTextStyle,
      trendingStyle: boldTitleTextStyle.copyWith(fontWeight: FontWeight.w600, color: colors.text123036),
      trendingProductsBorderColor: colors.border9AB3B8,
      trendingProductsStyle:
          TextStyle(fontSize: 12, fontWeight: FontWeight.w400, fontFamily: AppFonts.barlowMedium, color: colors.text364A4E),
      dividerColor: colors.borderF3F3F3,
      titleStyle: mediumTitleTextStyle,
      sortTitle: detailTextStyle.copyWith(
        color: colors.text9AB3B8,
      ),
      sortSelectedTitle: mediumTitleTextStyle.copyWith(
        color: colors.bg009788,
      ));

  @override
  SelectStoreSheetStyle get selectStoreSheetStyle => SelectStoreSheetStyle(
      textStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontWeight: FontWeight.w600),
      whiteColor: colors.white,
      borderColor: colors.borderF3F3F3,
      selectedBorderColor: colors.borderF58220);

  @override
  CustomCarouselSliderStyle get customCarouselSliderStyle =>
      CustomCarouselSliderStyle(selectedSliderIndexColor: colors.primary, deselectedSliderIndexColor: colors.border9AB3B8);

  @override
  HomeScreenStyle get homeScreenStyle => HomeScreenStyle(
        whiteColor: colors.white,
        headingTitleStyle: boldTitleTextStyle.copyWith(color: colors.black),
        favIconColor: colors.borderF58220,
        shadowColor: colors.text005668,
        borderColor: colors.borderF3F3F3,
        seeAllTextStyle: detailTextStyle.copyWith(
          color: colors.text123036,
          decoration: TextDecoration.underline,
        ),
        imageTitleTextStyle: detailTextStyle.copyWith(
            fontSize: 10, fontWeight: FontWeight.w500, color: colors.text123036, fontFamily: AppFonts.barlowMedium),
        subTitleStyle: detailTextStyle.copyWith(fontSize: 12, color: colors.text123036),
        cartCountStyle: mediumTitleTextStyle.copyWith(fontSize: 10, color: colors.white, fontFamily: AppFonts.barlowMedium),
      );

  @override
  ShopByStyle get shopByStyle => ShopByStyle(
      titleStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontSize: 16),
      itemNameStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
      subCategoryStyle: primarySemiTitle.copyWith(color: colors.textF58220, fontSize: 14),
      backgroundColor: colors.white,
      dividerColor: colors.bgf3f3f3,
      borderColor: colors.bgD0E4E9,
      highlitedTitle: detailTextStyle.copyWith(color: colors.textF58220, fontFamily: AppFonts.barlowSemiBold),
      subCategoryTitle: detailTextStyle);

  @override
  ExploreTheBestBrandsStyle get exploreTheBestBrandsStyle => ExploreTheBestBrandsStyle(
      whiteColor: colors.white,
      boxShadow: BoxShadow(
        color: colors.bg14005668,
        blurRadius: 32,
        spreadRadius: 0,
        offset: const Offset(5, 10),
      ),
      titleTextStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontSize: 16),
      skipTextStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 16, decoration: TextDecoration.underline));

  @override
  MeetYourHealthNeedStyle get meetYourHealthNeedStyle => MeetYourHealthNeedStyle(
        whiteColor: colors.white,
        titleTextStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontSize: 16),
        productNameTextStyle: mediumTitleTextStyle.copyWith(color: colors.black, fontSize: 12),
      );

  @override
  DealsForYouStyle get dealsForYouStyle => DealsForYouStyle(
        borderColor: colors.bgf3f3f3,
        imageBGColor: colors.bgF8F8F8,
        textBGColor: colors.bg009788,
        offerTextStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
      );

  @override
  CustomDropDownStyle get customDropDownStyle => CustomDropDownStyle(
        whiteColor: colors.white,
        titleTextStyle: primarySemiTitle,
        borderColor: colors.primary,
        selectedBackgroundColor: colors.bgColor,
      );

  @override
  MyStoreLocationStyle get myStoreLocationStyle => MyStoreLocationStyle(
      backgroundColor: colors.bgFFF9F5,
      myStoreTextStyle: detailTextStyle.copyWith(fontSize: 12, color: colors.text123036),
      subTitleStyle:
          detailTextStyle.copyWith(fontSize: 12, color: colors.text123036, fontWeight: FontWeight.w500, fontFamily: AppFonts.barlowMedium),
      timeStempStyle: detailTextStyle.copyWith(fontSize: 10, color: colors.textF58220, fontFamily: AppFonts.barlowMedium),
      chooseStoreStyle: detailTextStyle.copyWith(
          fontSize: 10, color: colors.black, fontFamily: AppFonts.barlowMedium, decoration: TextDecoration.underline));

  @override
  ProfileStyle get profileStyle => ProfileStyle(
        whiteColor: colors.white,
        goodMorningTextStyle: boldTitleTextStyle.copyWith(color: colors.black, fontSize: 18),
        nameTextStyle: detailTextStyle.copyWith(color: colors.black, fontSize: 14),
        pointTextStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 14),
        rewardPointAmountStyle: boldTitleTextStyle.copyWith(color: colors.textC4D82E, fontSize: 12),
        rewardPointStyle: boldTitleTextStyle.copyWith(color: colors.textC4D82E, fontSize: 20),
        healthyPointStyle: boldTitleTextStyle.copyWith(color: colors.text4BBE9F, fontSize: 20),
        storeCreditStyle: boldTitleTextStyle.copyWith(color: colors.text6FC8C2, fontSize: 20),
        titleTextStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 12),
        userNameColor: colors.primary,
      );

  @override
  FilterStyle get filterStyle => FilterStyle(
        whiteColor: colors.white,
        backgroundColor: colors.bgF9FDFF,
        filterTextStyle: detailTextStyle.copyWith(color: colors.black, fontSize: 14),
        selectedFilterTrailColor: colors.primary,
        selectedFilterBGColor: colors.white,
        subFilterTextStyle: mediumTitleTextStyle.copyWith(color: colors.primary, fontSize: 14),
        borderColor: colors.borderF3F3F3,
        sortByTextStyle:
            primarySemiTitle.copyWith(color: colors.text123036, fontFamily: AppFonts.barlowRegular, fontWeight: FontWeight.w400),
        sortByTextSelectedStyle: primarySemiTitle.copyWith(color: colors.bg009788),
      );

  @override
  DashboardStyle get dashboardStyle => DashboardStyle(
        backgroundColor: colors.white,
        actionCardBackgroundColor: colors.primary,
        healthyPointBackgroundColor: colors.textC4D82E,
        storeCreditBackgroundColor: colors.text6FC8C2,
        couponsBackgroundColor: colors.textC7AEB9,
        giftCardBackgroundColor: colors.text4BBE9F,
        greetingTextStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
        welcomeUserNameStyle: boldTitleTextStyle.copyWith(color: colors.white, fontSize: 18),
        actionButtonValueStyle: boldTitleTextStyle.copyWith(color: colors.white, fontSize: 16),
        actionButtonTitleStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
        orderAndReturnBackgroundColor: colors.bgF3FFFC,
        orderAndReturnLeadingBGColor: colors.text4BBE9F,
        wishListBackgroundColor: colors.bgFFF6E8,
        wishListLeadingBGColor: colors.bgFAA41A,
        secondaryActionTitleStyle: mediumTitleTextStyle.copyWith(color: colors.black, fontSize: 18),
        secondaryActionSubTitleStyle: detailTextStyle.copyWith(color: colors.text9AB3B8, fontSize: 14),
        informationTitleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
        informationDetailsStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 14),
      );

  @override
  AccountInformationScreenStyle get accountInformationScreenStyle => AccountInformationScreenStyle(
        backgroundColor: colors.white,
        formHeaderStyle: primarySemiTitle.copyWith(color: colors.text123036),
        addressTitleStyle: detailTextStyle.copyWith(color: colors.black),
        addAddressTitleStyle:
            detailTextStyle.copyWith(color: colors.black, decoration: TextDecoration.underline, decorationColor: colors.black),
        changeEmailStyle: mediumTitleTextStyle.copyWith(fontSize: 12, color: colors.text123036, decoration: TextDecoration.underline),
        defaultAddressTitleStyle: mediumTitleTextStyle.copyWith(color: colors.black, fontSize: 15),
        defaultAddressStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        defaultAddressContactNoTextStyle: mediumTitleTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        defaultAddressContactNoValueStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        changeAddressTextStyle: detailTextStyle.copyWith(
          color: colors.textF58220,
          fontSize: 12,
          decoration: TextDecoration.underline,
          decorationColor: colors.textF58220,
        ),
        additionalAddressTitleTextStyle: primarySemiTitle.copyWith(color: colors.primary, fontSize: 16),
        addressDetailsTitleTextStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        addressDetailsValueTextStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        addressDetailsBoxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        disabledTextFieldFillColor: colors.bgf3f3f3,
        disabledTextFieldBorderColor: colors.border005568,
      );

  @override
  ChangePassword get changePassword => ChangePassword(
        backgroundColor: colors.white,
        dividerColor: colors.borderF3F3F3,
      );

  @override
  StoreCreditStyle get storeCreditStyle => StoreCreditStyle(
        backgroundColor: colors.white,
        boxShadow: BoxShadow(color: colors.bg14005668, offset: const Offset(5, 10), spreadRadius: 0, blurRadius: 32),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        bottomNavBarColor: colors.text123036,
        bottomNavBarButtonColor: colors.bg009788,
        bottomBarTextStyle: primarySemiTitle.copyWith(color: colors.white, fontSize: 14),
      );

  @override
  MyOrderStyle get myOrderStyle => MyOrderStyle(
        backgroundColor: colors.white,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
      );

  @override
  GiftCardStyle get giftCardStyle => GiftCardStyle(
        backgroundColor: colors.white,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        addGiftCardButtonStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        addGiftCardButtonColor: colors.bgf3f3f3,
      );

  @override
  HealthyPointStyle get healthyPointStyle => HealthyPointStyle(
        backgroundColor: colors.white,
        warningBackgroundColor: colors.bgFBFDE1,
        warningTextStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        healthyPointBackgroundColor: colors.textC4D82E,
        onlineRewardPointBackgroundColor: colors.text4BBE9F,
        downloadTransactionReportBackgroundColor: colors.text6FC8C2,
        missingPointsBackgroundColor: colors.textC7AEB9,
        actionButtonValueStyle: boldTitleTextStyle.copyWith(color: colors.white, fontSize: 16),
        actionButtonTitleStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
        emailNotificationSettingsTitleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
        subscriptionCheckboxTitleStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        saveSubscriptionSettingTitleStyle: primarySemiTitle.copyWith(
          color: colors.textF58220,
          fontSize: 14,
          decoration: TextDecoration.underline,
          decorationColor: colors.textF58220,
        ),
        dividerColor: colors.borderF3F3F3,
      );

  @override
  AddressDetailsStyle get addressDetailsStyle => AddressDetailsStyle(
        backgroundColor: colors.white,
        titleTextStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
        checkBoxTitleStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 12),
      );

  @override
  MyWishListStyle get myWishListStyle => MyWishListStyle(
        backgroundColor: colors.white,
        shareWishListButtonColor: colors.white,
        shareWishListBorderColor: colors.border9AB3B8,
        shareWishListTextStyle: primarySemiTitle.copyWith(color: colors.text9AB3B8, fontSize: 16),
        titleTextStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
      );

  @override
  BuyLaterStyle get buyLaterStyle => BuyLaterStyle(
        backgroundColor: colors.white,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        productNameStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
      );

  @override
  MyProductReviewsStyle get myProductReviewsStyle => MyProductReviewsStyle(
        backgroundColor: colors.white,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        productNameStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        fillRatingColor: colors.textC4D82E,
        emptyRatingColor: colors.textC4D82E.withOpacity(0.3),
      );

  @override
  OnlineAndInStoreRewardPointsStyle get onlineAndInStoreRewardPointsStyle => OnlineAndInStoreRewardPointsStyle(
        backgroundColor: colors.white,
        tabBarTitleStyle: primarySemiTitle.copyWith(color: colors.primary, fontSize: 12),
        tabBarUnselectedTitleStyle: primarySemiTitle.copyWith(color: colors.text9AB3B8, fontSize: 12),
        tabIndicatorColor: colors.primary,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        actionButtonValueStyle: boldTitleTextStyle.copyWith(color: colors.white, fontSize: 16),
        actionButtonTitleStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
        filterTextStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 16),
        appliedFilterTextStyle: detailTextStyle.copyWith(color: colors.text9AB3B8, fontSize: 14),
      );

  @override
  InStoreTransactionFilterStyle get inStoreTransactionFilterStyle => InStoreTransactionFilterStyle(
        backgroundColor: colors.white,
        dividerColor: colors.borderF3F3F3,
        titleTextStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
      );

  @override
  MyCouponsStyle get myCouponsStyle => MyCouponsStyle(
        backgroundColor: colors.white,
        tabBarTitleStyle: primarySemiTitle.copyWith(color: colors.primary, fontSize: 12),
        tabBarUnselectedTitleStyle: primarySemiTitle.copyWith(color: colors.text9AB3B8, fontSize: 12),
        tabIndicatorColor: colors.primary,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        titleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 14),
        couponCodeTitleStyle: primarySemiTitle.copyWith(color: colors.textF58220, fontSize: 16),
      );

  @override
  MyCartStyle get myCartStyle => MyCartStyle(
        discountTitleStyle: mediumTitleTextStyle.copyWith(fontSize: 14, color: colors.border009788),
        backgroundColor: colors.bgF4F9FA,
        scaffoldBackgroundColor: colors.white,
        emptyCartTitleStyle: boldTitleTextStyle.copyWith(color: colors.text9AB3B8, fontSize: 24),
        emptyCartSubTitleStyle: detailTextStyle.copyWith(color: colors.text9AB3B8, fontSize: 18),
        emptyCartBackgroundColor: colors.bgF4F9FA,
        headerTitleBackgroundColor: colors.text6FC8C2,
        headingTitleTextStyle: mediumTitleTextStyle.copyWith(fontSize: 12, color: colors.white),
        removeTextStyle: mediumTitleTextStyle.copyWith(
            fontSize: 12, color: colors.text9AB3B8, decoration: TextDecoration.underline, decorationColor: colors.text9AB3B8),
        whiteColor: colors.white,
        useGiftCartStyle: mediumTitleTextStyle.copyWith(fontSize: 14, color: colors.text123036),
        orderSummaryTitleStyle: primarySemiTitle.copyWith(color: colors.text123036),
        orderSummarySubTitleStyle: detailTextStyle.copyWith(fontSize: 12, color: colors.text123036),
        outOfStockTextStyle: mediumTitleTextStyle.copyWith(fontSize: 14, color: colors.textF58220),
        outOfStockMessageBackgroundColor: colors.bgFFF6E8,
        dividerColor: colors.borderF3F3F3,
        clickHereToApplyStyle: mediumTitleTextStyle.copyWith(
            fontSize: 14, color: colors.text123036, decoration: TextDecoration.underline, decorationColor: colors.text123036),
        grandTotalStyle: detailTextStyle.copyWith(fontSize: 12, color: colors.text123036, fontWeight: FontWeight.w700),
      );

  @override
  OrderDetailsStyle get orderDetailsStyle => OrderDetailsStyle(
        backgroundColor: colors.white,
        basicTitleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 14),
        basicSubTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        actionTextStyle: detailTextStyle.copyWith(
            color: colors.text364A4E, fontSize: 12, decoration: TextDecoration.underline, decorationColor: colors.text364A4E),
        productItemsTitleStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontSize: 16),
        productNamesStyle: mediumTitleTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        productTitleStyle: primarySemiTitle.copyWith(color: colors.text005668, fontSize: 10),
        productSubTitleStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 8),
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        productBorderColor: colors.borderF3F3F3,
        amountContainerColor: colors.bgFFF8F2,
        amountTextStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        totalAmountTextStyle: boldTitleTextStyle.copyWith(color: colors.textF58220, fontSize: 21),
        dividerColor: colors.border9AB3B8,
        addressTitleStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
      );

  @override
  ProductDetailsScreenStyle get productDetailsScreenStyle => ProductDetailsScreenStyle(
        backgroundColor: colors.white,
        productNameStyle: mediumTitleTextStyle.copyWith(color: colors.text364A4E, fontSize: 20),
        productRatingStyle: mediumTitleTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        byTextStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        sellerTextStyle: detailTextStyle.copyWith(color: colors.textF58220, fontSize: 12),
        skuTextStyle: detailTextStyle.copyWith(color: colors.text364A4E, fontSize: 12),
        productTagBackGroundColor: colors.bgFAA41A,
        productTagStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
        unselectedDotColor: colors.bgDDD0BC,
        selectedDotColor: colors.bgFAA41A,
        priceTextStyle: boldTitleTextStyle.copyWith(color: colors.text123036, fontSize: 20),
        offerTextStyle: mediumTitleTextStyle.copyWith(
          color: colors.text9AB3B8,
          fontSize: 20,
          decoration: TextDecoration.lineThrough,
          decorationColor: colors.text9AB3B8,
        ),
        otherPaymentMethodStyle: detailTextStyle.copyWith(
          color: colors.black,
          fontSize: 12,
        ),
        otherDetailsTextStyle: detailTextStyle.copyWith(
          color: colors.black,
          fontSize: 12,
        ),
        dividerColor: colors.borderF3F3F3,
        expansionTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 16),
        titleTextStyle: primarySemiTitle.copyWith(color: colors.text123036, fontSize: 16),
        writeAReviewTitleStyle: mediumTitleTextStyle.copyWith(
            color: colors.bg009788, fontSize: 16, decoration: TextDecoration.underline, decorationColor: colors.bg009788),
        ratingBackGroundColor: colors.text4BBE9F,
        averageRatingTextStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 16),
        ratingTextStyle: mediumTitleTextStyle.copyWith(color: colors.black, fontSize: 24),
        reviewCountTextStyle: detailTextStyle.copyWith(color: colors.text9AB3B8, fontSize: 16),
        alertTextStyle: mediumTitleTextStyle.copyWith(
            color: colors.textF58220, fontSize: 14, decoration: TextDecoration.underline, decorationColor: colors.textF58220),
        bottomBarColor: colors.text123036,
        productDetailsTitleStyle: detailTextStyle.copyWith(color: colors.white, fontSize: 12),
        bottomBarPriceTextStyle: boldTitleTextStyle.copyWith(color: colors.white, fontSize: 14),
        bottomBarOfferTextStyle: mediumTitleTextStyle.copyWith(
            color: colors.text9AB3B8, fontSize: 14, decoration: TextDecoration.lineThrough, decorationColor: colors.text9AB3B8),
        addToCartButtonColor: colors.bg009788,
        boxShadow: BoxShadow(
          color: colors.bg14005668,
          offset: const Offset(5, 10),
          blurRadius: 32,
          spreadRadius: 0,
        ),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        selectedGiftCardColor: colors.primary,
        lastOrderBorderColor: colors.textC4D82E,
        viewOrderTextStyle: mediumTitleTextStyle.copyWith(
            color: colors.textF58220, fontSize: 12, decoration: TextDecoration.underline, decorationColor: colors.textF58220),
      );

  @override
  CustomProgressBarStyle get customProgressBarStyle => CustomProgressBarStyle(
        backgroundColor: colors.white,
        primaryColor: colors.primary,
        progressbarBGColor: colors.borderF3F3F3,
      );

  @override
  ReviewScreenStyle get reviewScreenStyle => ReviewScreenStyle(
        backgroundColor: colors.white,
        dividerColor: colors.borderF3F3F3,
      );

  @override
  CartProductItemStyle get cartProductItemStyle => CartProductItemStyle(
        itemOutOfStockTextColor: colors.bgFFF0E4,
        itemOutOfStockTextStyle: mediumTitleTextStyle.copyWith(fontSize: 10, color: colors.textF58220),
        productTitleStyle: mediumTitleTextStyle.copyWith(fontSize: 12),
        productSubTitleStyle: boldTitleTextStyle.copyWith(fontSize: 10, color: colors.border005568),
        checkedPriceSubTitleStyle: detailTextStyle.copyWith(fontSize: 10, color: colors.text9AB3B8, decoration: TextDecoration.lineThrough),
        removeTextStyle: mediumTitleTextStyle.copyWith(
            fontSize: 12, color: colors.textF58220, decoration: TextDecoration.underline, decorationColor: colors.textF58220),
        borderColor: colors.bgECECEC,
        giftCardLabelStyle: boldTitleTextStyle.copyWith(fontSize: 12, color: colors.text182125),
      );

  @override
  SuccessShoppingCardStyle get successShoppingCardStyle => SuccessShoppingCardStyle(
      isCorrectColor: colors.text4BBE9F,
      thanksTextStyle: boldTitleTextStyle.copyWith(
        color: colors.black,
      ),
      orderStyle: primarySemiTitle.copyWith(fontSize: 14, color: colors.black),
      orderNumberColor: colors.bgFAA41A,
      subTitleStyle: detailTextStyle.copyWith(fontSize: 16, color: colors.text123036),
      createAccountTitleStyle: detailTextStyle.copyWith(color: colors.black),
      buttonTextStyle: primarySemiTitle.copyWith(fontSize: 14, color: colors.white),
      buttonBackgroundColor: colors.border005568,
      dividerColor: colors.borderF3F3F3,
      blackColor: colors.black,
      transparentColor: colors.transparent);

  @override
  LocationDetailStyle get locationDetailStyle => LocationDetailStyle(
      backgroundColor: colors.white,
      dashBoardBackgroundColor: colors.border005568,
      getDirectionBackgroundColor: colors.bgFF8220,
      dashboardTitleStyle: primarySemiTitle.copyWith(fontSize: 10, color: colors.text123036),
      locationLableStyle: detailTextStyle.copyWith(fontSize: 12),
      getDirectionStyle: primarySemiTitle.copyWith(fontSize: 14, color: colors.white),
      ratingTitle: boldTitleTextStyle.copyWith(fontSize: 14, fontWeight: FontWeight.w900, fontFamily: AppFonts.barlowExtraBold),
      viewAllTextStyle: mediumTitleTextStyle.copyWith(
          fontSize: 12, color: colors.text123036, decoration: TextDecoration.underline, decorationColor: colors.text123036));

  @override
  BrandListStyle get brandListStyle => BrandListStyle(lableTextStyle: const TextStyle(), letterTextStyle: const TextStyle());

  @override
  LocationListingStyle get locationListingStyle => LocationListingStyle(
      backgroundColor: colors.bgF4F9FA,
      white: colors.white,
      filterStyle: mediumTitleTextStyle.copyWith(color: colors.text123036),
      appliedStyle: detailTextStyle.copyWith(color: colors.text9AB3B8),
      cardHeadingStyle: boldTitleTextStyle.copyWith(fontSize: 14, color: colors.text123036),
      cardTitleStyle: primarySemiTitle.copyWith(fontSize: 12, color: colors.text123036),
      cardSubTitleStyle: detailTextStyle.copyWith(fontSize: 12, color: colors.text123036),
      activeTrackColor: colors.textF58220,
      infoWindowText: detailTextStyle,
      infoWindowHours: detailTextStyle.copyWith(fontSize: 10, fontFamily: AppFonts.barlowMedium));

  @override
  UnderMaintenanceStyle get underMaintenanceStyle => UnderMaintenanceStyle(
      headingTextStyle: boldTitleTextStyle.copyWith(fontSize: 28, fontWeight: FontWeight.w700, color: colors.black),
      subTitleTextStyle: mediumTitleTextStyle.copyWith(color: colors.black),
      titleTextStyle: mediumTitleTextStyle.copyWith(fontSize: 16, color: colors.black, fontWeight: FontWeight.w400));

  @override
  CheckoutStyle get checkoutStyle => CheckoutStyle(
        backgroundColor: colors.white,
        titleTextStyle: mediumTitleTextStyle.copyWith(color: colors.bg009788, fontSize: 13),
        unSelectedTitleTextStyle: mediumTitleTextStyle.copyWith(color: colors.text9AB3B8, fontSize: 13),
        changeAddressStyle: mediumTitleTextStyle.copyWith(color: colors.white, fontSize: 12),
        saveLateUseCheckboxTitleStyle: mediumTitleTextStyle.copyWith(fontSize: 12, color: colors.text123036),
        subTitleStyle: detailTextStyle.copyWith(color: colors.text123036, fontSize: 12),
        alertTextStyle: mediumTitleTextStyle.copyWith(
            color: colors.textF58220, fontSize: 14, decoration: TextDecoration.underline, decorationColor: colors.textF58220),
      );

  @override
  AddressCheckoutStyle get addressCheckoutStyle => AddressCheckoutStyle(
      borderColor: colors.border009788,
      titleStyle: boldTitleTextStyle,
      subTitleStyle: detailTextStyle.copyWith(fontSize: 12),
      defaultAddressStyle: mediumTitleTextStyle.copyWith(fontSize: 12, color: colors.bgFAA41A));

  @override
  CheckoutAddressSheetStyle get checkoutAddressSheetStyle =>
      CheckoutAddressSheetStyle(dividerColor: colors.borderF3F3F3, backgroundColor: colors.white, addNewAddressStyle: primarySemiTitle);

  @override
  CreditCardStyle get creditCardStyle => CreditCardStyle(
      borderColor: colors.borderF3F3F3,
      selectedBorderColor: colors.border009788,
      cardNumberStyle: mediumTitleTextStyle.copyWith(fontSize: 13, color: colors.text123036),
      cardNameStyle: detailTextStyle.copyWith(fontSize: 12, color: colors.text123036),
      titleStyle: primarySemiTitle.copyWith(color: colors.text123036));
}
