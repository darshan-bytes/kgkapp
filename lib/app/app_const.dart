import 'package:kgk/kgk.dart';

/// This class is a Dart class that contains a  constant that are used throughout the app
class AppConst {
  static Size appBarHeight = Size.fromHeight(72.0.h);
  static Size designSize = const Size(390, 844);
  static double defaultAppBarHeight = 52.0.h;
  static const int maxImagesCount = 5;
  static const double defaultScrollControlDisabledMaxHeightRatio = 9.0 / 16.0;
  static const String presentationPreviewWebViewURL = 'https://www.kgkgroup.com/';
  static const String profileDiamondWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/diamonds';
  static const String profileLabCreatedDiamondsWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/lab-grown-diamonds';
  static const String profileGemstoneWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/gemstone';
  static const String profileMetalsWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/metals';
  static const String profileRingSizerWebViewURL = 'https://dev.kgk.magnetoinfotech.com/en/education/ring-sizer';
  static const String profileAboutUsWebViewURL = 'https://www.kgkgroup.com/story-of-kgk/';
  static const String profilePrivacyPolicyWebViewURL = 'https://www.kgkgroup.com/privacy-policy/';

  static String splashScreenVideoUrl = Platform.isAndroid ? 'assets/images/splash_video_url.mp4' : 'assets/images/splash_video_url_ios.mp4';
}
