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

  NotificationScreenStyle get notificationScreenStyle;

  AllNotificationViewStyle get allNotificationViewStyle;

  SettingViewStyle get settingViewStyle;

  CollectionViewStyle get collectionViewStyle;

  SignUpStyle get signUpStyle;

  RadioButtonStyle get radioButtonStyle;

  ProductItemStyle get productItemStyle;

  SmartDropDownStyle get smartDropDownStyle;

  CustomPageIndicatorStyle get customPageIndicatorStyle;

  SortStyle get sortStyle;

  FilterStyle get filterStyle;

  DiyProgressViewStyle get diyProgressViewStyle;

  DiamondDetailScreenStyle get diamondDetailScreenStyle;

  SettingDetailScreenStyle get settingDetailScreenStyle;

  InquiryWidgetStyle get inquiryWidgetStyle;

  SelectionButtonStyle get selectionButtonStyle;

  DiamondListingStyle get diamondListingStyle;

  FilterBottomActionBarStyle get filterBottomActionBarStyle;

  CompleteProductStyle get completeProductStyle;

  SelectedSettingsStyle get selectedSettingsStyle;

  ImageCarouselStyle get imageCarouselStyle;

  CompareProductStyle get compareProductStyle;

  RatingbarStyle get ratingbarStyle;

  AddAddressScreenStyle get addAddressScreenStyle;

  CountryPickerStyle get countryPickerStyle;

  WishListStyle get wishListStyle;

  CheckOutStyle get checkOutStyle;

  MyBagScreenStyle get myBagScreenStyle;

  OrderSummaryStyle get orderSummaryStyle;

  ProductDetailsStyle get productDetailsStyle;

  ReviewDetailsStyle get reviewDetailsStyle;

  OrderConfirmationStyle get orderConfirmationStyle;

  PaymentStyle get paymentStyle;

  WriteReviewScreenStyle get writeReviewScreenStyle;

  MyBagDiamondItemStyle get myBagDiamondItemStyle;

  AddressSelectionStyle get addressSelectionStyle;

  AddressListStyle get addressListStyle;

  AuctionScreenStyle get auctionScreenStyle;

  ProductMenuBottomSheetStyle get productMenuBottomSheetStyle;

  DiamondInfoPopupScreenStyle get diamondInfoPopupScreenStyle;

  QuotationRequestConfirmationStyle get quotationRequestConfirmationStyle;

  ShowDoubleActionDialogStyle get showDoubleActionDialogStyle;

  SmartTabBarStyle get smartTabBarStyle;

  StatusBadgeStyle get statusBadgeStyle;

  OrderCancelPopupStyle get orderCancelPopupStyle;

  OrderPopupStyle get orderPopupStyle;

  OrderDetailScreenStyle get orderDetailScreenStyle;

  TrackOrderBottomSheetStyle get trackOrderBottomSheetStyle;

  AuctionListItemStyle get auctionListItemStyle;

  ProfileScreenStyle get profilePageScreenStyle;

  SmartOptionTileStyle get smartOptionTileStyle;

  OrderTimelineStyle get orderTimelineStyle;

  SmartTileLineStepperStyle get smartTileLineStepperStyle;

  LogoutPopupStyle get logoutPopupStyle;

  PresentationGridItemStyle get presentationGridItemStyle;

  MakeInquiryStyle get makeInquiryStyle;

  QrScannerStyle get qrScannerStyle;

  SearchScreenStyle get searchScreenStyle;

  SearchResultScreenStyle get searchResultScreenStyle;

  SearchResultNotFoundStyle get searchResultNotFoundStyle;

  SupportScreenStyle get supportScreenStyle;

  SmartImageTitleColumnStyle get smartImageTitleColumnStyle;

  SwitchStyle get switchStyle;

  CompanyScreenStyle get companyScreenStyle;

  FAQStyle get faqStyle;

  PreferencesStyle get preferencesStyle;

  DashboardStyle get dashboardStyle;

  ContactUsStyle get contactUsStyle;

  ConceptInfoPopupScreenStyle get conceptInfoPopupScreenStyle;

  PddListingItemStyle get pddListingItemStyle;

  NoDataFoundStyle get noDataFoundStyle;

  SavedAddressStyle get savedAddressStyle;

  HomeScreenStyle get homeScreenStyle;

  MonitoringScreenStyle get monitoringScreenStyle;

  SharePresentationStyle get sharePresentationStyle;

  DigitalCatalogueStyle get digitalCatalogueStyle;

  DesignListingGridItemStyle get designListingGridItemStyle;

  PddVersionHistoryStyle get pddVersionHistoryStyle;

  ProductInfoItemStyle get productInfoItemStyle;

  FindStoreStyle get findStoreStyle;

  CadLibraryListingItemStyle get cadLibraryListingItemStyle;

  ExhibitionDetailsOrdersStyle get exhibitionDetailsOrdersStyle;

  EditWatchlistStyle get editWatchlistStyle;

  DurationPickerStyle get durationPickerStyle;

  DesignLibraryFeedbackStyle get designLibraryFeedbackStyle;

  ExhibitionListingItemStyle get exhibitionListingItemStyle;

  StonesLandingScreenStyle get stonesLandingScreenStyle;

  PreviewCatalogueStyle get previewCatalogueStyle;

  WatchListItemStyle get watchListItemStyle;

  ActivityLogStyle get activityLogStyle;

  WatchlistDetailsStyle get watchlistDetailsStyle;

  SmartSuggestionProductListStyle get smartSuggestionProductListStyle;

  OrionStyle get orionStyle;

  MessagesStyle get messagesStyle;

  TaskDetailsStyle get taskDetailsStyle;

  ExhibitionDetailsItemStyle get exhibitionDetailsItemStyle;

  ReturnOrderStyle get returnOrderStyle;

  ConfirmCancelPopupStyle get confirmCancelPopupStyle;

  CalendarStyle get calendarStyle;

  NewsletterScreenStyle get newsletterScreenStyle;
}

class PrimaryButtonStyle {
  final Color activeBackgroundColor;
  final Color activeWhiteBackgroundColor;
  final Color disableBackgroundColor;
  final TextStyle titleStyle;
  final TextStyle titleWhiteStyle;
  final TextStyle disableTitleStyle;
  final Color activeImageColor;
  final Color activeWhiteImageColor;
  final Color disableImageColor;

