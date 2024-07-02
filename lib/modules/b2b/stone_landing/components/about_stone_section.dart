import 'package:kgk/kgk.dart';

class AboutOurStoneSection extends StatelessWidget {
  final StonesLandingScreenStyle style;
  final bool isLearnMore;
  final String title;
  final String subTitle;
  final String imagePath;

  const AboutOurStoneSection({
    super.key,
    required this.style,
    this.isLearnMore = false,
    required this.title,
    required this.subTitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(title, style: style.sectionLabelStyle),
          SizedBox(height: 8.h),
          SmartText(
            subTitle,
            style: style.originSectionSubTitleStyle,
          ),
          if (isLearnMore)
            SmartText(
              APPStrings.learnMore.tr,
              optionalPadding: EdgeInsets.only(top: 24.h),
              style: style.learnMoreTextStyle,
            ),
          SizedBox(height: 16.h),
          SmartImage(path: imagePath),
        ],
      ),
    );
  }
}
