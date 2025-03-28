/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String devApiBase = 'https://api.kgk.magnetoinfotech.com/v1';
  static const String qaApiBase = 'https://qa-api.kgk.magnetoinfotech.com/v1';
  static const String apiBaseUrl = qaApiBase;
  static const String assetsBaseUrl = '$apiBaseUrl/assets/';

  static const String loginUser = '$apiBaseUrl/auth/front-sign-in';
  static const String verifyQrCodeForAuth = '$apiBaseUrl/auth/verify-qr-scanner';
  static const String checkDuplicationEmail = '$apiBaseUrl/users/check-email-duplication';

  static String checkDuplicationPhoneNumber(String code, String phoneNumber) =>
      '$apiBaseUrl/users/phone-code/$code/phone/$phoneNumber/lookup';

  static const String businessTypes = '$apiBaseUrl/business-types';
  static const String officeLocations = '$apiBaseUrl/subarea-masters';
  static const String signUpCustomer = '$apiBaseUrl/customer/signup';

  static const String forgotPassword = '$apiBaseUrl/auth/forgot-password';
  static const String currencies = '$apiBaseUrl/currency';
  static const String languageLabels = '$apiBaseUrl/language/labels';

  static const String diamondListing = '$apiBaseUrl/commodity/diamond/filters';
  static const String gemstoneListing = '$apiBaseUrl/commodity/color-stone/filters';
  static const String jewelleryListing = '$apiBaseUrl/jewelleries/filters';
  static const String wishlist = '$apiBaseUrl/wishlist/filters';
  static const String bagListData = '$apiBaseUrl/bag/list';
  static const String auctionListing = '$apiBaseUrl/auctions/customer/filter';
  static const String createBid = '$apiBaseUrl/auctions/create-bid';

  static String diamondDetails(String id) => '$apiBaseUrl/commodity/diamond/$id/view';

  static String diamondYouMayLike(String id) => '$apiBaseUrl/commodity/diamond/$id/you-may-also-like';

  static String gemstoneDetails(String id) => '$apiBaseUrl/commodity/color-stone/$id/view';

  // For Get the list of watchList, Create watchList and Update watchList
  static const String watchList = '$apiBaseUrl/watchlist';

  static String gemstoneYouMayAlsoLike(String id) => '$apiBaseUrl/commodity/color-stone/$id/you-may-also-like';

  static String productDetails(String id) => '$apiBaseUrl/jewelleries/$id/view';

  static String watchListById(String watchlistIds) => '$apiBaseUrl/watchlist/$watchlistIds';

  static String watchListAddProduct(String watchlistId) => '$apiBaseUrl/watchlist/$watchlistId/add-product';

  static String watchListUpdateProduct(String watchlistId, String productId) =>
      '$apiBaseUrl/watchlist/$watchlistId/product/$productId/update';

  static String watchListRemoveProduct(String watchlistId, String productId) =>
      '$apiBaseUrl/watchlist/$watchlistId/product/$productId/remove';

  static String jewelleryYouMayAlsoLike(String id) => '$apiBaseUrl/jewelleries/$id/you-may-also-like';

  static const String createWishList = '$apiBaseUrl/wishlist';

  static String deleteWishList(String id) => '$apiBaseUrl/wishlist/$id';

  static const String productReviews = '$apiBaseUrl/product/reviews';

  static String productReviewsFilter(String productId) => '$apiBaseUrl/product/reviews/filter/$productId';

  static String auctionDetails(String auctionId) => '$apiBaseUrl/auctions/$auctionId';

  static const String addToBag = '$apiBaseUrl/bag/create';

  static const String collectionMaster = '$apiBaseUrl/collection-master';

  static const String deleteBag = '$apiBaseUrl/bag';

  static const String mergeBag = '$apiBaseUrl/bag/merge-bag';

  static const String filterConceptList = '$apiBaseUrl/concepts/filter-list';

  static const String presentationStatus = '$apiBaseUrl/presentations/status';

  static String filterOptions(String type) => '$apiBaseUrl/filter-options/$type';

  static String secondaryFilterOptions(String slug, String codes) => '$apiBaseUrl/common-modules/$slug?codes=$codes';

  static const String languageList = '$apiBaseUrl/language/filter';

  static const String cscMastersList = '$apiBaseUrl/csc-masters/list';

  static const String customerAddress = '$apiBaseUrl/address';

  static const String countryMasters = '$apiBaseUrl/country-masters';

  static String stateMasters(String countryCode) => '$apiBaseUrl/state-masters/country/$countryCode';

  static const String customerAddressFilters = '$apiBaseUrl/address/filters';

  static String customerAddressById(String id) => '$apiBaseUrl/address/$id';

  static const String editUserProfile = '$apiBaseUrl/customer/profile';

  static const String changePassword = '$apiBaseUrl/users/change-password';

  static const String cadLibraryListing = '$apiBaseUrl/jewelleries/library/cad/filters';

  static const String styleLibraryListing = '$apiBaseUrl/jewelleries/library/style/filters';

  static const String digitalCatalogueFilters = '$apiBaseUrl/digital-catalogue/filters';

  static const String designLibraryListing = '$apiBaseUrl/jewelleries/library/design/filters';

  static const String skuLibraryListing = '$apiBaseUrl/jewelleries/library/sku/filters';

  static const String compareProducts = '$apiBaseUrl/compare-products';

  static const String homePageKgkCoutureCollections = '$apiBaseUrl/homepage-collections/couture-collections';

  static const String homePageNewlyLaunches = '$apiBaseUrl/homepage-collections/home-page-newlylaunches';

  static const String homePageShopByMetals = '$apiBaseUrl/homepage-collections/home-page-shopbymetals';

  static const String shapeMasterFilters = '$apiBaseUrl/shape-master/filters';

  static String digitalCatalogueById(String id) => '$apiBaseUrl/digital-catalogue/$id';

  static const String digitalCatalogueAddComment = '$apiBaseUrl/digital-catalogue/add-comment';

  static const String previewCatalogueCommentsList = '$apiBaseUrl/digital-catalogue/comments';

  static const String commodityMasterFilters = '$apiBaseUrl/commodity-master/filters';

  static const String homePageShopByGemstones = '$apiBaseUrl/homepage-collections/home-page-shopbygemstones';

  static const String productsShare = '$apiBaseUrl/products-share';

  static const String sortingData = '$apiBaseUrl/common-modules/sorting-data';

  static const String wishlistFilterOptions = '$apiBaseUrl/wishlist/filter-list';

  static const String logoutUser = '$apiBaseUrl/users/logout';

  static const String deleteUser = '$apiBaseUrl/users';

  static String get findRetailerStore => '$apiBaseUrl/retailer-stores/filters';

  static const String customerSalesman = '$apiBaseUrl/customer/salesman';

  static String bagOrderSummaryById(String id) => '$apiBaseUrl/bag/order-summary/$id';

  static const String applyPromoCode = '$apiBaseUrl/promo-code/apply';

  static String removePromoCode(String id) => '$apiBaseUrl/promo-code/remove/$id';

  static const String jewelleryDealOfTheDay = '$apiBaseUrl/homepage-collections/jewellery-deal-of-the-day';

  static const String rmDealOfTheDay = '$apiBaseUrl/homepage-collections/rm-deal-of-the-day';

  static const String checkoutStatus = '$apiBaseUrl/checkout/status';

  static const String bagUserAddress = '$apiBaseUrl/bag/user/address';

  static const String orderIndividual = '$apiBaseUrl/orders/individual';

  static const String bag = '$apiBaseUrl/bag';

  static const String digitalCatalogueFilterOptions = '$apiBaseUrl/digital-catalogue/filter-list';

  static const String paymentTermsFilter = '$apiBaseUrl/payment-terms/filter';

  static const String auctionListingFilterOption = '$apiBaseUrl/auctions/customer/filter-list';

  static const String myOrders = '$apiBaseUrl/orders';

  static const String placeB2BOrder = '$apiBaseUrl/orders';

  static const String orderFilterList = '$apiBaseUrl/orders/filter-list';

  static const String getCalenderEvents = '$apiBaseUrl/calendar/filters';

  static String getCalenderEventDetailsById(String id) => '$apiBaseUrl/tasks/$id';

  static const String diyFilters = '$apiBaseUrl/diy/filters';

  static String diyDetails(String id) => '$apiBaseUrl/diy/$id/view';

  static String orderDetails(String id) => '$apiBaseUrl/orders/$id';

  static const String getExhibitionList = '$apiBaseUrl/exhibition/filters';

  static const String getExhibitionFilterListOption = '$apiBaseUrl/exhibition/filter-list';

  static String getExhibitionDetails(String id) => '$apiBaseUrl/exhibition/$id';

  static String getExhibitionProductsDetails = '$apiBaseUrl/orders/product-detail';

  static const String diyStyleFilters = '$apiBaseUrl/diy/style/filters';

  static const String promoCodeList = '$apiBaseUrl/promo-code/list';

  static const String getExhibitionListByLocations = '$apiBaseUrl/exhibition';

  static const String presentationFilters = '$apiBaseUrl/presentations/filters';

  static const String pddFilterOptions = '$apiBaseUrl/presentations/filter-list';

  static const String watchListFilterOptions = '$apiBaseUrl/watchlist/filter-list';

  static const String inquiryType = '$apiBaseUrl/customer-inquiry/types';

  static const String submitMakeInquiry = '$apiBaseUrl/customer-inquiry';

  static const String submitContactUs = '$apiBaseUrl/contact_us';

  static const String verifyEmailOtp = '$apiBaseUrl/auth/verify-email-otp';

  static const String resendEmailOtp = '$apiBaseUrl/auth/resend-email-otp';

  static String get uniqueShapes => '$apiBaseUrl/commodity/diamond/unique-shape';

  static String get orionList => '$apiBaseUrl/commodity/diamond/orion/list';

  static String diyStyleDetails(String id) => '$apiBaseUrl/diy/style/$id/view';

  static const String getUserProfile = '$apiBaseUrl/customer/profile';

  static String digitalCatalogueCommentsById(String commentId) => '$apiBaseUrl/digital-catalogue/comments/$commentId';

  static String deleteDigitalCatalogueById(String id) => '$apiBaseUrl/digital-catalogue/$id';

  static String designLibraryDetails(String id) => '$apiBaseUrl/jewelleries/library/design/$id';

  static String cadLibraryDetails(String id) => '$apiBaseUrl/jewelleries/library/CAD/$id';

  static String cancelProductFromOrder(String id) => '$apiBaseUrl/orders/$id/product';

  static const String conceptList = '$apiBaseUrl/concepts/filters';

  static const String staffUserFilters = '$apiBaseUrl/users/staff-user/filters';
}