  PrimaryButtonStyle({
    required this.activeBackgroundColor,
    required this.activeWhiteBackgroundColor,
    required this.disableBackgroundColor,
    required this.titleStyle,
    required this.titleWhiteStyle,
    required this.disableTitleStyle,
    required this.activeImageColor,
    required this.activeWhiteImageColor,
    required this.disableImageColor,
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
  final Color boxShadowColor;

  TabBarStyle({
    required this.labelStyle,
    required this.unselectedLabelStyle,
    required this.indicatorColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.boxShadowColor,
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
  final Color transparentColor;
  final TextStyle searchBarTextStyle;

  CustomAppBarStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.borderColor,
    required this.transparentColor,
    required this.searchBarTextStyle,
  });
}

class SignInScreenStyle {
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final TextStyle subTitleStyle;
  final TextStyle labelStyle;
  final TextStyle forgotPasswordStyle;
  final TextStyle registerTextStyle;

  SignInScreenStyle({
    required this.labelStyle,
    required this.forgotPasswordStyle,
    required this.backgroundColor,
    required this.titleTextStyle,
    required this.subTitleStyle,
    required this.registerTextStyle,
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
  final TextStyle labelStyle;
  final TextStyle detailStyle;
  final Color backgroundColor;
  final Color dividerLineColor;

  CategoryTileStyle({
    required this.labelStyle,
    required this.backgroundColor,
    required this.detailStyle,
    required this.dividerLineColor,
  });
}

class NotificationScreenStyle {
  final TextStyle tabTitleStyle;
  final Color selectedTabColor;
  final Color unselectedTabColor;

  NotificationScreenStyle({
    required this.tabTitleStyle,
    required this.selectedTabColor,
    required this.unselectedTabColor,
  });
}

class AllNotificationViewStyle {
  final TextStyle titleStyle;
  final TextStyle descStyle;
  final TextStyle timeLabelStyle;
  final TextStyle searchHintStyle;
  final Color dotColor;

  AllNotificationViewStyle({
    required this.titleStyle,
    required this.descStyle,
    required this.timeLabelStyle,
    required this.searchHintStyle,
    required this.dotColor,
  });
}

class SettingViewStyle {
  final TextStyle titleStyle;
  final TextStyle descStyle;
  final Color thumbColor;
  final Color dividerColor;

  SettingViewStyle({
    required this.titleStyle,
    required this.descStyle,
    required this.thumbColor,
    required this.dividerColor,
  });
}

class CollectionViewStyle {
  final Color headerBgColor;
  final TextStyle headerTitleStyle;
  final TextStyle headerSubTitleStyle;
  final TextStyle collectionListTitleStyle;

  CollectionViewStyle(
      {required this.headerBgColor,
      required this.headerTitleStyle,
      required this.headerSubTitleStyle,
      required this.collectionListTitleStyle});
}

class SignUpStyle {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle selectAccountStyle;
  final Color selectedAccountTypeColor;
  final Color selectedAccountTypeBorderColor;
  final Color selectedAccountTypeIconColor;
  final TextStyle selectedAccountTypeTextStyle;
  final Color unselectedAccountTypeColor;
  final Color unselectedAccountTypeBorderColor;
  final Color unselectedAccountTypeIconColor;
  final TextStyle unselectedAccountTypeTextStyle;

  SignUpStyle({
    required this.selectAccountStyle,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.backgroundColor,
    required this.selectedAccountTypeColor,
    required this.selectedAccountTypeBorderColor,
    required this.selectedAccountTypeIconColor,
    required this.selectedAccountTypeTextStyle,
    required this.unselectedAccountTypeColor,
    required this.unselectedAccountTypeBorderColor,
    required this.unselectedAccountTypeIconColor,
    required this.unselectedAccountTypeTextStyle,
  });
}

class RadioButtonStyle {
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final TextStyle textStyle;

  RadioButtonStyle({
    required this.activeColor,
    required this.checkColor,
    required this.borderColor,
    required this.textStyle,
  });
}

class CustomPageIndicatorStyle {
  final Color borderColor;
  final Color textColor;
  final TextStyle textStyle;
  final Color dropDownBackgroundColor;

  CustomPageIndicatorStyle({
    required this.borderColor,
    required this.textColor,
    required this.textStyle,
    required this.dropDownBackgroundColor,
  });
}

class ProductItemStyle {
  final Color backgroundColor;
  final Color productBackgroundColor;
  final Color borderColor;
  final Color outOfStockBackgroundColor;
  final TextStyle productNameStyle;
  final TextStyle priceTextStyle;
  final TextStyle discountTextStyle;
  final TextStyle checkedPriceStyle;
  final TextStyle buttonTextStyle;
  final TextStyle buttonWithIconTextStyle;
  final TextStyle diamondTextStyle;
  final Color transparentColor;
  final TextStyle removeBagTextStyle;
  final Color myBagDividerColor;
  final TextStyle outOfStockStyle;
  final Color commentSelectedColor;

  ProductItemStyle({
    required this.backgroundColor,
    required this.productBackgroundColor,
    required this.productNameStyle,
    required this.priceTextStyle,
    required this.discountTextStyle,
    required this.checkedPriceStyle,
    required this.borderColor,
    required this.buttonTextStyle,
    required this.buttonWithIconTextStyle,
    required this.diamondTextStyle,
    required this.transparentColor,
    required this.removeBagTextStyle,
    required this.myBagDividerColor,
    required this.outOfStockBackgroundColor,
    required this.outOfStockStyle,
    required this.commentSelectedColor,
  });
}

class SmartDropDownStyle {
  final Color borderColor;
  final Color backgroundColor;
  final Color selectedBorderColor;
  final Color unSelectedBorderColor;
  final TextStyle titleTextStyle;
  final TextStyle labelStyle;
  final TextStyle selectedTitleTextStyle;

  SmartDropDownStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.selectedBorderColor,
    required this.unSelectedBorderColor,
    required this.titleTextStyle,
    required this.labelStyle,
    required this.selectedTitleTextStyle,
  });
}

class SortStyle {
  final Color backgroundColor;
  final Color selectedBorderColor;
  final TextStyle titleStyle;
  final TextStyle itemTitleStyle;

  SortStyle({
    required this.backgroundColor,
    required this.selectedBorderColor,
    required this.titleStyle,
    required this.itemTitleStyle,
  });
}

class FilterStyle {
  final Color backgroundColor;
  final Color subFilterBackgroundColor;
  final TextStyle titleStyle;
  final TextStyle selectedTitleStyle;
  final TextStyle itemTitleStyle;
  final TextStyle selectedItemTitleStyle;
  final Color selectedBackgroundColor;
  final Color itemBorderColor;
  final Color closeButtonBackgroundColor;
  final TextStyle closeButtonStyle;
  final Color selectedImageColor;
  final TextStyle advancedFilterTitleStyle;
  final Color advancedFilterBackgroundColor;

  FilterStyle({
    required this.backgroundColor,
    required this.subFilterBackgroundColor,
    required this.titleStyle,
    required this.selectedTitleStyle,
    required this.itemTitleStyle,
    required this.selectedItemTitleStyle,
    required this.selectedBackgroundColor,
    required this.itemBorderColor,
    required this.closeButtonBackgroundColor,
    required this.closeButtonStyle,
    required this.selectedImageColor,
    required this.advancedFilterBackgroundColor,
    required this.advancedFilterTitleStyle,
  });
}

class DiyProgressViewStyle {
  final TextStyle indexStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color selectedBorderColor;
  final Color unselectedBorderColor;

  DiyProgressViewStyle({
    required this.indexStyle,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.selectedBorderColor,
    required this.unselectedBorderColor,
  });
}

class DiamondDetailScreenStyle {
  final TextStyle skuStyle;
  final TextStyle diamondNameStyle;
  final TextStyle reviewStyle;
  final TextStyle priceStyle;
  final TextStyle seeProductStyle;
  final TextStyle orderSampleStyle;
  final TextStyle diamondPurityStyle;
  final TextStyle shippingStyle;
  final TextStyle selectDiamondStyle;

  DiamondDetailScreenStyle({
    required this.skuStyle,
    required this.diamondNameStyle,
    required this.reviewStyle,
    required this.priceStyle,
    required this.seeProductStyle,
    required this.orderSampleStyle,
    required this.diamondPurityStyle,
    required this.shippingStyle,
    required this.selectDiamondStyle,
  });
}

class SettingDetailScreenStyle {
  final TextStyle ringTypeStyle;
  final TextStyle ringCodeStyle;
  final TextStyle ringNameStyle;
  final TextStyle reviewStyle;
  final TextStyle metalHeaderStyle;
  final TextStyle metalNameStyle;
  final TextStyle selectedMetalNameStyle;
  final TextStyle approxPriceLabelStyle;
  final TextStyle priceStyle;
  final TextStyle buyInBulkStyle;
  final TextStyle askQuestionStyle;
  final TextStyle approxPriceNoteStyle;
  final TextStyle diamondPurityStyle;
  final TextStyle shippingStyle;
  final TextStyle selectSettingStyle;
  final TextStyle settingTypeStyle;
  final TextStyle settingValueStyle;
  final TextStyle settingHeaderStyle;
  final Color selectedSettingBorderColor;
  final Color settingSelectionButtonColor;
  final TextStyle settingSelectionValueStyle;
  final TextStyle selectedSettingStyle;

  SettingDetailScreenStyle({
    required this.ringTypeStyle,
    required this.ringCodeStyle,
    required this.ringNameStyle,
    required this.reviewStyle,
    required this.metalHeaderStyle,
    required this.metalNameStyle,
    required this.selectedMetalNameStyle,
    required this.approxPriceLabelStyle,
    required this.priceStyle,
    required this.buyInBulkStyle,
    required this.askQuestionStyle,
    required this.approxPriceNoteStyle,
    required this.diamondPurityStyle,
    required this.shippingStyle,
    required this.selectSettingStyle,
    required this.settingTypeStyle,
    required this.settingValueStyle,
    required this.settingHeaderStyle,
    required this.selectedSettingBorderColor,
    required this.settingSelectionButtonColor,
    required this.settingSelectionValueStyle,
    required this.selectedSettingStyle,
  });
}

class InquiryWidgetStyle {
  final TextStyle haveAQuestionStyle;
  final TextStyle reachOutStyle;
  final TextStyle phoneStyle;
  final TextStyle emailStyle;

  InquiryWidgetStyle({
    required this.haveAQuestionStyle,
    required this.reachOutStyle,
    required this.phoneStyle,
    required this.emailStyle,
  });
}

class SelectionButtonStyle {
  final Color selectedButtonColor;
  final Color unselectedButtonColor;
  final Color selectedButtonBorderColor;
  final Color unselectedButtonBorderColor;
  final Color selectedButtonIconColor;
  final Color unselectedButtonIconColor;
  final TextStyle selectedButtonTextStyle;
  final TextStyle unselectedButtonTextStyle;

  SelectionButtonStyle({
    required this.selectedButtonColor,
    required this.unselectedButtonColor,
    required this.selectedButtonBorderColor,
    required this.unselectedButtonBorderColor,
    required this.selectedButtonIconColor,
    required this.unselectedButtonIconColor,
    required this.selectedButtonTextStyle,
    required this.unselectedButtonTextStyle,
  });
}

class DiamondListingStyle {
  final TextStyle filterProductCountTextStyle;
  final Color gridBackgroundColor;
  final Color gridBorderColor;
  final Color gridIconColor;
  final Color listBackgroundColor;
  final Color listBorderColor;
  final Color listIconColor;
  final Color menuBackgroundColor;
  final Color menuBorderColor;

  DiamondListingStyle({
    required this.filterProductCountTextStyle,
    required this.gridBackgroundColor,
    required this.gridBorderColor,
    required this.listBackgroundColor,
    required this.listBorderColor,
    required this.menuBackgroundColor,
    required this.menuBorderColor,
    required this.gridIconColor,
    required this.listIconColor,
  });
}

class FilterBottomActionBarStyle {
  final Color borderColor;
  final Color transparentColor;
  final Color dividerColor;

  const FilterBottomActionBarStyle({
    required this.borderColor,
    required this.transparentColor,
    required this.dividerColor,
  });
}

class CompleteProductStyle {
  final TextStyle productTypeStyle;
  final TextStyle productCodeStyle;
  final Color dotColor;
  final TextStyle productNameStyle;
  final Color ratingGlowColor;
  final TextStyle priceStyle;
  final TextStyle detailsHeaderStyle;
  final TextStyle diamondPurityStyle;

  CompleteProductStyle({
    required this.productTypeStyle,
    required this.productCodeStyle,
    required this.dotColor,
    required this.productNameStyle,
    required this.ratingGlowColor,
    required this.priceStyle,
    required this.detailsHeaderStyle,
    required this.diamondPurityStyle,
  });
}

class SelectedSettingsStyle {
  final Color iconColor;
  final TextStyle titleStyle;
  final TextStyle specialityStyle;
  final TextStyle changeTextStyle;

  SelectedSettingsStyle({
    required this.iconColor,
    required this.titleStyle,
    required this.specialityStyle,
    required this.changeTextStyle,
  });
}

class ImageCarouselStyle {
  final Color dotColor;
  final Color selectedDotColor;

  ImageCarouselStyle({
    required this.dotColor,
    required this.selectedDotColor,
  });
}

class CompareProductStyle {
  final TextStyle productTitleStyle;
  final TextStyle productSubTitleStyle;
  final TextStyle productPriceStyle;
  final TextStyle productReviewStyle;
  final TextStyle productRemoveStyle;
  final Color primaryColor;

  CompareProductStyle({
    required this.productTitleStyle,
    required this.productSubTitleStyle,
    required this.productPriceStyle,
    required this.productReviewStyle,
    required this.productRemoveStyle,
    required this.primaryColor,
  });
}

class RatingbarStyle {
  final Color fillStarColor;
  final Color emptyStarColor;

  RatingbarStyle({
    required this.fillStarColor,
    required this.emptyStarColor,
  });
}

class AddAddressScreenStyle {
  final Color backgroundColor;
  final Color dotColor;
  final Color filledDotColor;
  final Color fillLineColor;
  final Color borderColor;
  final TextStyle shippingBillingAddressStyle;
  final TextStyle paymentStyle;
  final TextStyle isSameAddressStyle;

  AddAddressScreenStyle({
    required this.backgroundColor,
    required this.dotColor,
    required this.filledDotColor,
    required this.fillLineColor,
    required this.borderColor,
    required this.shippingBillingAddressStyle,
    required this.paymentStyle,
    required this.isSameAddressStyle,
  });
}

class CountryPickerStyle {
  final Color backgroundColor;
  final Color searchBorderColor;
  final Color inputBorderColor;
  final TextStyle inputTextStyle;
  final TextStyle inputLableStyle;

  CountryPickerStyle({
    required this.backgroundColor,
    required this.searchBorderColor,
    required this.inputBorderColor,
    required this.inputTextStyle,
    required this.inputLableStyle,
  });
}

class WishListStyle {
  final TextStyle numberOfItemsStyle;
  final TextStyle totalAmountStyle;

  WishListStyle({
    required this.numberOfItemsStyle,
    required this.totalAmountStyle,
  });
}

class CheckOutStyle {
  final Color dividerColor;

  CheckOutStyle({
    required this.dividerColor,
  });
}

class MyBagScreenStyle {
  final Color backgroundColor;
  final TextStyle productsTitleStyle;
  final TextStyle itemSelectedStyle;
  final TextStyle totalAmountStyle;
  final TextStyle diamondPurityStyle;
  final Color bottomNavBarShadowColor;
  final TextStyle bottomBarTotalTextStyle;
  final TextStyle bottomBarTotalAmountTextStyle;
  final TextStyle bottomBarMoreLessTextStyle;
  final TextStyle textInfoValueStyle;
  final Color menuBorderColor;
  final Color menuIconColor;

  MyBagScreenStyle({
    required this.backgroundColor,
    required this.productsTitleStyle,
    required this.itemSelectedStyle,
    required this.totalAmountStyle,
    required this.diamondPurityStyle,
    required this.bottomNavBarShadowColor,
    required this.bottomBarTotalTextStyle,
    required this.bottomBarTotalAmountTextStyle,
    required this.bottomBarMoreLessTextStyle,
    required this.textInfoValueStyle,
    required this.menuBorderColor,
    required this.menuIconColor,
  });
}

class OrderSummaryStyle {
  final Color backgroundColor;
  final TextStyle orderSummaryTitleStyle;
  final TextStyle orderSummaryItemStyle;
  final TextStyle orderSummaryItemValueStyle;
  final TextStyle addPromoCodeStyle;
  final TextStyle totalPriceStyle;

  OrderSummaryStyle({
    required this.backgroundColor,
    required this.orderSummaryTitleStyle,
    required this.orderSummaryItemStyle,
    required this.addPromoCodeStyle,
    required this.totalPriceStyle,
    required this.orderSummaryItemValueStyle,
  });
}

class ProductDetailsStyle {
  final TextStyle productTypeStyle;
  final TextStyle productCodeStyle;
  final Color dotColor;
  final TextStyle productNameStyle;
  final Color ratingGlowColor;
  final TextStyle compareProductStyle;
  final TextStyle priceStyle;
  final TextStyle originalPriceStyle;
  final TextStyle discountStyle;
  final TextStyle settingSelectionTitleStyle;
  final TextStyle settingSelectionValueStyle;
  final TextStyle selectedSettingStyle;
  final Color selectedSettingBorderColor;
  final Color settingSelectionButtonColor;
  final Color customiseBoxBorderColor;
  final Color customiseBoxColor;
  final TextStyle diamondPurityStyle;
  final TextStyle customerReviewTitleStyle;
  final TextStyle averageRatingStyle;
  final TextStyle viewAllReviewStyle;
  final Color compareCountBGColor;
  final TextStyle totalApproxStyle;
  final TextStyle totalApproxSubStyle;
  final TextStyle orderSampleStyle;
  final TextStyle bottomNavBarSubTitleStyle;
  final Color whiteColor;

  ProductDetailsStyle({
    required this.productTypeStyle,
    required this.productCodeStyle,
    required this.dotColor,
    required this.productNameStyle,
    required this.ratingGlowColor,
    required this.compareProductStyle,
    required this.priceStyle,
    required this.originalPriceStyle,
    required this.discountStyle,
    required this.settingSelectionTitleStyle,
    required this.settingSelectionValueStyle,
    required this.selectedSettingStyle,
    required this.selectedSettingBorderColor,
    required this.settingSelectionButtonColor,
    required this.customiseBoxBorderColor,
    required this.customiseBoxColor,
    required this.diamondPurityStyle,
    required this.customerReviewTitleStyle,
    required this.averageRatingStyle,
    required this.viewAllReviewStyle,
    required this.compareCountBGColor,
    required this.totalApproxStyle,
    required this.totalApproxSubStyle,
    required this.orderSampleStyle,
    required this.bottomNavBarSubTitleStyle,
    required this.whiteColor,
  });
}

class ReviewDetailsStyle {
  final TextStyle userNameStyle;
  final Color dotColor;
  final TextStyle createdDateStyle;
  final TextStyle titleStyle;
  final TextStyle readMoreStyle;

  ReviewDetailsStyle(
      {required this.userNameStyle,
      required this.dotColor,
      required this.createdDateStyle,
      required this.titleStyle,
      required this.readMoreStyle});
}

class OrderConfirmationStyle {
  final TextStyle titleTextStyle;
  final TextStyle subTitleStyle;
  final TextStyle orderNumberStyle;
  final TextStyle descriptionStyle;

  OrderConfirmationStyle({
    required this.titleTextStyle,
    required this.subTitleStyle,
    required this.orderNumberStyle,
    required this.descriptionStyle,
  });
}

class PaymentStyle {
  final Color backgroundColor;
  final Color dotColor;
  final Color filledDotColor;
  final Color fillLineColor;
  final Color borderColor;
  final TextStyle shippingBillingAddressStyle;
  final TextStyle paymentStyle;
  final TextStyle isSameAddressStyle;
  final TextStyle footerTotalStyle;
  final TextStyle footerTotalAmountStyle;

  PaymentStyle({
    required this.backgroundColor,
    required this.dotColor,
    required this.filledDotColor,
    required this.fillLineColor,
    required this.borderColor,
    required this.shippingBillingAddressStyle,
    required this.paymentStyle,
    required this.isSameAddressStyle,
    required this.footerTotalStyle,
    required this.footerTotalAmountStyle,
  });
}

class MyBagDiamondItemStyle {
  final Color backgroundColor;
  final Color borderColor;
  final TextStyle headingStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle richTextStyle;
  final Color selectedBackgroundColor;

  MyBagDiamondItemStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.headingStyle,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.richTextStyle,
    required this.selectedBackgroundColor,
  });
}

