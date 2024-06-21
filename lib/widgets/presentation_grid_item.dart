import 'package:kgk/kgk.dart';

class PresentationGridItem extends StatelessWidget {
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final double? imageHeight;
  final double? statusBadgeHeight;

  const PresentationGridItem({
    super.key,
    this.padding,
    this.margin,
    this.backgroundColor,
    this.borderColor,
    this.titleStyle,
    this.subTitleStyle,
    this.imageHeight,
    this.statusBadgeHeight,
  });

  @override
  Widget build(BuildContext context) {
    final PresentationGridItemStyle style = AppTheme.of(context).presentationGridItemStyle;

    return Container(
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
          _buildStatusBadge(),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return SmartImage(
      path: "",
      height: imageHeight ?? 224.w,
      width: double.infinity,
      fit: BoxFit.fill,
    );
  }

  Widget _buildDetails(PresentationGridItemStyle style) {
    return Container(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmartText(
            "Presentation Number",
            style: titleStyle ?? style.titleStyle,
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 2,
                child: SmartText(
                  "Concept name",
                  style: subTitleStyle ?? style.subTitleStyle,
                ),
              ),
              SizedBox(width: 8.w),
              Flexible(
                  flex: 1,
                  child: SmartText(
                    "24/03/2023",
                    style: subTitleStyle ?? style.subTitleStyle,
                  )),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildStatusBadge() {
    return Positioned(
      left: 16.w,
      top: 16.w,
      child: StatusBadge(
        currentStatus: OrderStatus.inProgress,
        height: statusBadgeHeight ?? 32.h,
      ),
    );
  }
}
