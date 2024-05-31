import 'package:kgk/kgk.dart';

class MyBagDiamondItem extends StatelessWidget {
  final ProductDetails productDetails;
  final Function()? onTap;
  final Function()? onTapMenuButton;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const MyBagDiamondItem({
    super.key,
    required this.productDetails,
    this.onTap,
    this.onTapMenuButton,
    this.padding,
    this.margin = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).myBagDiamondItemStyle;
    DiamondClarityChart chart = productDetails.diamondClarityChart ?? DiamondClarityChart();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(16.0),
        margin: margin,
        decoration: BoxDecoration(
          color: style.backgroundColor,
          border: Border.all(color: style.borderColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SmartImage(path: productDetails.imageUrl ?? '', height: 32, width: 32),
                const SizedBox(width: 8),
                Expanded(
                  child: SmartText(
                    chart.lotNumber,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: style.headingStyle,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                    onTap: () {
                      if (onTapMenuButton != null) {
                        onTapMenuButton!();
                      }
                    },
                    child: const SmartImage(path: AppImages.icMoreHorizontal))
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.ct.tr, chart.ct, style)),
                Expanded(child: _buildDetailColumn(APPStrings.shape.tr, chart.shape, style)),
                Expanded(child: _buildDetailColumn(APPStrings.colour.tr, chart.colour, style)),
                Expanded(child: _buildDetailColumn(APPStrings.clarity.tr, chart.clarity, style)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.lotNumber.tr, chart.lotNumber, style)),
                Expanded(child: _buildDetailColumn(APPStrings.certificateNumber.tr, chart.certificateNumber, style)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.measurements.tr, chart.measurements, style)),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.lab.tr, chart.lab, style)),
                Expanded(child: _buildDetailColumn(APPStrings.cut.tr, chart.cut, style)),
                Expanded(child: _buildDetailColumn(APPStrings.polish.tr, chart.polish, style)),
                Expanded(child: _buildDetailColumn(APPStrings.symmetry.tr, chart.symmetry, style)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.flourish.tr, chart.flourish, style)),
                Expanded(child: _buildDetailColumn(APPStrings.tablePercentage.tr, chart.table, style)),
                Expanded(child: _buildDetailColumn(APPStrings.depthPercentage.tr, chart.depth, style)),
                const Expanded(child: SizedBox()),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.rap.tr, chart.rap, style)),
                Expanded(child: _buildDetailColumn(APPStrings.discount.tr, chart.discount, style)),
                Expanded(child: _buildDetailColumn(APPStrings.kgkAmount.tr, chart.kgkAmount, style)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildDetailColumn(APPStrings.yourPercentage.tr, chart.your, style, isTextFormField: true)),
                Expanded(child: _buildDetailColumn(APPStrings.yourRate.tr, chart.yourRate, style)),
                Expanded(child: _buildDetailColumn(APPStrings.yourValue.tr, chart.yourValue, style)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailColumn(String title, String? value, MyBagDiamondItemStyle style, {bool isTextFormField = false}) {
    return Padding(
      padding: const EdgeInsets.only(right: 17),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: style.titleStyle,
          ),
          const SizedBox(height: 4),
          isTextFormField && value != null
              ? SizedBox(
                  width: 56,
                  child: SmartTextField(
                    height: 32,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
                  style: style.subTitleStyle,
                ),
        ],
      ),
    );
  }
}