class AddressSelectionStyle {
  final TextStyle addressNameStyle;
  final TextStyle fullAddressStyle;
  final TextStyle contactNumberStyle;
  final TextStyle defaultTagStyle;
  final Color defaultTagColor;

  AddressSelectionStyle({
    required this.addressNameStyle,
    required this.fullAddressStyle,
    required this.contactNumberStyle,
    required this.defaultTagStyle,
    required this.defaultTagColor,
  });
}

class AddressListStyle {
  final Color backgroundColor;
  final Color whiteColor;
  final Color arrowColor;
  final TextStyle isSameAddressStyle;
  final TextStyle nProductsTitleStyle;

  final TextStyle footerTotalAmountStyle;

  AddressListStyle({
    required this.backgroundColor,
    required this.arrowColor,
    required this.isSameAddressStyle,
    required this.nProductsTitleStyle,
    required this.footerTotalAmountStyle,
    required this.whiteColor,
  });
}

class WriteReviewScreenStyle {
  final Color whiteColor;
  final Color borderColor;
  final TextStyle labelStyle;

  WriteReviewScreenStyle({
    required this.whiteColor,
    required this.labelStyle,
    required this.borderColor,
  });
}

class ProductMenuBottomSheetStyle {
  final Color backgroundColor;
  final Color primaryColor;
  final TextStyle subTotalStyle;
  final TextStyle moreDetailsStyle;
  final TextStyle totalAmountStyle;
  final TextStyle imageLableStyle;
  final TextStyle diamondTitleStyle;
  final TextStyle diamondValueStyle;

