import 'package:kgk/kgk.dart';

//AppStyle
abstract class AppTheme {
  static AppTheme of(BuildContext context) {
    return LightModeTheme(Theme.of(context).colors);
  }

  AppColor get colors;

  TextStyle get detailTextStyle;

  TextStyle get mediumTitleTextStyle;

  TextStyle get primarySemiTitle;

  TextStyle get boldTitleTextStyle;

  SignInStyle get signInStyle;

  PrimaryButtonStyle get primaryButtonStyle;

  TextFieldStyle get textFieldStyle;

  SmartRichTextStyle get smartRichTextStyle;

  SignUpStyle get signUpStyle;

  CheckboxStyle get checkboxStyle;

  CardDeliveryStyle get cardDeliveryStyle;

  CustomAppBarStyle get appBarStyle;

  ProductStyle get productStyle;

  BottomNavigationBarStyle get bottomNavigationBarStyle;

  CommonAppStyle get commonAppStyle;

  StoreInfoStyle get storeInfoStyle;

  SearchScreenStyle get searchScreenStyle;

  SelectStoreSheetStyle get selectStoreSheetStyle;

  CustomCarouselSliderStyle get customCarouselSliderStyle;

  HomeScreenStyle get homeScreenStyle;

  ShopByStyle get shopByStyle;

  ExploreTheBestBrandsStyle get exploreTheBestBrandsStyle;

  MeetYourHealthNeedStyle get meetYourHealthNeedStyle;

  DealsForYouStyle get dealsForYouStyle;

  CustomDropDownStyle get customDropDownStyle;

  MyStoreLocationStyle get myStoreLocationStyle;

  ProfileStyle get profileStyle;

  FilterStyle get filterStyle;

  DashboardStyle get dashboardStyle;

  AccountInformationScreenStyle get accountInformationScreenStyle;

  ChangePassword get changePassword;

  StoreCreditStyle get storeCreditStyle;

  MyOrderStyle get myOrderStyle;

  GiftCardStyle get giftCardStyle;

  HealthyPointStyle get healthyPointStyle;

  AddressDetailsStyle get addressDetailsStyle;

  MyWishListStyle get myWishListStyle;

  BuyLaterStyle get buyLaterStyle;

  MyProductReviewsStyle get myProductReviewsStyle;

  OnlineAndInStoreRewardPointsStyle get onlineAndInStoreRewardPointsStyle;

  InStoreTransactionFilterStyle get inStoreTransactionFilterStyle;

  MyCouponsStyle get myCouponsStyle;

  MyCartStyle get myCartStyle;

  OrderDetailsStyle get orderDetailsStyle;

  ProductDetailsScreenStyle get productDetailsScreenStyle;

  CustomProgressBarStyle get customProgressBarStyle;

  ReviewScreenStyle get reviewScreenStyle;

  CartProductItemStyle get cartProductItemStyle;

  SuccessShoppingCardStyle get successShoppingCardStyle;

  LocationDetailStyle get locationDetailStyle;

  BrandListStyle get brandListStyle;

  LocationListingStyle get locationListingStyle;

  UnderMaintenanceStyle get underMaintenanceStyle;

  CheckoutStyle get checkoutStyle;

  AddressCheckoutStyle get addressCheckoutStyle;

  CheckoutAddressSheetStyle get checkoutAddressSheetStyle;

  CreditCardStyle get creditCardStyle;
}

class SignInStyle {
  final Color buttonBackground;
  final TextStyle titleText;
  final TextStyle skipStyle;
  final TextStyle signinDetail;
  final TextStyle highlightTextStyle;

  SignInStyle(
      {required this.buttonBackground,
      required this.titleText,
      required this.skipStyle,
      required this.signinDetail,
      required this.highlightTextStyle});
}

class SignUpStyle {
  final TextStyle informativeText;

  SignUpStyle({
    required this.informativeText,
  });
}

class PrimaryButtonStyle {
  final Color activeBackgroundColor;
  final Color disableBackgroundColor;
  final Color whiteColor;
  final Color blackColor;
  final TextStyle titleStyle;

