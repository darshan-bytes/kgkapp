import 'package:kgk/kgk.dart';

class OrderDetailsProductItem extends StatelessWidget {
  final OrderDetailsProductModel productDetails;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapMenuButton;

  const OrderDetailsProductItem({super.key, required this.productDetails, this.onTap, this.onTapMenuButton});

  @override
  Widget build(BuildContext context) {
    final AuctionListItemStyle style = AppTheme.of(context).auctionListItemStyle;
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(16.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0.r),
              border: Border.all(color: style.borderColor),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    buildDetailsColumn(style, APPStrings.sku.tr, productDetails.sku, isExpanded: true),
                    SizedBox(width: 24.w),
                    buildDetailsColumn(style, APPStrings.status.tr, '-',
                        isStatus: true, status: productDetails.orderStatus, isExpanded: true),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    SmartImage(
                      path: productDetails.image ?? '',
                      width: 44.w,
                      height: 44.h,
                      imageBorderRadius: BorderRadius.circular(5.5.r),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: SmartText(
                        productDetails.name ?? '-',
                        style: style.valueStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                SmartGridView(
                  items: [
                    buildDetailsColumn(style, APPStrings.qty.tr, productDetails.quantity),
                    buildDetailsColumn(style, APPStrings.amount.tr, productDetails.price),
                    buildDetailsColumn(style, APPStrings.brand.tr, productDetails.brand),
                    //Delivery Date
                    buildDetailsColumn(style, APPStrings.deliveryDate.tr, productDetails.deliveryDate),
                  ],
                  columns: 2,
                  spacing: 24.w,
                  runSpacing: 16.0.h,
                ),
              ],
            ),
          ),
          if (onTapMenuButton != null)
            Positioned(
              top: 14.h,
              right: 14.w,
              child: SmartImage(
                path: AppImages.icMoreHorizontal,
                onTap: onTapMenuButton,
                padding: EdgeInsets.all(4.w),
                inkwellBorderRadius: BorderRadius.circular(4.0.r),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildDetailsColumn(AuctionListItemStyle style, String title, String? value,
      {bool isExpanded = false, bool isStatus = false, ProjectStatus? status}) {
    Widget child = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SmartText(title, style: style.titleStyle),
        SizedBox(height: 4.0.h),
        isStatus ? SmartStatusBadge(currentStatus: status!) : SmartText(value ?? '-', style: style.valueStyle),
      ],
    );
    return isExpanded ? Expanded(child: child) : child;
  }
}