  ProductMenuBottomSheetStyle({
    required this.backgroundColor,
    required this.primaryColor,
    required this.subTotalStyle,
    required this.moreDetailsStyle,
    required this.totalAmountStyle,
    required this.imageLableStyle,
    required this.diamondTitleStyle,
    required this.diamondValueStyle,
  });
}

class AuctionScreenStyle {
  final TextStyle bidPriceLableStyle;
  final TextStyle bidPriceStyle;
  final Color primaryColor;
  final TextStyle auctionTimerStyle;
  final TextStyle recentBidStyle;
  final TextStyle recentBidValueStyle;
  final Color recentBidBackgroundColor;
  final Color borderColor;
  final Color whiteColor;
  final TextStyle allBidsTitleStyle;
  final TextStyle myBidTextStyle;
  final Color myBidBackgroundColor;
  final Color textFieldBorderColor;
  final Color boxShadowColor;
  final Color compareCountBGColor;

  AuctionScreenStyle({
    required this.bidPriceLableStyle,
    required this.bidPriceStyle,
    required this.primaryColor,
    required this.auctionTimerStyle,
    required this.recentBidStyle,
    required this.recentBidValueStyle,
    required this.recentBidBackgroundColor,
    required this.borderColor,
    required this.whiteColor,
    required this.allBidsTitleStyle,
    required this.myBidTextStyle,
    required this.myBidBackgroundColor,
    required this.textFieldBorderColor,
    required this.boxShadowColor,
    required this.compareCountBGColor,
  });
}

