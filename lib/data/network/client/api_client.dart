import 'package:kgk/kgk.dart';

/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static String devApiBase = 'https://api.kgk.magnetoinfotech.com/v1';
  static String qaApiBase = 'https://qa-api.kgk.magnetoinfotech.com/v1';
  static String martinApiBase = 'https://api.martinflyer.com/v1';

  static String get apiBaseUrl {
    String companyTheme = StorageManager.instance.getCompanyTheme();
    switch (companyTheme) {
      case 'martin':
        return martinApiBase;
      case 'kgk':
        return qaApiBase;
      default:
        return devApiBase;
    }
  }

  static String assetsBaseUrl = '$apiBaseUrl/assets/';

  static String loginUser = '$apiBaseUrl/auth/front-sign-in';
  static String verifyQrCodeForAuth = '$apiBaseUrl/auth/verify-qr-scanner';
  static String checkDuplicationEmail = '$apiBaseUrl/users/check-email-duplication';

  static String checkDuplicationPhoneNumber(String code, String phoneNumber) =>
      '$apiBaseUrl/users/phone-code/$code/phone/$phoneNumber/lookup';

  //orionDetails
  static String orionDetails(String discountPrice, String caratWeight) =>
      '$apiBaseUrl/commodity/diamond/orion/detail?discount_price=$discountPrice&carat_weight=$caratWeight';

  static String businessTypes = '$apiBaseUrl/business-types';
  static String officeLocations = '$apiBaseUrl/subarea-masters';
  static String signUpCustomer = '$apiBaseUrl/customer/signup';

  static String forgotPassword = '$apiBaseUrl/auth/forgot-password';
  static String currencies = '$apiBaseUrl/currency';
  static String languageLabels = '$apiBaseUrl/language/labels';
  static String frontendLinks = '$apiBaseUrl/strapi-pages/frontend/link';

  static String diamondListing = '$apiBaseUrl/commodity/diamond/filters';
  static String gemstoneListing = '$apiBaseUrl/commodity/color-stone/filters';
  static String jewelleryListing = '$apiBaseUrl/jewelleries/filters';
  static String wishlist = '$apiBaseUrl/wishlist/filters';
  static String bagListData = '$apiBaseUrl/bag/list';
  static String auctionListing = '$apiBaseUrl/auctions/customer/filter';
  static String createBid = '$apiBaseUrl/auctions/create-bid';

  static String diamondDetails(String id) => '$apiBaseUrl/commodity/diamond/$id/view';

  static String diamondYouMayLike(String id) => '$apiBaseUrl/commodity/diamond/$id/you-may-also-like';

  static String gemstoneDetails(String id) => '$apiBaseUrl/commodity/color-stone/$id/view';

  // For Get the list of watchList, Create watchList and Update watchList
  static String watchList = '$apiBaseUrl/watchlist';

  static String gemstoneYouMayAlsoLike(String id) => '$apiBaseUrl/commodity/color-stone/$id/you-may-also-like';

  static String productDetails(String id) => '$apiBaseUrl/jewelleries/$id/view';

  static String watchListById(String watchlistIds) => '$apiBaseUrl/watchlist/$watchlistIds';

  static String watchListAddProduct(String watchlistId) => '$apiBaseUrl/watchlist/$watchlistId/add-product';

  static String watchListUpdateProduct(String watchlistId, String productId) =>
      '$apiBaseUrl/watchlist/$watchlistId/product/$productId/update';

  static String watchListRemoveProduct(String watchlistId, String productId) =>
      '$apiBaseUrl/watchlist/$watchlistId/product/$productId/remove';

  static String jewelleryYouMayAlsoLike(String id) => '$apiBaseUrl/jewelleries/$id/you-may-also-like';

  static String createWishList = '$apiBaseUrl/wishlist';

  static String deleteWishList(String id) => '$apiBaseUrl/wishlist/$id';

  static String productReviews = '$apiBaseUrl/product/reviews';

  static String productReviewsById(String id) => '$apiBaseUrl/product/reviews/$id';

  static String productReviewsFilter = '$apiBaseUrl/product/reviews/filter';

  static String auctionDetails(String auctionId) => '$apiBaseUrl/auctions/$auctionId';

  static String addToBag = '$apiBaseUrl/bag/create';

  static String collectionMaster = '$apiBaseUrl/collection-master';

  static String deleteBag = '$apiBaseUrl/bag';

  static String mergeBag = '$apiBaseUrl/bag/merge-bag';

  static String filterConceptList = '$apiBaseUrl/concepts/filter-list';

  static String presentationStatus = '$apiBaseUrl/presentations/status';

  static String filterOptions(String type) => '$apiBaseUrl/filter-options/$type';

  static String secondaryFilterOptions(String slug, String codes) => '$apiBaseUrl/common-modules/$slug?codes=$codes';

  static String languageList = '$apiBaseUrl/language/filter';

  static String cscMastersList = '$apiBaseUrl/csc-masters/list';

  static String customerAddress = '$apiBaseUrl/address';

  static String countryMasters = '$apiBaseUrl/country-masters';

  static String stateMasters(String countryCode) => '$apiBaseUrl/state-masters/country/$countryCode';

  static String customerAddressFilters = '$apiBaseUrl/address/filters';

  static String customerAddressById(String id) => '$apiBaseUrl/address/$id';

  static String editUserProfile = '$apiBaseUrl/customer/profile';

  static String changePassword = '$apiBaseUrl/users/change-password';

  static String cadLibraryListing = '$apiBaseUrl/jewelleries/library/cad/filters';

  static String styleLibraryListing = '$apiBaseUrl/jewelleries/library/style/filters';

  static String digitalCatalogueFilters = '$apiBaseUrl/digital-catalogue/filters';

  static String designLibraryListing = '$apiBaseUrl/jewelleries/library/design/filters';

  static String skuLibraryListing = '$apiBaseUrl/jewelleries/library/sku/filters';

  static String compareProducts = '$apiBaseUrl/compare-products';

  static String homePageKgkCoutureCollections = '$apiBaseUrl/homepage-collections/couture-collections';

  static String homePageNewlyLaunches = '$apiBaseUrl/homepage-collections/home-page-newlylaunches';

  static String homePageShopByMetals = '$apiBaseUrl/homepage-collections/home-page-shopbymetals';

  static String shapeMasterFilters = '$apiBaseUrl/homepage-collections/diamond-shape';

  static String digitalCatalogueById(String id) => '$apiBaseUrl/digital-catalogue/$id';

  static String digitalCatalogueAddComment = '$apiBaseUrl/digital-catalogue/add-comment';

  static String previewCatalogueCommentsList = '$apiBaseUrl/digital-catalogue/comments';

  static String commodityMasterFilters = '$apiBaseUrl/commodity-master/filters';

  static String homePageShopByGemstones = '$apiBaseUrl/homepage-collections/home-page-shopbygemstones';

  static String productsShare = '$apiBaseUrl/products-share';

  static String sortingData = '$apiBaseUrl/common-modules/sorting-data';

  static String wishlistFilterOptions = '$apiBaseUrl/wishlist/filter-list';

  static String logoutUser = '$apiBaseUrl/users/logout';

  static String deleteUser = '$apiBaseUrl/users';

  static String get findRetailerStore => '$apiBaseUrl/retailer-stores/filters';

  static String customerSalesman = '$apiBaseUrl/customer/salesman';

  static String bagOrderSummaryById(String id) => '$apiBaseUrl/bag/order-summary/$id';

  static String applyPromoCode = '$apiBaseUrl/promo-code/apply';

  static String removePromoCode(String id) => '$apiBaseUrl/promo-code/remove/$id';

  static String jewelleryDealOfTheDay = '$apiBaseUrl/homepage-collections/jewellery-deal-of-the-day';

  static String rmDealOfTheDay = '$apiBaseUrl/homepage-collections/rm-deal-of-the-day';

  static String checkoutStatus = '$apiBaseUrl/checkout/status';

  static String bagUserAddress = '$apiBaseUrl/bag/user/address';

  static String orderIndividual = '$apiBaseUrl/orders/individual';

  static String bag = '$apiBaseUrl/bag';

  static String digitalCatalogueFilterOptions = '$apiBaseUrl/digital-catalogue/filter-list';

  static String paymentTermsFilter = '$apiBaseUrl/payment-terms/filter';

  static String auctionListingFilterOption = '$apiBaseUrl/auctions/customer/filter-list';

  static String myOrders = '$apiBaseUrl/orders';

  static String placeB2BOrder = '$apiBaseUrl/orders';

  static String orderFilterList = '$apiBaseUrl/orders/filter-list';

  static String getCalenderEvents = '$apiBaseUrl/calendar/filters';

  static String getCalenderEventDetailsById(String id) => '$apiBaseUrl/tasks/$id';

  static String diyFilters = '$apiBaseUrl/diy/filters';

  static String diyDetails(String id) => '$apiBaseUrl/diy/$id/view';

  static String diyGemstoneFilters = '$apiBaseUrl/diy/gemstone/filters';

  static String diyGemstoneDetails(String id) => '$apiBaseUrl/diy/gemstone/$id/view';

  static String orderDetails(String id) => '$apiBaseUrl/orders/$id';

  static String getExhibitionList = '$apiBaseUrl/exhibition/filters';

  static String getExhibitionFilterListOption = '$apiBaseUrl/exhibition/filter-list';

  static String getExhibitionDetails(String id) => '$apiBaseUrl/exhibition/$id';

  static String getExhibitionProductsDetails = '$apiBaseUrl/orders/product-detail';

  static String diyStyleFilters = '$apiBaseUrl/diy/style/filters';

  static String promoCodeList = '$apiBaseUrl/promo-code/list';

  static String getExhibitionListByLocations = '$apiBaseUrl/exhibition';

  static String presentationFilters = '$apiBaseUrl/presentations/filters';

  static String pddFilterOptions = '$apiBaseUrl/presentations/filter-list';

  static String myInquiryFilterOptions = '$apiBaseUrl/customer-inquiry/filter-list';

  static String watchListFilterOptions = '$apiBaseUrl/watchlist/filter-list';

  static String inquiryType = '$apiBaseUrl/customer-inquiry/types';

  static String submitMakeInquiry = '$apiBaseUrl/customer-inquiry';

  static String editMakeInquiry(String id) => '$apiBaseUrl/customer-inquiry/$id';

  static String myInquiries = '$apiBaseUrl/customer-inquiry/filters';

  static String removeMyInquiry = '$apiBaseUrl/customer-inquiry';

  static String submitContactUs = '$apiBaseUrl/contact_us';

  static String verifyEmailOtp = '$apiBaseUrl/auth/verify-email-otp';

  static String resendEmailOtp = '$apiBaseUrl/auth/resend-email-otp';

  static String get uniqueShapes => '$apiBaseUrl/commodity/diamond/unique-shape';

  static String get orionList => '$apiBaseUrl/commodity/diamond/orion/list';

  static String diyStyleDetails(String id) => '$apiBaseUrl/diy/style/$id/view';

  static String getUserProfile = '$apiBaseUrl/customer/profile';

  static String digitalCatalogueCommentsById(String commentId) => '$apiBaseUrl/digital-catalogue/comments/$commentId';

  static String deleteDigitalCatalogueById(String id) => '$apiBaseUrl/digital-catalogue/$id';

  static String designLibraryDetails(String id) => '$apiBaseUrl/jewelleries/library/design/$id';

  static String cadLibraryDetails(String id) => '$apiBaseUrl/jewelleries/library/CAD/$id';

  static String styleLibraryDetails(String id) => '$apiBaseUrl/jewelleries/library/style/$id';

  static String skuLibraryDetails(String id) => '$apiBaseUrl/jewelleries/library/sku/$id';

  static String cancelProductFromOrder(String id) => '$apiBaseUrl/orders/$id/product';

  static String conceptList = '$apiBaseUrl/concepts/filters';

  static String staffUserFilters = '$apiBaseUrl/users/staff-user/filters';

  static String updateUserStatus(String id) => '$apiBaseUrl/users/update-user-status/$id';

  static String presentationByPresentationNumber(String presentationNumber) => '$apiBaseUrl/presentations/$presentationNumber';

  static String presentationDetailsById(String id) => '$apiBaseUrl/presentations/$id/details';

  static String diyJewellery = '$apiBaseUrl/diy/jewellery-type';
}

