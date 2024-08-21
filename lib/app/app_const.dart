import 'package:kgk/kgk.dart';

/// This class is a Dart class that contains a  constant that are used throughout the app
class AppConst {
  static Size appBarHeight = Size.fromHeight(72.0.h);
  static Size designSize = const Size(390, 844);
  static double defaultAppBarHeight = 52.0.h;
  static const int maxImagesCount = 5;
  static const double defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;
  static const String strapiApiToken =
      "209f75da6d6df7f6e575d7b80779e6ad6fa47720601d5a5f10b3e13616e0c164579ac11c65d0e51d2102db8bdb14d64a0cdc6c922e12c32e73194a7ce816822676c5c8db2da64eb3cda85f23b589b6536c88c937f4e11da29996b3dc216967d61428b25317654d4b061fba344fa0a3970dcfe9df18ee7dba9658ce1cf1a8edc1";
  static const String presentationPreviewWebViewURL = 'https://www.kgkgroup.com/';
  static const String profileDiamondWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/diamonds';
  static const String profileLabCreatedDiamondsWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/lab-grown-diamonds';
  static const String profileGemstoneWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/gemstone';
  static const String profileMetalsWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/metals';
  static const String profileRingSizerWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/ring-sizer';
  static const String profileAboutUsWebViewURL = 'https://www.kgkgroup.com/story-of-kgk/';
  static const String profilePrivacyPolicyWebViewURL = 'https://www.kgkgroup.com/privacy-policy/';

  static String splashScreenVideoUrl = Platform.isAndroid ? 'assets/images/splash_video_url.mp4' : 'assets/images/splash_video_url_ios.mp4';
  static String strapiImgBaseUrl = "https://strapi-cms.kgk.magnetoinfotech.com";
  static const int passwordLength = 8;
  static const String appCurrency = "INR";
  static const String diamondSinglestone = "DIAMONDSINGLESTONE";
  static const String diamondNormal = "DIAMONDNORMAL";
}
