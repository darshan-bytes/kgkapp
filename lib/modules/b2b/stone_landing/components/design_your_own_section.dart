import 'package:kgk/kgk.dart';

class DesignYourOwnStoneSection extends StatelessWidget {
  final StonesLandingScreenStyle style;
  final String? mainBannerForegroundImagePath;
  final String? mainBannerTitle;
  final String? mainBannerDescription;
  final String? mainBannerFirstButtonTitle;
  final VoidCallback? mainBannerFirstButtonCallback;
  final String? mainBannerSecondButtonTitle;
  final VoidCallback? mainBannerSecondButtonCallback;
  final String firstBannerTitle;
  final String firstBannerDescription;
  final String firstBannerBackgroundImagePath;
  final String firstBannerButtonTitle;
  final VoidCallback firstBannerButtonCallback;
  final String secondBannerTitle;
  final String secondBannerDescription;
  final String secondBannerBackgroundImagePath;
  final String secondBannerButtonTitle;
  final VoidCallback secondBannerButtonCallback;
  final List<Widget>? buttonList;

  const DesignYourOwnStoneSection({
    super.key,
    required this.style,
    this.mainBannerForegroundImagePath,
    this.mainBannerTitle,
    this.mainBannerDescription,
    this.mainBannerFirstButtonTitle,
    this.mainBannerFirstButtonCallback,
    this.mainBannerSecondButtonTitle,
    this.mainBannerSecondButtonCallback,
    required this.firstBannerTitle,
    required this.firstBannerDescription,
    required this.firstBannerBackgroundImagePath,
    required this.firstBannerButtonTitle,
    required this.firstBannerButtonCallback,
    required this.secondBannerTitle,
    required this.secondBannerDescription,
    required this.secondBannerBackgroundImagePath,
    required this.secondBannerButtonTitle,
    required this.secondBannerButtonCallback,
    this.buttonList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: style.designYourOwnStoneBgColor,
      padding: EdgeInsetsDirectional.symmetric(horizontal: 17.w, vertical: 32.h),
      child: Column(
        children: [
          // StonesBannerView(
          //   padding: EdgeInsetsDirectional.zero,
          //   foregroundImagePath: mainBannerForegroundImagePath,
          //   spaceBetweenImageAndTitle: 16.h,
          //   bannerTitleText: mainBannerTitle,
          //   bannerTitleStyle: style.craftedSectionTitleStyle,
          //   bannerSubTitleText: mainBannerDescription,
          //   bannerSubTitleStyle: style.originSectionSubTitleStyle,
          //   buttonList: buttonList ??
          //       [
          //         if (mainBannerFirstButtonCallback != null)
          //           SmartButton(onTap: mainBannerFirstButtonCallback ?? () {}, title: mainBannerFirstButtonTitle!),
          //         if (mainBannerSecondButtonCallback != null) SizedBox(height: 16.h),
          //         if (mainBannerSecondButtonCallback != null)
          //           SmartButton(onTap: mainBannerSecondButtonCallback ?? () {}, title: mainBannerSecondButtonTitle!),
          //       ],
          // ),
          // SizedBox(height: 24.h),
          StonesBannerView(
            padding: EdgeInsetsDirectional.all(16.w),
            backgroundImagePath: firstBannerBackgroundImagePath,
            backgroundImageHeight: 200.h,
            spaceBetweenTitleAndSubTitle: 4.h,
            bannerTitleText: firstBannerTitle,
            bannerSubTitleText: firstBannerDescription,
            bannerTitleStyle: style.designOwnEarringTextStyle,
            bannerSubTitleStyle: style.sparkleSubTitleStyle,
            buttonList: [SmartButton(onTap: firstBannerButtonCallback, title: firstBannerButtonTitle)],
          ),
          SizedBox(height: 24.h),
          StonesBannerView(
            padding: EdgeInsetsDirectional.all(16.w),
            backgroundImagePath: secondBannerBackgroundImagePath,
            backgroundImageHeight: 200.h,
            spaceBetweenTitleAndSubTitle: 4.h,
            bannerTitleText: secondBannerTitle,
            bannerSubTitleText: secondBannerDescription,
            bannerTitleStyle: style.designOwnEarringTextStyle,
            bannerSubTitleStyle: style.sparkleSubTitleStyle,
            buttonList: [SmartButton(onTap: secondBannerButtonCallback, title: secondBannerButtonTitle)],
          ),
        ],
      ),
    );
  }
}