/// All api endpoints are defined here for the Strapi CMS
class StrapiEndPoints {
  static const String baseUrl = 'https://qa-strapi-cms.kgk.magnetoinfotech.com/api'; // Replace with your actual base URL

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

  static String get faqPage => '$baseUrl/faqs';

  static String get gemstonePage => '$baseUrl/gemstones';

  static String get homePage => '$baseUrl/homes';

  static String get mobileHomePage => '$baseUrl/mobile-home-pages';

  static String get jewelleryPage => '$baseUrl/jewelleries';

  static String get notFoundPage => '$baseUrl/page-not-founds';

  static String get privacyPolicyPage => '$baseUrl/privacy-policies';

  static String get returnPolicies => '$baseUrl/return-policies';

  static String get termsOfUsesPage => '$baseUrl/terms-of-uses';
}

/// All attributes are defined here for the Strapi CMS
class Attributes {
  static const String homePage = 'home';
  static const String mobileHomePage = 'home';
  static const String diamondPage = 'diamonds';
  static const String gemstonePage = 'gemstones';
  static const String jewelleryPage = 'jewelleries';
  static const String contactUsPage = 'contact_us';
  static const String aboutUsPage = 'About_us';
  static const String faqPage = 'faqs';
  static const String notFoundPage = 'page_not_found';
  static const String termsOfUsePage = 'terms_of_use';
  static const String privacyPolicyPage = 'privacy_policy';
  static const String returnPolicyPage = 'return_policy';
  static const String disclaimerPage = 'disclaimer';
  static const String educationDiamondPage = 'diamonds';
  static const String educationGemstonePage = 'gemstones';
  static const String educationMetalPage = 'metals';
  static const String educationRingSizerPage = 'ring_sizers';
  static const String educationLabGrownDiamondPage = 'lab_grown_diamonds';
  static const String findAStorePage = 'Find_a_store';
  static const String checkbox = 'checkbox';
}