  PrimaryButtonStyle(
      {required this.activeBackgroundColor,
      required this.disableBackgroundColor,
      required this.blackColor,
      required this.titleStyle,
      required this.whiteColor});
}

class TextFieldStyle {
  final Color textFillColor;
  final Color blackColor;
  final Color iconColor;
  final Color disabledTextFieldBorderColor;
  final TextStyle inputTextStyle;
  final TextStyle hintStyle;
  final TextStyle labelStyle;
  final TextStyle errorStyle;
  final TextStyle textStyle;

  TextFieldStyle({
    required this.hintStyle,
    required this.iconColor,
    required this.blackColor,
    required this.inputTextStyle,
    required this.labelStyle,
    required this.textFillColor,
    required this.errorStyle,
    required this.textStyle,
    required this.disabledTextFieldBorderColor,
  });
}

class SmartRichTextStyle {
  final TextStyle textStyle;
  final TextStyle subTextStyle;

  SmartRichTextStyle({required this.subTextStyle, required this.textStyle});
}

class CheckboxStyle {
  final Color activeColor;
  final Color checkColor;
  final Color borderColor;
  final TextStyle textStyle;

  CheckboxStyle({required this.activeColor, required this.checkColor, required this.borderColor, required this.textStyle});
}

class CardDeliveryStyle {
  final TextStyle titleStyle;
  final TextStyle methodTitleStyle;

  CardDeliveryStyle({required this.titleStyle, required this.methodTitleStyle});
}

class StoreInfoStyle {
  final TextStyle headingStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color tileColor;
  final TextStyle workTimeStyle;
  final TextStyle seeAllStyle;
  final TextStyle outOfStockStyle;

  StoreInfoStyle({
    required this.headingStyle,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.tileColor,
    required this.workTimeStyle,
    required this.seeAllStyle,
    required this.outOfStockStyle,
  });
}

class SearchScreenStyle {
  final TextStyle hintStyle;
  final TextStyle searchesStyle;
  final TextStyle trendingStyle;
  final Color trendingProductsBorderColor;
  final TextStyle trendingProductsStyle;
  final Color enabledBorderColor;
  final Color dividerColor;
  final TextStyle titleStyle;
  final TextStyle sortTitle;
  final TextStyle sortSelectedTitle;

  SearchScreenStyle(
      {required this.hintStyle,
      required this.enabledBorderColor,
      required this.searchesStyle,
      required this.trendingStyle,
      required this.trendingProductsBorderColor,
      required this.trendingProductsStyle,
      required this.dividerColor,
      required this.titleStyle,
      required this.sortTitle,
      required this.sortSelectedTitle});
}

class CustomAppBarStyle {
  final Color whiteColor;
  final BoxShadow appBarShadow;
  final TextStyle titleStyle;
  final TextStyle skipTextStyle;
  final TextStyle titleTextStyle;

  CustomAppBarStyle({
    required this.whiteColor,
    required this.appBarShadow,
    required this.titleStyle,
    required this.skipTextStyle,
    required this.titleTextStyle,
  });
}

class ProductStyle {
  final Color backgroundColor;
  final Color ratingBackgroundColor;
  final TextStyle productNameStyle;
  final TextStyle ratingStyle;
  final TextStyle priceTextStyle;
  final TextStyle outOfStockTextStyle;
  final TextStyle offerTextStyle;
  final TextStyle lableStyle;

  ProductStyle(
      {required this.backgroundColor,
      required this.ratingBackgroundColor,
      required this.productNameStyle,
      required this.ratingStyle,
      required this.priceTextStyle,
      required this.outOfStockTextStyle,
      required this.offerTextStyle,
      required this.lableStyle});
}

class BottomNavigationBarStyle {
  final Color whiteColor;
  final Color transparent;
  final Color fabBackgroundColor;
  final TextStyle navBarTextStyle;
  final Color navBarSelectedColor;
  final Color navBarUnSelectedColor;
  final Color navBarSelectedIconColor;

  BottomNavigationBarStyle({
    required this.whiteColor,
    this.transparent = Colors.transparent,
    required this.fabBackgroundColor,
    required this.navBarTextStyle,
    required this.navBarUnSelectedColor,
    required this.navBarSelectedColor,
    required this.navBarSelectedIconColor,
  });
}

