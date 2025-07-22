import 'package:kgk/kgk.dart';

class AuctionListItem extends StatelessWidget {
  final AuctionListModel? auctionListModel;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? stoneTypeImage;

  const AuctionListItem({
    super.key,
    this.auctionListModel,
    this.onTap,
    this.padding,
    this.margin = EdgeInsetsDirectional.zero,
    this.stoneTypeImage,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).auctionListItemStyle;
    final AuctionListModel model = auctionListModel ?? AuctionListModel();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsetsDirectional.all(16.0.w),
        margin: margin,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.r), border: Border.all(color: style.borderColor)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SmartImage(path: model.imageUrl ?? '', height: 32.w, width: 32.w),
                SizedBox(width: 8.w),
                Expanded(child: SmartText(model.name, style: style.productNameStyle)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.skuNo.tr, model.skuNo, style)),
                Expanded(child: _buildDetailColumn(APPStrings.orderStatus.tr, model.orderStatus.value, style, isOrderStatus: true)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.type.tr, model.type, style, stoneTypeImage: stoneTypeImage)),
                Expanded(child: _buildDetailColumn(APPStrings.bidAmount.tr, model.bidAmount, style)),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: _buildDetailColumn(APPStrings.bidPlacedOn.tr, model.bidPlacedOn, style))],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String title, String? value, AuctionListItemStyle style, {bool isOrderStatus = false, String? stoneTypeImage}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: style.titleStyle),
        SizedBox(height: 4.h),
        isOrderStatus
            ? SmartStatusBadge(
              height: 28.h,
              currentStatus: ProjectStatus.values.firstWhere((orderStatus) => orderStatus.value == value?.toLowerCase()),
            )
            : Row(
              children: [
                if (stoneTypeImage != null)
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: 4.w),
                      child: SmartImage(path: stoneTypeImage, height: 24.w, width: 24.w, color: style.primaryColor),
                    ),
                  ),
                Flexible(
                  child: SmartText(
                    value.isNullOrEmpty ? APPStrings.dash.tr : value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.valueStyle,
                  ),
                ),
              ],
            ),
      ],
    );
  }
}
