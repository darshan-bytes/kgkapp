import 'Package:kgk/kgk.dart';

class StonesBannerView extends StatelessWidget {
  final Color? backgroundImageColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? backgroundImagePath;
  final String? foregroundImagePath;
  final String? bannerTitleText;
  final String? bannerSubTitleText;
  final double? spaceBetweenTitleAndSubTitle;
  final double? spaceBetweenSubTitleAndButton;
  final double? spaceBetweenImageAndTitle;
  final double? foregroundImageHeight;
  final double? foregroundImageWidth;
  final double? backgroundImageHeight;
  final double? backgroundImageWidth;
  final BoxFit backgroundImageBoxFit;
  final BoxFit foregroundImageBoxFit;
  final List<Widget>? buttonList;
  final TextStyle? bannerTitleStyle;
  final TextStyle? bannerSubTitleStyle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? titleTextAlign;
  final TextAlign? subTitleTextAlign;

  const StonesBannerView({
    super.key,
    this.padding,
    this.margin,
    this.backgroundImagePath,
    this.foregroundImagePath,
    this.bannerTitleText,
    this.bannerSubTitleText,
    this.spaceBetweenTitleAndSubTitle,
    this.spaceBetweenSubTitleAndButton,
    this.spaceBetweenImageAndTitle,
    this.foregroundImageHeight,
    this.foregroundImageWidth,
    this.backgroundImageHeight,
    this.backgroundImageWidth,
    this.backgroundImageColor,
    this.backgroundImageBoxFit = BoxFit.fill,
    this.foregroundImageBoxFit = BoxFit.fill,
    this.buttonList,
    this.bannerTitleStyle,
    this.bannerSubTitleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.titleTextAlign,
    this.subTitleTextAlign,
  });

  @override
  Widget build(BuildContext context) {
    final StonesLandingScreenStyle style = AppTheme.of(context).stonesLandingScreenStyle;
    return Container(
      margin: margin,
      height: backgroundImageHeight,
      width: backgroundImageWidth,
      color: backgroundImageColor,
      child: Stack(
        children: [
          if (backgroundImagePath != null)
            SmartImage(
                path: backgroundImagePath ?? '', fit: backgroundImageBoxFit, height: backgroundImageHeight, width: backgroundImageWidth),
          Padding(padding: padding ?? EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h), child: _buildBannerForegroundView(style)),
        ],
      ),
    );
  }

  Widget _buildBannerForegroundView(StonesLandingScreenStyle style) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (foregroundImagePath != null) ...[
          SmartImage(
              path: foregroundImagePath ?? '', height: foregroundImageHeight, width: foregroundImageWidth, fit: foregroundImageBoxFit),
          SizedBox(height: spaceBetweenImageAndTitle),
        ],
        if (bannerTitleText != null) ...[
          SmartText(bannerTitleText, style: style.sparkleTitleStyle.merge(bannerTitleStyle), textAlign: titleTextAlign),
          SizedBox(height: spaceBetweenTitleAndSubTitle ?? 8.h),
        ],
        if (bannerSubTitleText != null) ...[
          SmartText(bannerSubTitleText, style: style.sparkleSubTitleStyle.merge(bannerSubTitleStyle), textAlign: subTitleTextAlign),
          SizedBox(height: spaceBetweenSubTitleAndButton ?? 16.h),
        ],
        if (buttonList != null) ...List.generate(buttonList!.length, (index) => buttonList![index]),
      ],
    );
  }
}
