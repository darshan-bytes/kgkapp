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

  OrderScreenStyle get orderScreenStyle;

  SmartTabBarStyle get smartTabBarStyle;

  StatusBadgeStyle get statusBadgeStyle;

  OrderPopupStyle get orderPopupStyle;
}

class PrimaryButtonStyle {
  final Color activeBackgroundColor;
  final Color disableBackgroundColor;
  final TextStyle titleStyle;
  final TextStyle disableTitleStyle;
  final Color activeImageColor;
  final Color disableImageColor;

  PrimaryButtonStyle({
    required this.activeBackgroundColor,
    required this.disableBackgroundColor,
    required this.titleStyle,
    required this.disableTitleStyle,
    required this.activeImageColor,
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

  CustomAppBarStyle({
    required this.backgroundColor,
    required this.titleStyle,
    required this.borderColor,
    required this.transparentColor,
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
  });
}

class ReviewDetailsStyle {
  final TextStyle userNameStyle;
  final Color dotColor;
  final TextStyle createdDateStyle;
  final TextStyle titleStyle;

  ReviewDetailsStyle({
    required this.userNameStyle,
    required this.dotColor,
    required this.createdDateStyle,
    required this.titleStyle,
  });
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

  AddressSelectionStyle({
    required this.addressNameStyle,
    required this.fullAddressStyle,
    required this.contactNumberStyle,
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

class OrderScreenStyle {
  OrderScreenStyle();
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
  final Color inProgressBackgroundColor;
  final Color inProgressTextColor;
  final Color activeBackgroundColor;
  final Color activeTextColor;
  final TextStyle statusTextStyle;

  StatusBadgeStyle({
    required this.inProgressBackgroundColor,
    required this.inProgressTextColor,
    required this.activeBackgroundColor,
    required this.activeTextColor,
    required this.statusTextStyle,
  });
}

class OrderPopupStyle {
  final TextStyle optionTextStyle;
  final TextStyle cancelTextStyle;

  OrderPopupStyle({
    required this.optionTextStyle,
    required this.cancelTextStyle,
  });
}