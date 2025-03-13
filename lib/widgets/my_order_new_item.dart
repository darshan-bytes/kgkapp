import 'package:kgk/kgk.dart';

class MyOrderNewItem extends StatelessWidget {
  final MyOrderDetailsModel? myOrderDetailsModel;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const MyOrderNewItem({
    super.key,
    this.myOrderDetailsModel,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsetsDirectional.zero,
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
            padding: padding ?? EdgeInsetsDirectional.all(16.0.w),
            margin: margin,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: style.backgroundColor,
              border: Border.all(color: style.borderColor),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 6.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SmartText(
                                  APPStrings.orderId.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: style.titleStyle,
                                ),
                                if (model.orderStatus.value.isNotEmpty) ...[
                                  SizedBox(
                                    width: 10.w,
                                  ),
                                  SmartStatusBadge(
                                    currentStatus:
                                        ProjectStatus.values.firstWhere((orderStatus) => orderStatus.value == model.orderStatus.value),
                                    fontSize: 10.sp,
                                  ),
                                ]
                              ],
                            ),
                            SizedBox(height: 4.h),
                            SmartText(
                              model.orderId.isNullOrEmpty ? APPStrings.dash.tr : model.orderId,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: style.subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10.w),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmartText(
                          '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style.titleStyle,
                        ),
                        SizedBox(height: 4.h),
                        SmartText(
                          model.orderTotal.isNullOrEmpty ? APPStrings.dash.tr : model.orderTotal,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: style.subTitleStyle,
                        ),
                      ],
                    ))
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(end: 6.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SmartText(
                                  APPStrings.orderedOn.tr,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: style.titleStyle,
                                )
                              ],
                            ),
                            SizedBox(height: 4.h),
                            SmartText(
                              model.orderDate.isNullOrEmpty ? APPStrings.dash.tr : model.orderDate,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: style.subTitleStyle,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: _buildDetailColumn(APPStrings.deliveryDate.tr, "22/03/23", style)),
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
                SizedBox(height: 16.h),
                SizedBox(
                  height: 50.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: model.orderImages?.length,
                    itemBuilder: (context, index) {
                      if (model.orderImages == null) return const SizedBox.shrink();
                      return SmartImage(
                        path: model.orderImages![index],
                        fit: BoxFit.fill,
                        height: 50.w,
                        width: 50.w,
                        margin: EdgeInsetsDirectional.only(end: 10.w),
                      );
                    },
                  ),
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
      padding: EdgeInsetsDirectional.only(end: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SmartText(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: style.titleStyle,
              ),
              if (isOrderStatus) ...[
                SizedBox(
                  width: 10.w,
                ),
                SmartStatusBadge(
                  currentStatus: ProjectStatus.blueInProgress,
                  fontSize: 10.sp,
                ),
              ]
            ],
          ),
          SizedBox(height: 4.h),
          SmartText(
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