class CommonAppStyle {
  final TextStyle snackBatTextStyle;

  CommonAppStyle({
    required this.snackBatTextStyle,
  });
}

class SelectStoreSheetStyle {
  final TextStyle textStyle;
  final Color whiteColor;
  final Color selectedBorderColor;
  final Color borderColor;

  SelectStoreSheetStyle({required this.textStyle, required this.whiteColor, required this.borderColor, required this.selectedBorderColor});
}

class CustomCarouselSliderStyle {
  final Color selectedSliderIndexColor;
  final Color deselectedSliderIndexColor;

  CustomCarouselSliderStyle({required this.selectedSliderIndexColor, required this.deselectedSliderIndexColor});
}

class HomeScreenStyle {
  final Color whiteColor;
  final TextStyle headingTitleStyle;
  final Color favIconColor;
  final Color shadowColor;
  final Color borderColor;
  final TextStyle seeAllTextStyle;
  final TextStyle imageTitleTextStyle;
  final TextStyle subTitleStyle;
  final TextStyle cartCountStyle;

  HomeScreenStyle({
    required this.whiteColor,
    required this.headingTitleStyle,
    required this.favIconColor,
    required this.shadowColor,
    required this.borderColor,
    required this.seeAllTextStyle,
    required this.imageTitleTextStyle,
    required this.subTitleStyle,
    required this.cartCountStyle,
  });
}

class ShopByStyle {
  final TextStyle titleStyle;
  final TextStyle itemNameStyle;
  final TextStyle subCategoryStyle;
  final Color backgroundColor;
  final Color dividerColor;
  final Color borderColor;
  final TextStyle highlitedTitle;
  final TextStyle subCategoryTitle;

  ShopByStyle({
    required this.titleStyle,
    required this.itemNameStyle,
    required this.subCategoryStyle,
    required this.backgroundColor,
    required this.dividerColor,
    required this.borderColor,
    required this.highlitedTitle,
    required this.subCategoryTitle,
  });
}

class ExploreTheBestBrandsStyle {
  final Color whiteColor;
  final BoxShadow boxShadow;
  final TextStyle titleTextStyle;
  final TextStyle skipTextStyle;

  ExploreTheBestBrandsStyle({
    required this.whiteColor,
    required this.boxShadow,
    required this.titleTextStyle,
    required this.skipTextStyle,
  });
}

class MeetYourHealthNeedStyle {
  final Color whiteColor;
  final TextStyle titleTextStyle;
  final TextStyle productNameTextStyle;

  MeetYourHealthNeedStyle({
    required this.whiteColor,
    required this.titleTextStyle,
    required this.productNameTextStyle,
  });
}

class DealsForYouStyle {
  final Color borderColor;
  final Color textBGColor;
  final Color imageBGColor;
  final TextStyle offerTextStyle;

  DealsForYouStyle({
    required this.borderColor,
    required this.textBGColor,
    required this.offerTextStyle,
    required this.imageBGColor,
  });
}

class CustomDropDownStyle {
  final Color whiteColor;
  final Color selectedBackgroundColor;
  final Color borderColor;
  final TextStyle titleTextStyle;

  CustomDropDownStyle({
    required this.whiteColor,
    required this.selectedBackgroundColor,
    required this.borderColor,
    required this.titleTextStyle,
  });
}

class MyStoreLocationStyle {
  final Color backgroundColor;
  final TextStyle myStoreTextStyle;
  final TextStyle subTitleStyle;
  final TextStyle chooseStoreStyle;
  final TextStyle timeStempStyle;

  MyStoreLocationStyle({
    required this.backgroundColor,
    required this.myStoreTextStyle,
    required this.subTitleStyle,
    required this.chooseStoreStyle,
    required this.timeStempStyle,
  });
}

class ProfileStyle {
  final Color whiteColor;
  final TextStyle goodMorningTextStyle;
  final TextStyle nameTextStyle;
  final TextStyle pointTextStyle;
  final TextStyle rewardPointAmountStyle;
  final TextStyle rewardPointStyle;
  final TextStyle healthyPointStyle;
  final TextStyle storeCreditStyle;
  final TextStyle titleTextStyle;
  final Color userNameColor;

