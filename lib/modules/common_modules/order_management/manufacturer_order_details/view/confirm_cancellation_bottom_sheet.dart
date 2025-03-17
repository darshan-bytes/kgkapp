import 'package:kgk/kgk.dart';

class ConfirmCancellationBottomSheet extends StatelessWidget {
  const ConfirmCancellationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfirmCancelPopupStyle style = AppTheme.of(context).confirmCancelPopupStyle;
    final ManufacturerOrderDetailsBloc bloc = BlocProvider.of<ManufacturerOrderDetailsBloc>(context);
    return Container(
      padding: EdgeInsetsDirectional.only(top: 16.h, start: 17.w, end: 17.w, bottom: 12.h),
      decoration: BoxDecoration(color: style.whiteColor, borderRadius: BorderRadius.all(Radius.circular(16.r))),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildAppBar(context, style),
            SizedBox(
              height: 4.h,
            ),
            SmartText(
              APPStrings.orderWillBeCancelledX.tr.interpolate(['14567']),
              style: style.subTitleStyle,
            ),
            SizedBox(height: 24.h),
            _buildCancelDetailsInfoCard(style),
            SizedBox(
              height: 36.h,
            ),
            _bottomSelectionButton(context, bloc),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, ConfirmCancelPopupStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SmartText(
          APPStrings.areYouSure.tr,
          style: style.headerTitleStyle,
        ),
        SmartImage(
          path: AppImages.icCross,
          onTap: () {
            context.pop();
          },
        ),
      ],
    );
  }

  Widget _buildCancelDetailsInfoCard(ConfirmCancelPopupStyle style) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        color: style.detailBgColor,
      ),
      padding: EdgeInsetsDirectional.all(16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTitleQtyWidget(APPStrings.items.tr, '5', style),
          _buildTitleQtyWidget(APPStrings.qty.tr, '25', style),
          _buildTitleQtyWidget(APPStrings.totalAmount.tr, '\$2300.00', style),
        ],
      ),
    );
  }

  Widget _buildTitleQtyWidget(String title, String qty, ConfirmCancelPopupStyle style) {
    return Column(
      children: [
        SmartText(
          title,
          style: style.itemsTitleStyle,
        ),
        SizedBox(height: 8.h),
        SmartText(
          qty,
          style: style.qtyTitleStyle,
        ),
      ],
    );
  }

  Widget _bottomSelectionButton(BuildContext context, ManufacturerOrderDetailsBloc bloc) {
    return Row(
      children: [
        Expanded(
          child: SmartButton.white(
            onTap: () {
              context.pop();
            },
            title: APPStrings.cancel.tr,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: SmartButton(
            onTap: () {
              context.pop();
            },
            title: APPStrings.imSure.tr,
          ),
        ),
      ],
    );
  }
}
