import 'package:kgk/kgk.dart';

class SmartImageTitleColumn extends StatelessWidget {
  final Color? backgroundColor;
  final String? imageUrl;
  final Widget? topWidget;
  final String title;
  final String? subTitle;
  final double? width;
  final double? height;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final EdgeInsets? imagePadding;
  final double? imageBetweenSpacing;
  final double? subTitleTopSpacing;
  final double? imageSize;
  final AlignmentGeometry? alignment;
  final BoxFit? fit;
  final VoidCallback? onTap;
  final CrossAxisAlignment crossAxisAlignment;
  final int? titleMaxLines;
  final int? subTitleMaxLines;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final BorderRadiusGeometry? borderRadius;
  final BorderRadiusGeometry? imageBorderRadius;
  final Color? imageColor;
  final BoxBorder? imageBorder;

  const SmartImageTitleColumn({
    super.key,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderRadius,
    this.backgroundColor,
    this.imageUrl,
    required this.title,
    this.imagePadding,
    this.imageBetweenSpacing,
    this.alignment,
    this.fit,
    this.onTap,
    this.width,
    this.height,
    this.titleStyle,
    this.subTitle,
    this.subTitleStyle,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.titleMaxLines,
    this.subTitleMaxLines,
    this.imageSize,
    this.topWidget,
    this.imageBorderRadius,
    this.imageColor,
    this.imageBorder,
    this.subTitleTopSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).smartImageTitleColumnStyle;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        alignment: alignment,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          color: backgroundColor,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            _buildTopWidgetView(),
            SizedBox(height: imageBetweenSpacing ?? 8.h),
            SmartText(
              title,
              style: style.titleStyle.merge(titleStyle),
              maxLines: titleMaxLines ?? 2,
              overflow: TextOverflow.ellipsis,
            ),
            if (subTitle.isNotNullNorEmpty) ...[
              SizedBox(height: subTitleTopSpacing ?? 8.h),
              SmartText(
                subTitle!,
                style: style.subTitleStyle.merge(subTitleStyle),
                maxLines: subTitleMaxLines ?? 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTopWidgetView() {
    if (topWidget != null) {
      return topWidget!;
    } else if (imageUrl != null) {
      return Container(
        decoration: BoxDecoration(
          border: imageBorder,
          borderRadius: imageBorderRadius,
          color: imageColor,
        ),
        child: SmartImage(
          path: imageUrl!,
          width: imageSize,
          height: imageSize,
          padding: imagePadding,
          fit: fit,
          color: imageColor,
          imageBorderRadius: imageBorderRadius,
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