  ProfileStyle({
    required this.whiteColor,
    required this.goodMorningTextStyle,
    required this.nameTextStyle,
    required this.pointTextStyle,
    required this.rewardPointAmountStyle,
    required this.rewardPointStyle,
    required this.healthyPointStyle,
    required this.storeCreditStyle,
    required this.titleTextStyle,
    required this.userNameColor,
  });
}

class FilterStyle {
  final Color whiteColor;
  final Color backgroundColor;
  final Color selectedFilterTrailColor;
  final TextStyle filterTextStyle;
  final TextStyle subFilterTextStyle;
  final Color selectedFilterBGColor;
  final Color borderColor;
  final TextStyle sortByTextStyle;
  final TextStyle sortByTextSelectedStyle;

  FilterStyle(
      {required this.whiteColor,
      required this.backgroundColor,
      required this.filterTextStyle,
      required this.selectedFilterTrailColor,
      required this.subFilterTextStyle,
      required this.selectedFilterBGColor,
      required this.borderColor,
      required this.sortByTextStyle,
      required this.sortByTextSelectedStyle});
}

class DashboardStyle {
  final Color backgroundColor;
  final Color actionCardBackgroundColor;
  final Color healthyPointBackgroundColor;
  final Color storeCreditBackgroundColor;
  final Color couponsBackgroundColor;
  final Color giftCardBackgroundColor;
  final TextStyle greetingTextStyle;
  final TextStyle welcomeUserNameStyle;
  final TextStyle actionButtonValueStyle;
  final TextStyle actionButtonTitleStyle;
  final Color orderAndReturnBackgroundColor;
  final Color orderAndReturnLeadingBGColor;
  final Color wishListBackgroundColor;
  final Color wishListLeadingBGColor;
  final TextStyle secondaryActionTitleStyle;
  final TextStyle secondaryActionSubTitleStyle;
  final TextStyle informationTitleStyle;
  final TextStyle informationDetailsStyle;

  DashboardStyle({
    required this.backgroundColor,
    required this.actionCardBackgroundColor,
    required this.healthyPointBackgroundColor,
    required this.storeCreditBackgroundColor,
    required this.couponsBackgroundColor,
    required this.giftCardBackgroundColor,
    required this.greetingTextStyle,
    required this.welcomeUserNameStyle,
    required this.actionButtonValueStyle,
    required this.actionButtonTitleStyle,
    required this.orderAndReturnBackgroundColor,
    required this.orderAndReturnLeadingBGColor,
    required this.wishListBackgroundColor,
    required this.wishListLeadingBGColor,
    required this.secondaryActionTitleStyle,
    required this.secondaryActionSubTitleStyle,
    required this.informationTitleStyle,
    required this.informationDetailsStyle,
  });
}

class AccountInformationScreenStyle {
  final Color backgroundColor;
  final TextStyle formHeaderStyle;
  final TextStyle changeEmailStyle;
  final TextStyle addressTitleStyle;
  final TextStyle addAddressTitleStyle;
  final TextStyle defaultAddressTitleStyle;
  final TextStyle defaultAddressStyle;
  final TextStyle defaultAddressContactNoTextStyle;
  final TextStyle defaultAddressContactNoValueStyle;
  final TextStyle changeAddressTextStyle;
  final TextStyle additionalAddressTitleTextStyle;
  final TextStyle addressDetailsTitleTextStyle;
  final TextStyle addressDetailsValueTextStyle;
  final BoxShadow addressDetailsBoxShadow;
  final Color disabledTextFieldFillColor;
  final Color disabledTextFieldBorderColor;

  AccountInformationScreenStyle({
    required this.backgroundColor,
    required this.formHeaderStyle,
    required this.changeEmailStyle,
    required this.addressTitleStyle,
    required this.addAddressTitleStyle,
    required this.defaultAddressTitleStyle,
    required this.defaultAddressStyle,
    required this.defaultAddressContactNoTextStyle,
    required this.defaultAddressContactNoValueStyle,
    required this.changeAddressTextStyle,
    required this.additionalAddressTitleTextStyle,
    required this.addressDetailsTitleTextStyle,
    required this.addressDetailsValueTextStyle,
    required this.addressDetailsBoxShadow,
    required this.disabledTextFieldFillColor,
    required this.disabledTextFieldBorderColor,
  });
}

