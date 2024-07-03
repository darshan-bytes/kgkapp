import 'package:kgk/kgk.dart';

class StoneBannerView extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final String? naturalDiamondsButtonTitle;
  final VoidCallback? onTapShopNaturalDiamonds;
  final String? labDiamondsButtonTitle;
  final VoidCallback? onTapShopLabDiamonds;

  const StoneBannerView({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subTitle,
    this.naturalDiamondsButtonTitle,
    this.onTapShopNaturalDiamonds,
    this.labDiamondsButtonTitle,
    this.onTapShopLabDiamonds,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> buttonList = [];

    if (naturalDiamondsButtonTitle != null && onTapShopNaturalDiamonds != null) {
      buttonList.add(SmartButton(onTap: onTapShopNaturalDiamonds!, title: naturalDiamondsButtonTitle!));
    }

    if (labDiamondsButtonTitle != null && onTapShopLabDiamonds != null) {
      if (buttonList.isNotEmpty) {
        buttonList.add(SizedBox(height: 16.h));
      }
      buttonList.add(SmartButton(onTap: onTapShopLabDiamonds!, title: labDiamondsButtonTitle!));
    }

    return StonesBannerView(
      backgroundImagePath: imagePath,
      backgroundImageHeight: 640.h,
      bannerTitleText: title,
      bannerSubTitleText: subTitle,
      spaceBetweenImageAndTitle: 48.h,
      buttonList: buttonList,
    );
  }
}
