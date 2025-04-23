import 'package:kgk/kgk.dart';

class CraftedForYourSpecialMomentSection extends StatelessWidget {
  final StonesLandingScreenStyle style;
  final String title;
  final String description;
  final String buttonTitle;
  final String backgroundImage;
  final VoidCallback buttonCallBack;

  const CraftedForYourSpecialMomentSection({
    super.key,
    required this.style,
    required this.title,
    required this.description,
    required this.buttonTitle,
    required this.backgroundImage,
    required this.buttonCallBack,
  });

  @override
  Widget build(BuildContext context) {
    return StonesBannerView(
      backgroundImageHeight: 352.h,
      backgroundImagePath: backgroundImage,
      bannerTitleText: title,
      bannerSubTitleText: description,
      buttonList: [SmartButton(onTap: buttonCallBack, title: buttonTitle)],
      bannerTitleStyle: style.craftedSectionTitleStyle,
    );
  }
}