class ChangePassword {
  final Color backgroundColor;
  final Color dividerColor;

  ChangePassword({
    required this.backgroundColor,
    required this.dividerColor,
  });
}

class StoreCreditStyle {
  final Color backgroundColor;
  final Color bottomNavBarColor;
  final Color bottomNavBarButtonColor;
  final BoxShadow boxShadow;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle bottomBarTextStyle;

  StoreCreditStyle({
    required this.backgroundColor,
    required this.boxShadow,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.bottomNavBarColor,
    required this.bottomNavBarButtonColor,
    required this.bottomBarTextStyle,
  });
}

class MyOrderStyle {
  final Color backgroundColor;
  final BoxShadow boxShadow;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  MyOrderStyle({
    required this.backgroundColor,
    required this.boxShadow,
    required this.titleStyle,
    required this.subTitleStyle,
  });
}

class GiftCardStyle {
  final Color backgroundColor;
  final BoxShadow boxShadow;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle addGiftCardButtonStyle;
  final Color addGiftCardButtonColor;

  GiftCardStyle({
    required this.backgroundColor,
    required this.boxShadow,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.addGiftCardButtonStyle,
    required this.addGiftCardButtonColor,
  });
}

class HealthyPointStyle {
  final Color backgroundColor;
  final Color warningBackgroundColor;
  final TextStyle warningTextStyle;
  final Color healthyPointBackgroundColor;
  final Color onlineRewardPointBackgroundColor;
  final Color downloadTransactionReportBackgroundColor;
  final Color missingPointsBackgroundColor;
  final TextStyle actionButtonValueStyle;
  final TextStyle actionButtonTitleStyle;
  final TextStyle emailNotificationSettingsTitleStyle;
  final TextStyle subscriptionCheckboxTitleStyle;
  final TextStyle saveSubscriptionSettingTitleStyle;
  final Color dividerColor;

  HealthyPointStyle({
    required this.backgroundColor,
    required this.warningBackgroundColor,
    required this.warningTextStyle,
    required this.healthyPointBackgroundColor,
    required this.onlineRewardPointBackgroundColor,
    required this.downloadTransactionReportBackgroundColor,
    required this.missingPointsBackgroundColor,
    required this.actionButtonValueStyle,
    required this.actionButtonTitleStyle,
    required this.emailNotificationSettingsTitleStyle,
    required this.subscriptionCheckboxTitleStyle,
    required this.saveSubscriptionSettingTitleStyle,
    required this.dividerColor,
  });
}

class AddressDetailsStyle {
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final TextStyle checkBoxTitleStyle;

  AddressDetailsStyle({
    required this.backgroundColor,
    required this.titleTextStyle,
    required this.checkBoxTitleStyle,
  });
}

class MyWishListStyle {
  final Color backgroundColor;
  final Color shareWishListButtonColor;
  final Color shareWishListBorderColor;
  final TextStyle shareWishListTextStyle;
  final TextStyle titleTextStyle;

  MyWishListStyle({
    required this.backgroundColor,
    required this.shareWishListButtonColor,
    required this.shareWishListBorderColor,
    required this.shareWishListTextStyle,
    required this.titleTextStyle,
  });
}

class BuyLaterStyle {
  final Color backgroundColor;
  final BoxShadow boxShadow;
  final TextStyle productNameStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;

  BuyLaterStyle({
    required this.backgroundColor,
    required this.boxShadow,
    required this.productNameStyle,
    required this.titleStyle,
    required this.subTitleStyle,
  });
}

class MyProductReviewsStyle {
  final Color backgroundColor;
  final BoxShadow boxShadow;
  final TextStyle productNameStyle;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color fillRatingColor;
  final Color emptyRatingColor;

  MyProductReviewsStyle({
    required this.backgroundColor,
    required this.boxShadow,
    required this.productNameStyle,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.fillRatingColor,
    required this.emptyRatingColor,
  });
}

