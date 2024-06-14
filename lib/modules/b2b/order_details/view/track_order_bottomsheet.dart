import 'package:kgk/kgk.dart';

class TrackOrderBottomSheet extends StatelessWidget {
  const TrackOrderBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderDetailBloc orderDetailBloc = BlocProvider.of<OrderDetailBloc>(context);
    final TrackOrderBottomSheetStyle style = AppTheme.of(context).trackOrderBottomSheetStyle;
    final SmartTileLineStepperStyle smartTileLineStepperStyle = AppTheme.of(context).smartTileLineStepperStyle;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 580.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
          color: style.backgroundColor,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 16.h),
                  _buildAppBar(context, style),
                  SizedBox(height: 24.h),
                  _buildOrderDetailsInfoCard(style),
                  SizedBox(height: 24.h),
                  _buildTrackOrderView(orderDetailBloc, smartTileLineStepperStyle),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, TrackOrderBottomSheetStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(APPStrings.trackProduct.tr, style: style.titleStyle),
        SizedBox(width: 8.w),
        SmartImage(
          path: AppImages.icCross,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }

  Widget _buildOrderDetailsInfoCard(TrackOrderBottomSheetStyle style) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: style.orderInfoBackgroundColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            "Order #14567",
            style: style.orderIdStyle,
          ),
          SizedBox(height: 8.h),
          Material(
            child: ListTile(
                contentPadding: EdgeInsets.zero,
                isThreeLine: true,
                leading: SmartImage(
                  path: "https://i.ibb.co/8xM4BxQ/image-7.png",
                  height: 48.w,
                  width: 48.w,
                ),
                dense: true,
                horizontalTitleGap: 12.w,
                title: SmartText(
                  "Diamond Vine Ring in 18k Gold",
                  style: style.imageTitleStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Row(
                  children: [
                    Flexible(
                      child: SmartText(
                        'Martin Flyer',
                        style: style.imageSubTitleStyle,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Flexible(
                      child: SmartText(
                        'DERS01XXSRR',
                        style: style.imageSubTitleStyle,
                      ),
                    ),
                  ],
                ),
                trailing: SmartText("x15", style: style.quantityStyle)),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackOrderView(OrderDetailBloc orderDetailBloc, SmartTileLineStepperStyle smartTileLineStepperStyle) {
    return SmartTileLineStepper(
      currentStep: orderDetailBloc.currentTrackOrderIndex,
      steps: [
        SmartStep(
            title: 'Order placed',
            content: SmartText("Order placed from customer\n23/03/2023", style: smartTileLineStepperStyle.subtitleStyle)),
        SmartStep(
          title: 'Product ready to dispatch',
          content: SmartText(
            "Shipped and ready for pickup\n24/03/2023",
            style: smartTileLineStepperStyle.subtitleStyle,
          ),
        ),
        SmartStep(
          title: 'Arrived at Mumbai facility',
          content: SmartText('Shipment is arrived at Mumbai facility\n25/03/2023', style: smartTileLineStepperStyle.subtitleStyle),
        ),
        SmartStep(
          title: 'Out for delivery',
          content: SmartText('Delivery person is out for delivery\n26/03/2023', style: smartTileLineStepperStyle.subtitleStyle),
        ),
      ],
    );
  }
}
