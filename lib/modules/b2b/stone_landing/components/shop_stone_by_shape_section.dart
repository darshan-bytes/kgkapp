import 'package:kgk/kgk.dart';

class ShopStoneByShapeSection extends StatelessWidget {
  final String title;
  final List<AuctionListModel> itemList;
  final void Function(BuildContext, AuctionListModel) onTap;
  final HomeScreenStyle homeScreenStyle;
  final StonesLandingScreenStyle style;
  final Widget? widgetBetweenTitleAndItems;
  final ScrollController? scrollController;

  const ShopStoneByShapeSection({
    super.key,
    required this.title,
    required this.itemList,
    required this.onTap,
    required this.homeScreenStyle,
    required this.style,
    this.widgetBetweenTitleAndItems,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return SmartHorizontalItemBuilder(
      title: title,
      titleStyle: style.sectionLabelStyle,
      scrollController: scrollController,
      isScrollbarVisible: scrollController != null,
      widgetBetweenTitleAndItems: widgetBetweenTitleAndItems,
      itemCount: itemList.length,
      itemBetweenSpace: 17.w,
      spacingBetweenTitleAndItems: 12.h,
      titleOptionalPadding: EdgeInsetsDirectional.only(start: 17.w),
      listPadding: EdgeInsetsDirectional.only(end: 17.w),
      padding: EdgeInsetsDirectional.symmetric(vertical: 32.h),
      itemBuilder: (context, index) {
        final AuctionListModel item = itemList[index];
        return SmartImageTitleColumn(
          onTap: () => onTap(context, item),
          imageWidth: 72.w,
          title: item.name ?? '',
          titleStyle: homeScreenStyle.shopGemstoneTitleStyle,
          imageBetweenSpacing: 8.h,
          margin: EdgeInsetsDirectional.only(start: index == 0 ? 17.w : 0, end: index == itemList.length - 1 ? 17.w : 0, bottom: 10.h),
          imagePadding: EdgeInsetsDirectional.all(12.w),
          titleMaxLines: 1,
          imageUrl: item.imageUrl ?? '',
        );
      },
    );
  }
}