class OnlineAndInStoreRewardPointsStyle {
  final Color backgroundColor;
  final TextStyle tabBarTitleStyle;
  final TextStyle tabBarUnselectedTitleStyle;
  final Color tabIndicatorColor;
  final BoxShadow boxShadow;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle actionButtonValueStyle;
  final TextStyle actionButtonTitleStyle;
  final TextStyle filterTextStyle;
  final TextStyle appliedFilterTextStyle;

  OnlineAndInStoreRewardPointsStyle({
    required this.backgroundColor,
    required this.tabBarTitleStyle,
    required this.tabBarUnselectedTitleStyle,
    required this.tabIndicatorColor,
    required this.boxShadow,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.actionButtonValueStyle,
    required this.actionButtonTitleStyle,
    required this.filterTextStyle,
    required this.appliedFilterTextStyle,
  });
}

class InStoreTransactionFilterStyle {
  final Color backgroundColor;
  final Color dividerColor;
  final TextStyle titleTextStyle;

  InStoreTransactionFilterStyle({
    required this.backgroundColor,
    required this.dividerColor,
    required this.titleTextStyle,
  });
}

class MyCouponsStyle {
  final Color backgroundColor;
  final TextStyle tabBarTitleStyle;
  final TextStyle tabBarUnselectedTitleStyle;
  final Color tabIndicatorColor;
  final BoxShadow boxShadow;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle couponCodeTitleStyle;

  MyCouponsStyle({
    required this.backgroundColor,
    required this.tabBarTitleStyle,
    required this.tabBarUnselectedTitleStyle,
    required this.tabIndicatorColor,
    required this.boxShadow,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.couponCodeTitleStyle,
  });
}

class MyCartStyle {
  final Color backgroundColor;
  final Color emptyCartBackgroundColor;
  final Color scaffoldBackgroundColor;
  final Color headerTitleBackgroundColor;
  final Color whiteColor;
  final TextStyle headingTitleTextStyle;
  final TextStyle emptyCartTitleStyle;
  final TextStyle emptyCartSubTitleStyle;
  final TextStyle discountTitleStyle;
  final TextStyle useGiftCartStyle;
  final TextStyle removeTextStyle;
  final TextStyle orderSummaryTitleStyle;
  final TextStyle orderSummarySubTitleStyle;
  final TextStyle outOfStockTextStyle;
  final Color outOfStockMessageBackgroundColor;
  final Color dividerColor;
  final TextStyle clickHereToApplyStyle;
  final TextStyle grandTotalStyle;

  MyCartStyle(
      {required this.backgroundColor,
      required this.emptyCartBackgroundColor,
      required this.scaffoldBackgroundColor,
      required this.whiteColor,
      required this.emptyCartTitleStyle,
      required this.emptyCartSubTitleStyle,
      required this.headerTitleBackgroundColor,
      required this.headingTitleTextStyle,
      required this.discountTitleStyle,
      required this.removeTextStyle,
      required this.useGiftCartStyle,
      required this.orderSummarySubTitleStyle,
      required this.orderSummaryTitleStyle,
      required this.outOfStockTextStyle,
      required this.outOfStockMessageBackgroundColor,
      required this.dividerColor,
      required this.clickHereToApplyStyle,
      required this.grandTotalStyle});
}

class OrderDetailsStyle {
  final Color backgroundColor;
  final TextStyle basicTitleStyle;
  final TextStyle basicSubTitleStyle;
  final TextStyle actionTextStyle;
  final TextStyle productItemsTitleStyle;
  final TextStyle productNamesStyle;
  final TextStyle productTitleStyle;
  final TextStyle productSubTitleStyle;
  final BoxShadow boxShadow;
  final Color productBorderColor;
  final Color amountContainerColor;
  final TextStyle amountTextStyle;
  final TextStyle totalAmountTextStyle;
  final Color dividerColor;
  final TextStyle addressTitleStyle;

  OrderDetailsStyle({
    required this.backgroundColor,
    required this.basicTitleStyle,
    required this.basicSubTitleStyle,
    required this.actionTextStyle,
    required this.productItemsTitleStyle,
    required this.productNamesStyle,
    required this.productTitleStyle,
    required this.productSubTitleStyle,
    required this.boxShadow,
    required this.productBorderColor,
    required this.amountContainerColor,
    required this.amountTextStyle,
    required this.totalAmountTextStyle,
    required this.dividerColor,
    required this.addressTitleStyle,
  });
}

