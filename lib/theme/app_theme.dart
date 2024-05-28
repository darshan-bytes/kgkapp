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

  WishListStyle get wishListStyle;

  AddAccountScreenStyle get addAccountScreenStyle;

  CountryPickerStyle get countryPickerStyle;

  MyBagScreenStyle get myBagScreenStyle;
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
  });
}

class SmartDropDownStyle {
  final Color borderColor;
  final Color backgroundColor;
  final Color selectedBorderColor;
  final Color unSelectedBorderColor;
  final TextStyle titleTextStyle;
  final TextStyle labelStyle;

  SmartDropDownStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.selectedBorderColor,
    required this.unSelectedBorderColor,
    required this.titleTextStyle,
    required this.labelStyle,
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

class WishListStyle {
  final TextStyle numberOfItemsStyle;
  final TextStyle totalAmountStyle;

  WishListStyle({
    required this.numberOfItemsStyle,
    required this.totalAmountStyle,
  });
}

class AddAccountScreenStyle {
  final Color backgroundColor;
  final Color dotColor;
  final Color filledDotColor;
  final Color fillLineColor;
  final Color borderColor;
  final TextStyle shippingBillingAddressStyle;
  final TextStyle paymentStyle;
  final TextStyle isSameAddressStyle;

  AddAccountScreenStyle({
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

class MyBagScreenStyle {
  final Color backgroundColor;
  final TextStyle productsTitleStyle;
  final TextStyle itemSelectedStyle;
  final TextStyle totalAmountStyle;

  MyBagScreenStyle({
    required this.backgroundColor,
    required this.productsTitleStyle,
    required this.itemSelectedStyle,
    required this.totalAmountStyle,
  });
}
