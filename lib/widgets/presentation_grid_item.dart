import 'package:kgk/kgk.dart';

class PresentationGridItem extends StatelessWidget {
  final B2BCustomListingDataModel b2bCustomListingDataModel;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? imageHeight;
  final double? statusBadgeHeight;
  final void Function()? onTap;

  const PresentationGridItem({
    super.key,
    required this.b2bCustomListingDataModel,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.titleStyle,
    this.subTitleStyle,
    this.imageHeight,
    this.statusBadgeHeight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final PresentationGridItemStyle style = AppTheme.of(context).presentationGridItemStyle;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor ?? style.backgroundColor,
          border: Border.all(color: borderColor ?? style.borderColor, width: 1.w),
        ),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(),
                _buildDetails(style),
              ],
            ),
            if (b2bCustomListingDataModel.status != null)
              PositionedDirectional(
                start: 16.w,
                top: 16.w,
                child: SmartStatusBadge(
                  currentStatus: b2bCustomListingDataModel.status!,
                  height: statusBadgeHeight ?? 32.h,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SmartImage(
      path: b2bCustomListingDataModel.strPresentationImageUrl ?? '',
      height: imageHeight ?? 224.h,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  Widget _buildDetails(PresentationGridItemStyle style) {
    return Container(
      padding: EdgeInsetsDirectional.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (b2bCustomListingDataModel.strPresentationNumber.isNotNullNorEmpty) ...[
                SmartText(
                  b2bCustomListingDataModel.strPresentationNumber,
                  style: titleStyle ?? style.titleStyle,
                ),
                SizedBox(width: 8.w),
                if (b2bCustomListingDataModel.strCreatedOn.isNotNullNorEmpty)
                  Flexible(
                    flex: 1,
                    child: SmartText(
                      b2bCustomListingDataModel.strCreatedOn,
                      style: subTitleStyle ?? style.subTitleStyle,
                    ),
                  ),
              ],
            ],
          ),
          if (b2bCustomListingDataModel.strConceptName.isNotNullNorEmpty) ...[
            SizedBox(height: 4.h),
            SmartText(
              getConceptName(),
              style: subTitleStyle ?? style.subTitleStyle,
            )
          ]
        ],
      ),
    );
  }

  String getConceptName() {
    if (b2bCustomListingDataModel.strConceptNumber.isNotNullNorEmpty) {
      return '${b2bCustomListingDataModel.strConceptNumber} - ${b2bCustomListingDataModel.strConceptName}';
    } else {
      return b2bCustomListingDataModel.strConceptName.toString();
    }
  }
}
