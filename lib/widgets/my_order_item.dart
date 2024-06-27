import 'package:kgk/kgk.dart';

class MyOrderItem extends StatelessWidget {
  final MyOrderDetailsModel? myOrderDetailsModel;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const MyOrderItem({
    super.key,
    this.myOrderDetailsModel,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).myBagDiamondItemStyle;
    final MyOrderDetailsModel model = myOrderDetailsModel ?? MyOrderDetailsModel();
    return Stack(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: padding ?? EdgeInsets.all(16.0.w),
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: style.backgroundColor,
              border: Border.all(color: style.borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailColumn(APPStrings.orderId.tr, model.orderId, style)),
                    Expanded(
                        child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: _buildDetailColumn(APPStrings.orderStatus.tr, model.orderStatus.value, style, isOrderStatus: true)),
                        InkWell(
                            onTap: () {
                              if (onTapMenuButton != null) {
                                onTapMenuButton!();
                              }
                            },
                            child: const SmartImage(path: AppImages.icMoreHorizontal))
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailColumn(APPStrings.orderedOn.tr, model.orderDate, style)),
                    Expanded(child: _buildDetailColumn(APPStrings.totalAmount.tr, model.orderTotal, style)),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildDetailColumn(APPStrings.items.tr, model.orderItems, style)),
                    Expanded(child: _buildDetailColumn(APPStrings.qty.tr, model.orderQuantity, style)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDetailColumn(String title, String? value, MyBagDiamondItemStyle style, {bool isOrderStatus = false}) {
    return Padding(
      padding: EdgeInsets.only(right: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.titleStyle,
          ),
          SizedBox(height: 4.h),
          isOrderStatus
              ? SmartStatusBadge(currentStatus: ProjectStatus.values.firstWhere((orderStatus) => orderStatus.value == value))
              : SmartText(
                  value.isNullOrEmpty ? APPStrings.dash.tr : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: style.subTitleStyle,
                ),
        ],
      ),
    );
  }
}
