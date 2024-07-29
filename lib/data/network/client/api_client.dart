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
}

/// All api endpoints are defined here for the Strapi CMS
class EndPoints {
  static const String baseUrl = 'https://strapi-cms.kgk.magnetoinfotech.com'; // Replace with your actual base URL

  static String get aboutUsPage => '$baseUrl/api/about-uses';

  static String get builder => '$baseUrl/api/content-type-builder/components';

  static String get contactUsPage => '$baseUrl/api/contact-uses';

  static String get diamondPage => '$baseUrl/api/diamonds';

  static String get disclaimers => '$baseUrl/api/disclaimers';

  static String get educationDiamondPage => '$baseUrl/api/education-diamonds';

  static String get educationGemstonePage => '$baseUrl/api/education-gemstones';

  static String get educationLabGrownDiamondPage => '$baseUrl/api/education-lab-grown-diamonds';

  static String get educationMetalPage => '$baseUrl/api/education-metals';

  static String get educationRingSizerPage => '$baseUrl/api/education-ring-sizers';

  static String get faqPage => '$baseUrl/api/faqs';

  static String get gemstonePage => '$baseUrl/api/gemstones';

  static String get homePage => '$baseUrl/api/homes';

  static String get jewelleryPage => '$baseUrl/api/jewelleries';

  static String get notFoundPage => '$baseUrl/api/page-not-founds';

  static String get privacyPolicyPage => '$baseUrl/api/privacy-policies';

  static String get returnPolicies => '$baseUrl/api/return-policies';

  static String get termsOfUsesPage => '$baseUrl/api/terms-of-uses';
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
