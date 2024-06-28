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
    ValueNotifier<bool> showMoreDetails = ValueNotifier<bool>(false);
    final style = AppTheme.of(context).myBagDiamondItemStyle;
    final productInfoItemStyle = AppTheme.of(context).productInfoItemStyle;
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
            _buildProductNameView(chart, style),
            _buildSlotFirstWidget(chart, style, productInfoItemStyle),
            _buildSlotSecondWidget(chart, style, productInfoItemStyle),
            _buildSlotThirdWidget(chart, style, productInfoItemStyle, showMoreDetails),
            _buildSlotFourthWidget(chart, style)
          ],
        ),
      ),
    );
  }

  Widget _buildProductNameView(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Row(
      children: [
        SmartImage(path: productDetails.imageUrl ?? '', height: 32.w, width: 32.w),
        SizedBox(width: 8.w),
        Expanded(
          child: SmartText(
            chart.productName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.headingStyle,
            isAutoSizeText: true,
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
            ),
          ),
        )
      ],
    );
  }

  Widget _buildSlotFirstWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle) {
    TextStyle shapeTextStyle = productInfoItemStyle.stoneShapeTextStyle;
    return Column(children: [
      SizedBox(height: 16.h),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SmartText(chart.colour, isAutoSizeText: true, style: shapeTextStyle),
          _buildDivider(style),
          SmartText(chart.clarity, isAutoSizeText: true, style: shapeTextStyle),
          _buildDivider(style),
          SmartText(
              "${chart.cut?.substring(0, 2).toUpperCase()}/${chart.polish?.substring(0, 2).toUpperCase()}/${chart.symmetry?.substring(0, 2).toUpperCase()}",
              isAutoSizeText: true,
              style: shapeTextStyle),
          _buildDivider(style),
          SmartText(chart.clarity, isAutoSizeText: true, style: shapeTextStyle),
          _buildDivider(style),
          SmartText(chart.colour, isAutoSizeText: true, style: shapeTextStyle),
        ],
      ),
      SizedBox(height: 16.h),
      const Divider(),
      SizedBox(height: 16.h),
    ]);
  }

  Widget _buildSlotSecondWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle) {
    return SmartGridView(runSpacing: 8.h, items: [
      _buildRowDetailItem(APPStrings.rapRate.tr, chart.rapRate, style, productInfoItemStyle),
      _buildRowDetailItem(APPStrings.rate.tr, chart.rap, style, productInfoItemStyle),
      _buildRowDetailItem(APPStrings.discountPercentage.tr, chart.discount, style, productInfoItemStyle, isDiscount: true),
      _buildRowDetailItem(APPStrings.amt.tr, chart.amount, style, productInfoItemStyle),
    ]);
  }

  Widget _buildSlotThirdWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle,
      ValueNotifier<bool> showMoreDetails) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      child: ValueListenableBuilder<bool>(
        valueListenable: showMoreDetails,
        builder: (context, value, child) {
          return Column(
            children: [
              if (showMoreDetails.value) ...[
                SizedBox(height: 16.h),
                const Divider(),
                SizedBox(height: 16.h),
                SmartGridView(columns: 3, runSpacing: 8.h, items: [
                  _buildDetailColumn(APPStrings.lotNo.tr, chart.lotNumber, style, productInfoItemStyle),
                  _buildDetailColumn(APPStrings.shape.tr, chart.shape, style, productInfoItemStyle),
                  _buildDetailColumn(APPStrings.fluorescence.tr, chart.fluorescence, style, productInfoItemStyle),
                  _buildDetailColumn(APPStrings.lab.tr, chart.lab, style, productInfoItemStyle),
                ]),
              ],
              InkWell(
                onTap: () {
                  showMoreDetails.value = !showMoreDetails.value;
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmartText(
                        showMoreDetails.value ? APPStrings.lessDetails.tr : APPStrings.moreDetails.tr,
                        isAutoSizeText: true,
                        onTap: () {},
                        style: productInfoItemStyle.moreDetailsTextStyle,
                      ),
                      SizedBox(width: 4.w),
                      SmartImage(
                        path: showMoreDetails.value ? AppImages.icArrowUp : AppImages.icArrowDown,
                        height: 16.h,
                        width: 16.w,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _buildSlotFourthWidget(ProductInfoClarityChat chart, MyBagDiamondItemStyle style) {
    return Column(
      children: [
        const Divider(),
        SizedBox(height: 16.h),
        _buildActionGrid(style),
      ],
    );
  }

  Widget _buildDivider(MyBagDiamondItemStyle style) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.12.w),
      child: Container(
        height: 20.h,
        width: 1,
        color: style.borderColor,
      ),
    );
  }

  Widget _buildDetailColumn(String title, String? value, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle,
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
            style: productInfoItemStyle.labelTextStyle,
            isAutoSizeText: true,
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
                  style: isDiscount ? style.richTextStyle : productInfoItemStyle.valueTextStyle,
                  isAutoSizeText: true,
                ),
        ],
      ),
    );
  }

  Widget _buildRowDetailItem(String title, String? value, MyBagDiamondItemStyle style, ProductInfoItemStyle productInfoItemStyle,
      {bool isDiscount = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SmartText(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: productInfoItemStyle.labelTextStyle,
          isAutoSizeText: true,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: SmartText(
            value.isNullOrEmpty ? APPStrings.dash.tr : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: isDiscount ? style.richTextStyle : productInfoItemStyle.valueTextStyle,
            isAutoSizeText: true,
          ),
        ),
      ],
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
