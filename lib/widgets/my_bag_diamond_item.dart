import 'package:kgk/kgk.dart';

class MyBagDiamondItem extends StatelessWidget {
  final ProductDetailsModel productDetails;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final Function()? onShowMorePress;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool showMoreDetails;

  const MyBagDiamondItem({
    super.key,
    required this.productDetails,
    this.onTap,
    this.onTapMenuButton,
    this.onShowMorePress,
    this.padding,
    this.margin = EdgeInsetsDirectional.zero,
    this.showMoreDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    final MyBagDiamondItemStyle style = AppTheme.of(context).myBagDiamondItemStyle;
    final productInfoItemStyle = AppTheme.of(context).productInfoItemStyle;
    DiamondClarityChart chart = productDetails.diamondClarityChart ?? DiamondClarityChart();
    return GestureDetector(
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
          children: [
            Row(
              children: [
                SmartImage(path: productDetails.imageUrl ?? '', height: 32.w, width: 32.w),
                SizedBox(width: 8.w),
                Expanded(child: SmartText(chart.lotNumber, maxLines: 1, overflow: TextOverflow.ellipsis, style: style.headingStyle)),
                SizedBox(width: 8.w),
                InkWell(
                  onTap: () {
                    if (onTapMenuButton != null) {
                      onTapMenuButton!();
                    }
                  },
                  child: const SmartImage(path: AppImages.icMoreHorizontal),
                ),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Expanded(child: _buildDetailColumn(APPStrings.measurements.tr, chart.measurements, style))],
            ),
            SizedBox(height: 16.h),
            InkWell(
              onTap: onShowMorePress,
              child: Container(
                alignment: AlignmentDirectional.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmartText(
                      showMoreDetails ? APPStrings.lessDetails.tr : APPStrings.moreDetails.tr,
                      isAutoSizeText: true,
                      style: productInfoItemStyle.moreDetailsTextStyle,
                    ),
                    SizedBox(width: 4.w),
                    SmartImage(path: showMoreDetails ? AppImages.icArrowUp : AppImages.icArrowDown, height: 16.h, width: 16.w),
                  ],
                ),
              ),
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              child: Column(
                children:
                    showMoreDetails
                        ? [
                          SizedBox(height: 16.h),
                          const Divider(),
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
                              Expanded(child: _buildDetailColumn(APPStrings.tablePercentage.tr, chart.table, style)),
                              Expanded(child: _buildDetailColumn(APPStrings.depthPercentage.tr, chart.depth, style)),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          const Divider(),
                          SizedBox(height: 16.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildDetailColumn(APPStrings.rap.tr, chart.rap, style)),
                              Expanded(child: _buildDetailColumn(APPStrings.discount.tr, chart.discount, style, isDiscount: true)),
                              Expanded(child: _buildDetailColumn(APPStrings.kgkAmount.tr, chart.kgkAmount, style)),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildDetailColumn(APPStrings.yourPercentage.tr, chart.your, style, isTextFormField: true)),
                              Expanded(child: _buildDetailColumn(APPStrings.yourRate.tr, chart.yourRate, style)),
                              Expanded(child: _buildDetailColumn(APPStrings.yourValue.tr, chart.yourValue, style)),
                            ],
                          ),
                        ]
                        : [],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(
    String title,
    String? value,
    MyBagDiamondItemStyle style, {
    bool isTextFormField = false,
    bool isDiscount = false,
  }) {
    return Padding(
      padding: EdgeInsetsDirectional.only(end: 6.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: style.titleStyle),
          SizedBox(height: 4.h),
          isTextFormField && value != null
              ? SizedBox(
                width: 56.w,
                child: SmartTextField(
                  height: 32.h,
                  cursorHeight: 16.h,
                  contentPadding: EdgeInsetsDirectional.symmetric(horizontal: 8.w),
                  isEnabled: true,
                  controller: TextEditingController(text: value),
                  disabledBorderColor: style.borderColor,
                  textInputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
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
}