class ProductDetailsScreenStyle {
  final Color backgroundColor;
  final TextStyle productNameStyle;
  final TextStyle productRatingStyle;
  final TextStyle byTextStyle;
  final TextStyle sellerTextStyle;
  final TextStyle skuTextStyle;
  final Color productTagBackGroundColor;
  final TextStyle productTagStyle;
  final Color unselectedDotColor;
  final Color selectedDotColor;
  final TextStyle priceTextStyle;
  final TextStyle offerTextStyle;
  final TextStyle otherPaymentMethodStyle;
  final TextStyle otherDetailsTextStyle;
  final Color dividerColor;
  final TextStyle expansionTitleStyle;
  final TextStyle titleTextStyle;
  final TextStyle writeAReviewTitleStyle;
  final Color ratingBackGroundColor;
  final TextStyle averageRatingTextStyle;
  final TextStyle ratingTextStyle;
  final TextStyle reviewCountTextStyle;
  final TextStyle alertTextStyle;
  final Color bottomBarColor;
  final TextStyle productDetailsTitleStyle;
  final TextStyle bottomBarPriceTextStyle;
  final TextStyle bottomBarOfferTextStyle;
  final Color addToCartButtonColor;
  final BoxShadow boxShadow;
  final TextStyle subTitleStyle;
  final Color selectedGiftCardColor;
  final Color lastOrderBorderColor;
  final TextStyle viewOrderTextStyle;

  ProductDetailsScreenStyle({
    required this.backgroundColor,
    required this.productNameStyle,
    required this.productRatingStyle,
    required this.byTextStyle,
    required this.sellerTextStyle,
    required this.skuTextStyle,
    required this.productTagBackGroundColor,
    required this.productTagStyle,
    required this.unselectedDotColor,
    required this.selectedDotColor,
    required this.priceTextStyle,
    required this.offerTextStyle,
    required this.otherPaymentMethodStyle,
    required this.otherDetailsTextStyle,
    required this.dividerColor,
    required this.expansionTitleStyle,
    required this.titleTextStyle,
    required this.writeAReviewTitleStyle,
    required this.ratingBackGroundColor,
    required this.averageRatingTextStyle,
    required this.ratingTextStyle,
    required this.reviewCountTextStyle,
    required this.alertTextStyle,
    required this.bottomBarColor,
    required this.productDetailsTitleStyle,
    required this.bottomBarPriceTextStyle,
    required this.bottomBarOfferTextStyle,
    required this.addToCartButtonColor,
    required this.boxShadow,
    required this.subTitleStyle,
    required this.selectedGiftCardColor,
    required this.lastOrderBorderColor,
    required this.viewOrderTextStyle,
  });
}

class CustomProgressBarStyle {
  final Color backgroundColor;
  final Color primaryColor;
  final Color progressbarBGColor;

  CustomProgressBarStyle({
    required this.backgroundColor,
    required this.primaryColor,
    required this.progressbarBGColor,
  });
}

class ReviewScreenStyle {
  final Color backgroundColor;
  final Color dividerColor;

  ReviewScreenStyle({
    required this.backgroundColor,
    required this.dividerColor,
  });
}

class CartProductItemStyle {
  final Color itemOutOfStockTextColor;
  final TextStyle itemOutOfStockTextStyle;
  final TextStyle productTitleStyle;
  final TextStyle productSubTitleStyle;
  final TextStyle checkedPriceSubTitleStyle;
  final TextStyle removeTextStyle;
  final Color borderColor;
  final TextStyle giftCardLabelStyle;

  CartProductItemStyle({
    required this.itemOutOfStockTextColor,
    required this.itemOutOfStockTextStyle,
    required this.productTitleStyle,
    required this.productSubTitleStyle,
    required this.removeTextStyle,
    required this.checkedPriceSubTitleStyle,
    required this.borderColor,
    required this.giftCardLabelStyle,
  });
}

