import 'package:kgk/kgk.dart';

class ShopStoneByShapeSection extends StatelessWidget {
  final String title;
  final List<AuctionListModel> itemList;
  final void Function(BuildContext, AuctionListModel) onTap;
  final HomeScreenStyle homeScreenStyle;
  final StonesLandingScreenStyle style;
  final Widget? widgetBetweenTitleAndItems;

  const ShopStoneByShapeSection({
    super.key,
    required this.title,
    required this.itemList,
    required this.onTap,
    required this.homeScreenStyle,
    required this.style,
    this.widgetBetweenTitleAndItems,
  });

  @override
  Widget build(BuildContext context) {
    return SmartHorizontalItemBuilder(
      title: title,
      titleStyle: style.sectionLabelStyle,
      widgetBetweenTitleAndItems: widgetBetweenTitleAndItems,
      itemCount: itemList.length,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsets.only(left: 17.w),
      listPadding: EdgeInsets.only(right: 17.w),
      padding: EdgeInsets.symmetric(vertical: 32.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = itemList[index];
        return SmartImageTitleColumn(
          onTap: () => onTap(context, item),
          imageWidth: 72.w,
          title: item.name ?? '',
          titleStyle: homeScreenStyle.shopGemstoneTitleStyle,
          imageBetweenSpacing: 8.h,
          margin: EdgeInsets.only(
            left: index == 0 ? 17.w : 0,
            right: index == itemList.length - 1 ? 17.w : 0,
          ),
          imagePadding: EdgeInsets.all(12.w),
          titleMaxLines: 1,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }
}
