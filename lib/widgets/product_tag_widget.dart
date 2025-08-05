import 'package:kgk/kgk.dart';

class ProductTagWidget extends StatelessWidget {
  final ProductTagType tagType;

  const ProductTagWidget({super.key, required this.tagType});

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).productTagStyle;
    return Container(
      color: getTagColor(style),
      child: Row(
        children: [
          if (getPrefixImage.isNotNullNorEmpty) SmartImage(path: getPrefixImage ?? ''),
          SmartText('text'),
          SmartImage(path: AppImages.icTagTrail, color: getTagColor(style)),
        ],
      ),
    );
  }

  Color getTagColor(ProductTagStyle style) {
    switch (tagType) {
      case ProductTagType.discount:
        return style.discountColor;

      case ProductTagType.auction:
        return style.auctionColor;

      case ProductTagType.exclusive:
        return style.exclusiveColor;
      default:
        return style.auctionColor;
    }
  }

  String? get getPrefixImage {
    switch (tagType) {
      case ProductTagType.discount:
        return AppImages.icDiscountTag;
      case ProductTagType.auction:
        return AppImages.icAuctionTag;
      case ProductTagType.exclusive:
        return AppImages.icExclusiveTag;
      case ProductTagType.newArrival:
        return AppImages.icNewArrivalTag;
      case ProductTagType.bestSeller:
        return AppImages.icBestSellerTag;
      case ProductTagType.inHouse:
        return AppImages.icInHouseTag;
      default:
        return null;
    }
  }
}