class SuccessShoppingCardStyle {
  final Color isCorrectColor;
  final TextStyle thanksTextStyle;
  final TextStyle orderStyle;
  final Color orderNumberColor;
  final TextStyle subTitleStyle;
  final TextStyle createAccountTitleStyle;
  final TextStyle buttonTextStyle;
  final Color buttonBackgroundColor;
  final Color dividerColor;
  final Color transparentColor;
  final Color blackColor;

  SuccessShoppingCardStyle(
      {required this.transparentColor,
      required this.blackColor,
      required this.thanksTextStyle,
      required this.orderStyle,
      required this.orderNumberColor,
      required this.subTitleStyle,
      required this.createAccountTitleStyle,
      required this.buttonTextStyle,
      required this.buttonBackgroundColor,
      required this.isCorrectColor,
      required this.dividerColor});
}

class LocationDetailStyle {
  final Color backgroundColor;
  final Color dashBoardBackgroundColor;
  final TextStyle dashboardTitleStyle;
  final TextStyle locationLableStyle;
  final Color getDirectionBackgroundColor;
  final TextStyle getDirectionStyle;
  final TextStyle ratingTitle;
  final TextStyle viewAllTextStyle;

  LocationDetailStyle(
      {required this.dashBoardBackgroundColor,
      required this.dashboardTitleStyle,
      required this.locationLableStyle,
      required this.getDirectionBackgroundColor,
      required this.getDirectionStyle,
      required this.backgroundColor,
      required this.ratingTitle,
      required this.viewAllTextStyle});
}

class BrandListStyle {
  final TextStyle letterTextStyle;
  final TextStyle lableTextStyle;

  BrandListStyle({required this.lableTextStyle, required this.letterTextStyle});
}

class LocationListingStyle {
  final Color backgroundColor;
  final Color white;
  final Color activeTrackColor;
  final TextStyle filterStyle;
  final TextStyle appliedStyle;
  final TextStyle cardHeadingStyle;
  final TextStyle cardTitleStyle;
  final TextStyle cardSubTitleStyle;
  final TextStyle infoWindowText;
  final TextStyle infoWindowHours;

  LocationListingStyle(
      {required this.white,
      required this.filterStyle,
      required this.appliedStyle,
      required this.cardHeadingStyle,
      required this.cardTitleStyle,
      required this.cardSubTitleStyle,
      required this.backgroundColor,
      required this.activeTrackColor,
      required this.infoWindowText,
      required this.infoWindowHours});
}

class UnderMaintenanceStyle {
  final TextStyle headingTextStyle;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  UnderMaintenanceStyle({required this.headingTextStyle, required this.subTitleTextStyle, required this.titleTextStyle});
}

class CheckoutStyle {
  final Color backgroundColor;
  final TextStyle titleTextStyle;
  final TextStyle unSelectedTitleTextStyle;
  final TextStyle changeAddressStyle;
  final TextStyle saveLateUseCheckboxTitleStyle;
  final TextStyle subTitleStyle;
  final TextStyle alertTextStyle;

  CheckoutStyle({
    required this.backgroundColor,
    required this.titleTextStyle,
    required this.unSelectedTitleTextStyle,
    required this.changeAddressStyle,
    required this.saveLateUseCheckboxTitleStyle,
    required this.subTitleStyle,
    required this.alertTextStyle,
  });
}

class AddressCheckoutStyle {
  final Color borderColor;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final TextStyle defaultAddressStyle;

  AddressCheckoutStyle(
      {required this.borderColor, required this.titleStyle, required this.subTitleStyle, required this.defaultAddressStyle});
}

class CheckoutAddressSheetStyle {
  final Color dividerColor;
  final Color backgroundColor;
  final TextStyle addNewAddressStyle;

  CheckoutAddressSheetStyle({
    required this.dividerColor,
    required this.backgroundColor,
    required this.addNewAddressStyle,
  });
}

class CreditCardStyle {
  final Color borderColor;
  final Color selectedBorderColor;
  final TextStyle cardNumberStyle;
  final TextStyle cardNameStyle;
  final TextStyle titleStyle;

  CreditCardStyle({
    required this.borderColor,
    required this.selectedBorderColor,
    required this.cardNumberStyle,
    required this.cardNameStyle,
    required this.titleStyle,
  });
}