class DiamondInfoPopupScreenStyle {
  final TextStyle offerPriceStyle;
  final TextStyle actualPriceStyle;
  final TextStyle productNameStyle;
  final TextStyle labelStyle;
  final TextStyle itemTitleStyle;
  final TextStyle itemValueStyle;
  final TextStyle viewMoreDetailsTextStyle;

  DiamondInfoPopupScreenStyle({
    required this.offerPriceStyle,
    required this.actualPriceStyle,
    required this.productNameStyle,
    required this.labelStyle,
    required this.itemTitleStyle,
    required this.itemValueStyle,
    required this.viewMoreDetailsTextStyle,
  });
}

class QuotationRequestConfirmationStyle {
  final TextStyle titleStyle;
  final TextStyle detailsTextStyle;
  final Color primaryColor;

  QuotationRequestConfirmationStyle({
    required this.titleStyle,
    required this.detailsTextStyle,
    required this.primaryColor,
  });
}

class ShowDoubleActionDialogStyle {
  final TextStyle titleStyle;
  final TextStyle contentStyle;
  final TextStyle okButtonStyle;

  ShowDoubleActionDialogStyle({
    required this.titleStyle,
    required this.contentStyle,
    required this.okButtonStyle,
  });
}

class SmartTabBarStyle {
  final TextStyle selectedTabTextStyle;
  final TextStyle unselectedTabTextStyle;
  final Color primaryColor;
  final Color tabDividerColor;
  final Color labelColor;
  final Color unselectedLabelColor;

  SmartTabBarStyle({
    required this.selectedTabTextStyle,
    required this.unselectedTabTextStyle,
    required this.primaryColor,
    required this.tabDividerColor,
    required this.labelColor,
    required this.unselectedLabelColor,
  });
}

class StatusBadgeStyle {
  final TextStyle statusTextStyle;
  final Color orangeInProgressBackgroundColor;
  final Color orangeInProgressTextColor;
  final Color activeBackgroundColor;
  final Color activeTextColor;
  final Color lostBackgroundColor;
  final Color lostTextColor;
  final Color blueInProgressBackgroundColor;
  final Color blueInProgressTextColor;

  StatusBadgeStyle({
    required this.orangeInProgressBackgroundColor,
    required this.orangeInProgressTextColor,
    required this.activeBackgroundColor,
    required this.activeTextColor,
    required this.statusTextStyle,
    required this.lostBackgroundColor,
    required this.lostTextColor,
    required this.blueInProgressBackgroundColor,
    required this.blueInProgressTextColor,
  });
}

class OrderCancelPopupStyle {
  final Color primaryColor;
  final Color crossColor;
  final Color refundBgColor;
  final Color whiteColor;
  final TextStyle headerTitleStyle;
  final TextStyle subTitleStyle;
  final TextStyle refundTitleStyle;
  final TextStyle amountTitleStyle;
  final TextStyle cancelReasonTitleStyle;

  OrderCancelPopupStyle({
    required this.primaryColor,
    required this.crossColor,
    required this.refundBgColor,
    required this.whiteColor,
    required this.headerTitleStyle,
    required this.subTitleStyle,
    required this.refundTitleStyle,
    required this.amountTitleStyle,
    required this.cancelReasonTitleStyle,
  });
}

class OrderPopupStyle {
  final TextStyle optionTextStyle;
  final TextStyle cancelTextStyle;
  final Color whiteColor;

  OrderPopupStyle({
    required this.optionTextStyle,
    required this.cancelTextStyle,
    required this.whiteColor,
  });
}

class OrderDetailScreenStyle {
  final Color detailsTileColor;
  final TextStyle orderIdStyle;
  final TextStyle orderDateStyle;
  final TextStyle orderTotalStyle;
  final TextStyle orderItemLabelStyle;
  final TextStyle orderItemValueStyle;
  final TextStyle priceTextStyle;

  OrderDetailScreenStyle({
    required this.detailsTileColor,
    required this.orderIdStyle,
    required this.orderDateStyle,
    required this.orderTotalStyle,
    required this.orderItemLabelStyle,
    required this.orderItemValueStyle,
    required this.priceTextStyle,
  });
}

class TrackOrderBottomSheetStyle {
  final Color backgroundColor;
  final Color orderInfoBackgroundColor;
  final TextStyle titleStyle;
  final TextStyle orderIdStyle;
  final TextStyle imageSubTitleStyle;
  final TextStyle imageTitleStyle;
  final TextStyle quantityStyle;

  TrackOrderBottomSheetStyle({
    required this.backgroundColor,
    required this.orderInfoBackgroundColor,
    required this.titleStyle,
    required this.orderIdStyle,
    required this.imageSubTitleStyle,
    required this.imageTitleStyle,
    required this.quantityStyle,
  });
}

class AuctionListItemStyle {
  final Color borderColor;
  final Color primaryColor;
  final TextStyle titleStyle;
  final TextStyle valueStyle;
  final TextStyle productNameStyle;

  AuctionListItemStyle({
    required this.borderColor,
    required this.primaryColor,
    required this.titleStyle,
    required this.valueStyle,
    required this.productNameStyle,
  });
}

class SmartTileLineStepperStyle {
  final Color completedIndicatorColor;
  final Color upcomingIndicatorColor;
  final Color upcomingColor;
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;

  SmartTileLineStepperStyle({
    required this.completedIndicatorColor,
    required this.upcomingIndicatorColor,
    required this.upcomingColor,
    required this.titleStyle,
    required this.subtitleStyle,
  });
}

class ProfileScreenStyle {
  final Color backgroundColor;
  final Color primaryColor;
  final Color dividerColor;
  final Color arrowRightColor;
  final Color transparentColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle subTextStyle;
  final TextStyle listTitleStyle;
  final TextStyle expandTitleStyle;
  final TextStyle fontTextStyle;
  final TextStyle logoutTextStyle;
  final TextStyle bottomTitleStyle;

  ProfileScreenStyle(
      {required this.backgroundColor,
      required this.primaryColor,
      required this.dividerColor,
      required this.arrowRightColor,
      required this.transparentColor,
      required this.titleStyle,
      required this.subTitleStyle,
      required this.subTextStyle,
      required this.listTitleStyle,
      required this.expandTitleStyle,
      required this.fontTextStyle,
      required this.logoutTextStyle,
      required this.bottomTitleStyle});
}

class SmartOptionTileStyle {
  final Color arrowRightColor;
  final Color transparentColor;
  final TextStyle titleStyle;
  final TextStyle subTextStyle;
  final Color primaryColor;

  SmartOptionTileStyle({
    required this.arrowRightColor,
    required this.transparentColor,
    required this.titleStyle,
    required this.subTextStyle,
    required this.primaryColor,
  });
}