/// All api endpoints are defined here for the Strapi CMS
class StrapiEndPoints {
  static String get baseUrl {
    String companyTheme = StorageManager.instance.getCompanyTheme();
    switch (companyTheme) {
      case 'martin':
        return 'https://strapi-cms.martinflyer.com/api';
      case 'kgk':
        return 'https://qa-strapi-cms.kgk.magnetoinfotech.com/api';
      default:
        return 'https://dev-strapi-cms.kgk.magnetoinfotech.com/api';
    }
  } // Replace with your actual base URL

  static String get aboutUsPage => '$baseUrl/about-uses';

  static String get builder => '$baseUrl/content-type-builder/components';

  static String get contactUsPage => '$baseUrl/contact-uses';

  static String get diamondPage => '$baseUrl/diamonds';

  static String get disclaimers => '$baseUrl/disclaimers';

  static String get educationDiamondPage => '$baseUrl/education-diamonds';

  static String get educationGemstonePage => '$baseUrl/education-gemstones';

  static String get educationLabGrownDiamondPage => '$baseUrl/education-lab-grown-diamonds';

  static String get educationMetalPage => '$baseUrl/education-metals';

  static String get educationRingSizerPage => '$baseUrl/education-ring-sizers';

  static String get faqPage => '$baseUrl/faqs?populate=*&locale=';

