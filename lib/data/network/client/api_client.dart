/// All api endpoints are defined here
class ApiClient {
  ApiClient._();

  static const String apiBaseUrl = 'https://api.kgk.magnetoinfotech.com/v1';
  static const String strapiHomeApiUrl =
      'https://strapi-cms.kgk.magnetoinfotech.com/api/mobile-home-pages?populate%5Bhome%5D%5Bpopulate%5D=images%2Cdata.image%2Cslug%2CImage';

  static const String loginUser = '$apiBaseUrl/auth/front-sign-in';
  static const String signUpUser = '$apiBaseUrl/oauth/signup';
  static const String userProfile = '$apiBaseUrl/user/profile';

  static const String businessTypes = '$apiBaseUrl/business-types';
  static const String officeLocations = '$apiBaseUrl/subarea-masters';

  static const String forgotPassword = '$apiBaseUrl/auth/forgot-password';
  static const String currencies = '$apiBaseUrl/currency';
  static const String languageLabels = '$apiBaseUrl/language/labels';

  static const String diamondListing = '$apiBaseUrl/diamond/filters';
}

/// All api endpoints are defined here for the Strapi CMS
class StrapiEndPoints {
  static const String baseUrl = 'https://strapi-cms.kgk.magnetoinfotech.com/api'; // Replace with your actual base URL

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

  static String get jewelleryPage => '$baseUrl/jewelleries';

  static String get notFoundPage => '$baseUrl/page-not-founds';

  static String get privacyPolicyPage => '$baseUrl/privacy-policies';

  static String get returnPolicies => '$baseUrl/return-policies';

  static String get termsOfUsesPage => '$baseUrl/terms-of-uses';
}

/// All attributes are defined here for the Strapi CMS
class Attributes {
  static const String homePage = 'home';
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
}