class OrderTimelineStyle {
  final Color backgroundColor;
  final Color whiteColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle timeStyle;
  final TextStyle dateTagStyle;
  final Color dateTagBorderColor;

  OrderTimelineStyle({
    required this.backgroundColor,
    required this.whiteColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.timeStyle,
    required this.dateTagStyle,
    required this.dateTagBorderColor,
  });
}

class LogoutPopupStyle {
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color whiteColor;
  final TextStyle cancelTextStyle;

  LogoutPopupStyle({
    required this.titleStyle,
    required this.subTitleStyle,
    required this.whiteColor,
    required this.cancelTextStyle,
  });
}

class PresentationGridItemStyle {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color borderColor;

  PresentationGridItemStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.borderColor,
  });
}

class MakeInquiryStyle {
  final TextStyle titleStyle;
  final Color whiteColor;

  MakeInquiryStyle({
    required this.titleStyle,
    required this.whiteColor,
  });
}

class SearchScreenStyle {
  final TextStyle titleStyle;
  final TextStyle searchItemStyle;
  final TextStyle searchByCategoryStyle;
  final Color searchByCategoryColor;
  final Color searchByCategoryItemBorderColor;
  final Color whiteColor;

  SearchScreenStyle({
    required this.titleStyle,
    required this.searchItemStyle,
    required this.searchByCategoryStyle,
    required this.searchByCategoryColor,
    required this.searchByCategoryItemBorderColor,
    required this.whiteColor,
  });
}

class SupportScreenStyle {
  final TextStyle frequentlyAskedQuestionStyle;
  final TextStyle questionStyle;
  final TextStyle answerStyle;

  SupportScreenStyle({
    required this.frequentlyAskedQuestionStyle,
    required this.questionStyle,
    required this.answerStyle,
  });
}

class QrScannerStyle {
  final TextStyle titleStyle;
  final Color overLayColor;

  QrScannerStyle({
    required this.titleStyle,
    required this.overLayColor,
  });
}

class SearchResultScreenStyle {
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle appbarTextStyle;
  final TextStyle foundItemStyle;
  final TextStyle needHelpStyle;
  final TextStyle needHelpTitleStyle;
  final TextStyle phoneNumberStyle;
  final Color needHelpColor;
  final TextStyle shopDiamondsByShapeTitleStyle;
  final Color newlyLaunchedBackgroundColor;
  final Color exploreDigitalCatalogBackgroundColor;
  final Color whiteColor;

  SearchResultScreenStyle({
    required this.titleStyle,
    required this.subTitleStyle,
    required this.appbarTextStyle,
    required this.foundItemStyle,
    required this.needHelpStyle,
    required this.needHelpTitleStyle,
    required this.phoneNumberStyle,
    required this.needHelpColor,
    required this.shopDiamondsByShapeTitleStyle,
    required this.newlyLaunchedBackgroundColor,
    required this.exploreDigitalCatalogBackgroundColor,
    required this.whiteColor,
  });
}

class SearchResultNotFoundStyle {
  final TextStyle needHelpStyle;
  final TextStyle needHelpTitleStyle;
  final TextStyle phoneNumberStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color needHelpColor;
  final TextStyle shopDiamondsByShapeTitleStyle;

  SearchResultNotFoundStyle({
    required this.needHelpStyle,
    required this.needHelpTitleStyle,
    required this.phoneNumberStyle,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.needHelpColor,
    required this.shopDiamondsByShapeTitleStyle,
  });
}

class SmartImageTitleColumnStyle {
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  SmartImageTitleColumnStyle({required this.titleStyle, required this.subTitleStyle});
}

class CompanyScreenStyle {
  final TextStyle titleStyle;
  final TextStyle textStyle;
  final Color primaryColor;

  CompanyScreenStyle({
    required this.titleStyle,
    required this.textStyle,
    required this.primaryColor,
  });
}

class SwitchStyle {
  final Color trackColor;
  final Color thumbColor;
  final Color activeTrackColor;
  final Color inactiveTrackColor;
  final Color inactiveThumbColor;

  SwitchStyle({
    required this.trackColor,
    required this.thumbColor,
    required this.activeTrackColor,
    required this.inactiveTrackColor,
    required this.inactiveThumbColor,
  });
}

class FAQStyle {
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final TextStyle questionStyle;
  final TextStyle answerStyle;
  final TextStyle contactDescriptionStyle;
  final TextStyle contactDetailsStyle;

  FAQStyle({
    required this.titleStyle,
    required this.subtitleStyle,
    required this.questionStyle,
    required this.answerStyle,
    required this.contactDescriptionStyle,
    required this.contactDetailsStyle,
  });
}

class PreferencesStyle {
  final TextStyle titleStyle;

  PreferencesStyle({
    required this.titleStyle,
  });
}

class ContactUsStyle {
  final TextStyle headerTitleStyle;
  final TextStyle messageStyle;
  final TextStyle titleStyle;
  final TextStyle subHeaderTitleStyle;
  final TextStyle subMessageStyle;
  final TextStyle subMessageDescriptionStyle;
  final TextStyle contactDetailsStyle;

  ContactUsStyle({
    required this.headerTitleStyle,
    required this.messageStyle,
    required this.titleStyle,
    required this.subHeaderTitleStyle,
    required this.subMessageStyle,
    required this.subMessageDescriptionStyle,
    required this.contactDetailsStyle,
  });
}

class DashboardStyle {
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle positiveAmountStyle;
  final TextStyle negativeAmountStyle;
  final TextStyle comparedToTextStyle;

  DashboardStyle({
    required this.titleStyle,
    required this.subTitleStyle,
    required this.positiveAmountStyle,
    required this.negativeAmountStyle,
    required this.comparedToTextStyle,
  });
}

class ConceptInfoPopupScreenStyle {
  final TextStyle titleStyle;
  final TextStyle detailsTextStyle;
  final Color iconColor;

  ConceptInfoPopupScreenStyle({
    required this.titleStyle,
    required this.detailsTextStyle,
    required this.iconColor,
  });
}

class NoDataFoundStyle {
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  NoDataFoundStyle({
    required this.titleStyle,
    required this.subTitleStyle,
  });
}

class PddListingItemStyle {
  final Color borderColor;

  PddListingItemStyle({
    required this.borderColor,
  });
}

class SavedAddressStyle {
  final TextStyle titleStyle;
  final TextStyle addressNameStyle;
  final TextStyle addressLineStyle;
  final Color borderColor;
  final Color whiteColor;
  final Color primaryColor;
  final BoxShadow boxShadow;

  SavedAddressStyle({
    required this.titleStyle,
    required this.addressNameStyle,
    required this.addressLineStyle,
    required this.borderColor,
    required this.whiteColor,
    required this.primaryColor,
    required this.boxShadow,
  });
}

class HomeScreenStyle {
  final Color primaryColor;
  final Color whiteColor;
  final Color borderColor;
  final Color viewAllCollectionsBgColor;
  final Color shopGemstoneBgColor;
  final Color textStyleColor;
  final TextStyle bannerTitleStyle;
  final TextStyle shopGemstoneTitleStyle;
  final TextStyle viewAllCollectionsTextStyle;
  final TextStyle createOwnSignatureTitleStyle;
  final TextStyle createOwnSignatureSubTitleStyle;
  final TextStyle stepTextStyle;
  final TextStyle stepValueStyle;
  final TextStyle getInspiredTitleStyle;
  final TextStyle dropDownTextStyle;