  static String get gemstonePage => '$baseUrl/gemstones';

  static String get homePage => '$baseUrl/homes';

  static String get mobileHomePage => '$baseUrl/mobile-home-pages';

  static String get jewelleryPage => '$baseUrl/jewelleries';

  static String get notFoundPage => '$baseUrl/page-not-founds';

  static String get privacyPolicyPage => '$baseUrl/privacy-policies';

  static String get returnPolicies => '$baseUrl/return-policies';

  static String get termsOfUsesPage => '$baseUrl/terms-of-uses';

  static String get domainTheme => '$baseUrl/theme';
}

/// All attributes are defined here for the Strapi CMS
class Attributes {
  static String homePage = 'home';
  static String mobileHomePage = 'home';
  static String diamondPage = 'diamonds';
  static String gemstonePage = 'gemstones';
  static String jewelleryPage = 'jewelleries';
  static String contactUsPage = 'contact_us';
  static String aboutUsPage = 'About_us';
  static String faqPage = 'faqs';
  static String notFoundPage = 'page_not_found';
  static String termsOfUsePage = 'terms_of_use';
  static String privacyPolicyPage = 'privacy_policy';
  static String returnPolicyPage = 'return_policy';
  static String disclaimerPage = 'disclaimer';
  static String educationDiamondPage = 'diamonds';
  static String educationGemstonePage = 'gemstones';
  static String educationMetalPage = 'metals';
  static String educationRingSizerPage = 'ring_sizers';
  static String educationLabGrownDiamondPage = 'lab_grown_diamonds';
  static String findAStorePage = 'Find_a_store';
  static String checkbox = 'checkbox';
}
