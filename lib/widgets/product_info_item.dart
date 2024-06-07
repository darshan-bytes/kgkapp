import 'package:kgk/kgk.dart';

class ProductInfoItem extends StatelessWidget {
  final ProductDetails productDetails;
  final bool isSelectedBackground;
  final Color? selectedBackgroundColor;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final void Function()? onTap360View;
  final void Function()? onTapCertificate;
  final void Function()? onTapUSA;
  final void Function()? onTapImageViewer;
  final void Function()? onTapDNA;

  const ProductInfoItem({
    super.key,
    required this.productDetails,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsets.zero,
    this.onTap360View,
    this.onTapCertificate,
    this.onTapUSA,
    this.onTapImageViewer,
    this.onTapDNA,
    this.isSelectedBackground = false,
    this.selectedBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).myBagDiamondItemStyle;
    ProductInfoClarityChat chart = productDetails.productInfoClarityChat ?? ProductInfoClarityChat();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? EdgeInsets.all(16.0.w),
        margin: margin,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.r),
          color: isSelectedBackground ? (selectedBackgroundColor ?? style.selectedBackgroundColor) : style.backgroundColor,
          border: Border.all(color: style.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildSlotFirstWidget(chart, style),
            _buildSlotSecondWidget(chart, style),
            _buildSlotThirdWidget(chart, style),
            _buildSlotFourthWidget(chart, style)
          ],
        ),
      ),
    );
  }

  Widget _buildSlotFirstWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Column(children: [
      Row(
        children: [
          SmartImage(path: productDetails.imageUrl ?? '', height: 32.w, width: 32.w),
          SizedBox(width: 8.w),
          Expanded(
            child: SmartText(
              chart.productName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: style.headingStyle,
            ),
          ),
          SizedBox(width: 8.w),
          InkWell(
              onTap: () {
                if (onTapMenuButton != null) {
                  onTapMenuButton!();
                }
              },
              child: SizedBox(
                  height: 24.w,
                  width: 24.w,
                  child: const SmartImage(
                    path: AppImages.icMoreHorizontal,
                  )))
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildDetailColumn(APPStrings.ct.tr, chart.ct, style)),
          Expanded(child: _buildDetailColumn(APPStrings.shape.tr, chart.shape, style)),
          Expanded(child: _buildDetailColumn(APPStrings.colour.tr, chart.colour, style)),
          Expanded(child: _buildDetailColumn(APPStrings.clarity.tr, chart.clarity, style)),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildDetailColumn(APPStrings.lotNumber.tr, chart.lotNumber, style)),
          Expanded(child: _buildDetailColumn(APPStrings.certificateNumber.tr, chart.certificateNumber, style)),
        ],
      ),
      SizedBox(height: 16.h),
      const Divider(),
    ]);
  }

  Widget _buildSlotSecondWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Column(children: [
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildDetailColumn(APPStrings.lab.tr, chart.lab, style)),
          Expanded(child: _buildDetailColumn(APPStrings.cut.tr, chart.cut, style)),
          Expanded(child: _buildDetailColumn(APPStrings.polish.tr, chart.polish, style)),
          Expanded(child: _buildDetailColumn(APPStrings.symmetry.tr, chart.symmetry, style)),
        ],
      ),
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildDetailColumn(APPStrings.flourish.tr, chart.flourish, style)),
          Expanded(child: _buildDetailColumn(APPStrings.tablePercentage.tr, chart.tablePercentage, style)),
          Expanded(child: _buildDetailColumn(APPStrings.depthPercentage.tr, chart.depthPercentage, style)),
          const Expanded(child: SizedBox()),
        ],
      ),
      SizedBox(height: 16.h),
      const Divider(),
    ]);
  }

  Widget _buildSlotThirdWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildDetailColumn(APPStrings.measurements.tr, chart.measurements, style)),
            Expanded(child: _buildDetailColumn(APPStrings.rap.tr, chart.rap, style)),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: _buildDetailColumn(APPStrings.discount.tr, chart.discount, style, isDiscount: true)),
            Expanded(child: _buildDetailColumn(APPStrings.perCts.tr, chart.perCts, style)),
            Expanded(child: _buildDetailColumn(APPStrings.amount.tr, chart.amount, style)),
          ],
        ),
        SizedBox(height: 16.h),
        const Divider(),
      ],
    );
  }

  Widget _buildSlotFourthWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        _buildActionGrid(style),
      ],
    );
  }

  Widget _buildDetailColumn(String title, String? value, MyBagDiamondItemStyle style,
      {bool isTextFormField = false, bool isDiscount = false}) {
    return Container(
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
          isTextFormField && value != null
              ? SizedBox(
                  width: 56.w,
                  child: SmartTextField(
                    height: 32.h,
                    contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                    isEnabled: false,
                    controller: TextEditingController(text: value),
                    disabledBorderColor: style.borderColor,
                    style: style.subTitleStyle,
                  ),
                )
              : SmartText(
                  value.isNullOrEmpty ? APPStrings.dash.tr : value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isDiscount ? style.richTextStyle : style.subTitleStyle,
                ),
        ],
      ),
    );
  }

  Widget _buildActionGrid(MyBagDiamondItemStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildActionItem(imagePath: AppImages.icRotate3D, onTap: onTap360View, style: style),
        _buildActionItem(imagePath: AppImages.icProductCertificate, onTap: onTapCertificate, style: style),
        _buildActionItem(imagePath: AppImages.icFlagUSA, onTap: onTapUSA, style: style),
        _buildActionItem(imagePath: AppImages.icImageThin, onTap: onTapImageViewer, style: style),
        _buildActionItem(imagePath: AppImages.icDNA, onTap: onTapDNA, style: style),
      ],
    );
  }

  Widget _buildActionItem({required String imagePath, VoidCallback? onTap, required MyBagDiamondItemStyle style}) {
    return Flexible(
      child: InkWell(
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
        child: Container(
          height: 48.w,
          width: 48.w,
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            border: Border.all(
              color: style.borderColor,
            ),
            borderRadius: BorderRadius.circular(4.r),
          ),
          alignment: Alignment.center,
          child: SmartImage(
            path: imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