  HomeScreenStyle({
    required this.primaryColor,
    required this.whiteColor,
    required this.borderColor,
    required this.bannerTitleStyle,
    required this.shopGemstoneBgColor,
    required this.viewAllCollectionsBgColor,
    required this.viewAllCollectionsTextStyle,
    required this.shopGemstoneTitleStyle,
    required this.createOwnSignatureTitleStyle,
    required this.createOwnSignatureSubTitleStyle,
    required this.stepTextStyle,
    required this.stepValueStyle,
    required this.getInspiredTitleStyle,
    required this.textStyleColor,
    required this.dropDownTextStyle,
  });
}

class MonitoringScreenStyle {
  final TextStyle bottomSheetTitleStyle;
  final Color whiteColor;
  final TextStyle subTitleStyle;
  final TextStyle designerNameStyle;
  final Color closeColor;
  final Color primaryColor;
  final TextStyle addressNameStyle;

  MonitoringScreenStyle({
    required this.bottomSheetTitleStyle,
    required this.whiteColor,
    required this.subTitleStyle,
    required this.designerNameStyle,
    required this.closeColor,
    required this.primaryColor,
    required this.addressNameStyle,
  });
}

class SharePresentationStyle {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle iconButtonTextStyle;
  final TextStyle userListTitleStyle;
  final TextStyle userNamesTextStyle;
  final TextStyle userEmailTextStyle;
  final TextStyle userRoleStyle;
  final Color closeIconColor;

  SharePresentationStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.iconButtonTextStyle,
    required this.userListTitleStyle,
    required this.userNamesTextStyle,
    required this.userEmailTextStyle,
    required this.userRoleStyle,
    required this.closeIconColor,
  });
}

class DigitalCatalogueStyle {
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color borderColor;

  DigitalCatalogueStyle({
    required this.titleStyle,
    required this.subTitleStyle,
    required this.borderColor,
  });
}

class DesignListingGridItemStyle {
  final TextStyle dbfNumberTextStyle;
  final TextStyle salesManTextStyle;

  DesignListingGridItemStyle({
    required this.dbfNumberTextStyle,
    required this.salesManTextStyle,
  });
}

class ProductInfoItemStyle {
  final TextStyle stoneShapeTextStyle;
  final TextStyle labelTextStyle;
  final TextStyle valueTextStyle;
  final TextStyle moreDetailsTextStyle;

  ProductInfoItemStyle({
    required this.stoneShapeTextStyle,
    required this.labelTextStyle,
    required this.valueTextStyle,
    required this.moreDetailsTextStyle,
  });
}

class FindStoreStyle {
  final TextStyle storeMessageStyle;
  final TextStyle enterAddressStyle;
  final TextStyle useCurrentLocationStyle;
  final TextStyle addressTitleStyle;
  final TextStyle addressStyle;
  final Color primaryColor;
  final Color addressBgColor;

  FindStoreStyle({
    required this.storeMessageStyle,
    required this.enterAddressStyle,
    required this.useCurrentLocationStyle,
    required this.addressTitleStyle,
    required this.addressStyle,
    required this.primaryColor,
    required this.addressBgColor,
  });
}

class PddVersionHistoryStyle {
  final Color whiteColor;
  final Color backgroundColor;

  PddVersionHistoryStyle({
    required this.whiteColor,
    required this.backgroundColor,
  });
}

class CadLibraryListingItemStyle {
  final Color backgroundColor;
  final Color cadBackgroundColor;
  final TextStyle cadNameStyle;
  final TextStyle cadNumberStyle;

  CadLibraryListingItemStyle({
    required this.backgroundColor,
    required this.cadBackgroundColor,
    required this.cadNameStyle,
    required this.cadNumberStyle,
  });
}

class ExhibitionDetailsOrdersStyle {
  final Color borderColor;
  final Color primaryColor;
  final TextStyle titleStyle;
  final TextStyle valueStyle;
  final TextStyle productNameStyle;

  ExhibitionDetailsOrdersStyle({
    required this.borderColor,
    required this.primaryColor,
    required this.titleStyle,
    required this.valueStyle,
    required this.productNameStyle,
  });
}

class EditWatchlistStyle {
  final Color backgroundColor;
  final Color primaryColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle timeDurationStyle;
  final TextStyle timeDurationValueStyle;
  final TextStyle timeDurationDescStyle;
  final Color durationBackgroundColor;

  EditWatchlistStyle({
    required this.backgroundColor,
    required this.primaryColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.timeDurationStyle,
    required this.timeDurationValueStyle,
    required this.timeDurationDescStyle,
    required this.durationBackgroundColor,
  });
}

class DurationPickerStyle {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  DurationPickerStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.subTitleStyle,
  });
}

class DesignLibraryFeedbackStyle {
  final Color listBackgroundColor;
  final TextStyle idStyle;
  final TextStyle designNameStyle;
  final TextStyle daysAgoStyle;
  final TextStyle designMessageStyle;
  final Color whiteColor;
  final Color addCommentButtonBgColor;

  DesignLibraryFeedbackStyle({
    required this.listBackgroundColor,
    required this.idStyle,
    required this.designNameStyle,
    required this.daysAgoStyle,
    required this.designMessageStyle,
    required this.whiteColor,
    required this.addCommentButtonBgColor,
  });
}

class ExhibitionListingItemStyle {
  final Color backgroundColor;
  final Color textBackgroundColor;
  final Color borderColor;
  final Color iconColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle listTextStyle;
  final TextStyle listTitleStyle;
  final TextStyle listAuthorStyle;
  final TextStyle listSubTitleStyle;
  final TextStyle listStatusStyle;

  ExhibitionListingItemStyle({
    required this.backgroundColor,
    required this.textBackgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.listTextStyle,
    required this.listTitleStyle,
    required this.listAuthorStyle,
    required this.listSubTitleStyle,
    required this.listStatusStyle,
  });
}

class StonesLandingScreenStyle {
  final Color whiteColor;
  final Color primaryColor;
  final TextStyle sparkleTitleStyle;
  final TextStyle sparkleSubTitleStyle;
  final TextStyle sectionLabelStyle;
  final TextStyle craftedSectionTitleStyle;
  final Color originSectionBgColor;
  final TextStyle originSectionSubTitleStyle;
  final TextStyle designOwnEarringTextStyle;
  final Color designYourOwnStoneBgColor;
  final TextStyle learnMoreTextStyle;
  final TextStyle newlyLaunchedStyle;
  final Color newlyLaunchedBackgroundColor;
  final TextStyle jewelleryCreateOwnSubTitleStyle;

  StonesLandingScreenStyle({
    required this.whiteColor,
    required this.primaryColor,
    required this.sparkleTitleStyle,
    required this.sparkleSubTitleStyle,
    required this.sectionLabelStyle,
    required this.craftedSectionTitleStyle,
    required this.originSectionBgColor,
    required this.originSectionSubTitleStyle,
    required this.designOwnEarringTextStyle,
    required this.designYourOwnStoneBgColor,
    required this.learnMoreTextStyle,
    required this.newlyLaunchedStyle,
    required this.newlyLaunchedBackgroundColor,
    required this.jewelleryCreateOwnSubTitleStyle,
  });
}

class PreviewCatalogueStyle {
  final Color backgroundColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color stepBorderColor;
  final Color selectedStepBorderColor;
  final TextStyle stepTextStyle;
  final TextStyle selectedStepTextStyle;
  final Color whiteColor;

  final BoxShadow boxShadow;

  PreviewCatalogueStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.stepBorderColor,
    required this.selectedStepBorderColor,
    required this.stepTextStyle,
    required this.selectedStepTextStyle,
    required this.whiteColor,
    required this.boxShadow,
  });
}

class WatchListItemStyle {
  final Color backgroundColor;
  final Color dividerColor;
  final Color primaryColor;
  final Color disableBackgroundColor;
  final Color outOfStockBgColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle subTextStyle;
  final TextStyle listTextStyle;
  final TextStyle labelTextStyle;

  WatchListItemStyle({
    required this.backgroundColor,
    required this.dividerColor,
    required this.primaryColor,
    required this.outOfStockBgColor,
    required this.disableBackgroundColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.subTextStyle,
    required this.listTextStyle,
    required this.labelTextStyle,
  });
}

class ActivityLogStyle {
  final TextStyle storeMessageStyle;
  final TextStyle textFieldStyle;
  final Color borderColor;
  final Color listViewBackgroundColor;
  final TextStyle titleStyle;
  final Color dividerColor;
  final TextStyle subTitleStyle;
  final TextStyle subTextStyle;

  ActivityLogStyle({
    required this.storeMessageStyle,
    required this.textFieldStyle,
    required this.borderColor,
    required this.listViewBackgroundColor,
    required this.titleStyle,
    required this.dividerColor,
    required this.subTitleStyle,
    required this.subTextStyle,
  });
}

class WatchlistDetailsStyle {
  final TextStyle watchlistNameStyle;
  final TextStyle watchlistTitleStyle;
  final TextStyle watchlistSubTitleStyle;
  final Color detailsBackgroundColor;
  final TextStyle noOfProductsStyle;

  WatchlistDetailsStyle({
    required this.watchlistNameStyle,
    required this.watchlistTitleStyle,
    required this.watchlistSubTitleStyle,
    required this.detailsBackgroundColor,
    required this.noOfProductsStyle,
  });
}

class SmartSuggestionProductListStyle {
  final TextStyle titleStyle;
  final TextStyle viewAllStyle;

  SmartSuggestionProductListStyle({
    required this.titleStyle,
    required this.viewAllStyle,
  });
}

class OrionStyle {
  final TextStyle selectionTitleStyle;
  final TextStyle diamondSelectionTitleStyle;
  final TextStyle selectedDiamondSelectionTitleStyle;
  final TextStyle diamondSelectionValueStyle;
  final TextStyle selectedDiamondSelectionValueStyle;
  final Color selectedDiamondSelectionBackgroundColor;
  final Color rangeSliderTrackColor;
  final Color sliderThumbColor;
  final Color sliderThumbBorderColor;
  final TextStyle selectDiamondTitleStyle;
  final TextStyle propertySelectionSubtitleStyle;
  final TextStyle selectedPropertyStyle;
  final TextStyle propertyStyle;

  OrionStyle({
    required this.selectionTitleStyle,
    required this.diamondSelectionTitleStyle,
    required this.selectedDiamondSelectionTitleStyle,
    required this.diamondSelectionValueStyle,
    required this.selectedDiamondSelectionValueStyle,
    required this.selectedDiamondSelectionBackgroundColor,
    required this.rangeSliderTrackColor,
    required this.sliderThumbColor,
    required this.sliderThumbBorderColor,
    required this.selectDiamondTitleStyle,
    required this.propertySelectionSubtitleStyle,
    required this.selectedPropertyStyle,
    required this.propertyStyle,
  });
}

class MessagesStyle {
  final TextStyle userNameStyle;
  final TextStyle timeAgoStyle;
  final TextStyle messagesStyle;
  final Color primaryColor;
  final Color color8C8C8C;
  final TextStyle messageDetailTitleStyle;
  final TextStyle messageDetailToUserNameStyle;
  final TextStyle messageDetailFullMessageStyle;

  MessagesStyle({
    required this.userNameStyle,
    required this.timeAgoStyle,
    required this.messagesStyle,
    required this.primaryColor,
    required this.color8C8C8C,
    required this.messageDetailTitleStyle,
    required this.messageDetailToUserNameStyle,
    required this.messageDetailFullMessageStyle,
  });
}

class TaskDetailsStyle {
  final Color whiteColor;
  final Color headerBgColor;
  final Color activeColor;
  final Color disableColor;
  final TextStyle headerTitleStyle;
  final TextStyle headerSubTitleStyle;
  final TextStyle statusStyle;
  final TextStyle userNameStyle;

  TaskDetailsStyle({
    required this.whiteColor,
    required this.headerBgColor,
    required this.activeColor,
    required this.disableColor,
    required this.headerTitleStyle,
    required this.headerSubTitleStyle,
    required this.statusStyle,
    required this.userNameStyle,
  });
}

class ExhibitionDetailsItemStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color primaryColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle listTextStyle;
  final TextStyle listTitleStyle;
  final TextStyle listSubTitleStyle;
  final TextStyle listStatusStyle;

  ExhibitionDetailsItemStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.primaryColor,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.listTextStyle,
    required this.listTitleStyle,
    required this.listSubTitleStyle,
    required this.listStatusStyle,
  });
}

class ReturnOrderStyle {
  final Color orderInfoBackgroundColor;
  final Color crossColor;
  final Color whiteColor;
  final TextStyle titleStyle;
  final TextStyle orderIdStyle;
  final TextStyle imageSubTitleStyle;
  final TextStyle imageTitleStyle;
  final TextStyle quantityStyle;
  final TextStyle cancelReasonTitleStyle;

  ReturnOrderStyle(
      {required this.orderInfoBackgroundColor,
      required this.crossColor,
      required this.whiteColor,
      required this.titleStyle,
      required this.orderIdStyle,
      required this.imageSubTitleStyle,
      required this.imageTitleStyle,
      required this.quantityStyle,
      required this.cancelReasonTitleStyle});
}

class ConfirmCancelPopupStyle {
  final Color detailBgColor;
  final Color whiteColor;
  final TextStyle headerTitleStyle;
  final TextStyle subTitleStyle;
  final TextStyle itemsTitleStyle;
  final TextStyle qtyTitleStyle;

  ConfirmCancelPopupStyle({
    required this.detailBgColor,
    required this.whiteColor,
    required this.headerTitleStyle,
    required this.subTitleStyle,
    required this.itemsTitleStyle,
    required this.qtyTitleStyle,
  });
}

class CalendarStyle {
  final Color borderColor;
  final Color primary;
  final TextStyle calendarViewChangeButtonStyle;
  final Color cellBorderColor;
  final Color meetEventCellBackgroundColor;
  final Color taskEventCellBackgroundColor;
  final TextStyle meetEventTextStyle;
  final TextStyle currentMonthHeaderStyle;
  final Color dropDownArrowColor;
  final TextStyle viewAllStyle;

  CalendarStyle({
    required this.borderColor,
    required this.primary,
    required this.calendarViewChangeButtonStyle,
    required this.cellBorderColor,
    required this.meetEventCellBackgroundColor,
    required this.taskEventCellBackgroundColor,
    required this.meetEventTextStyle,
    required this.currentMonthHeaderStyle,
    required this.dropDownArrowColor,
    required this.viewAllStyle,
  });
}

class NewsletterScreenStyle {
  final TextStyle labelStyle;

  NewsletterScreenStyle({required this.labelStyle});
}
