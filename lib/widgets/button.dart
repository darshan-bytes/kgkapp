import 'package:kgk/kgk.dart';

class SmartButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading;
  final bool isEnabled;
  final bool isShadow;
  final double? height;
  final double? width;
  final Color? activeBackgroundColor;
  final Color? disableBackgroudColor;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? disableTitleStyle;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final String? prefixImage;
  final String? suffixImage;
  final Color? activeImageColor;
  final Color? disableImageColor;
  final double? imageSize;
  final BoxShadow? boxShadow;

  final bool isWhite;

  const SmartButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.isEnabled = true,
    this.isShadow = false,
    this.height,
    this.width,
    this.activeBackgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.borderColor,
    this.padding,
    this.disableBackgroudColor,
    this.margin,
    this.disableTitleStyle,
    this.prefixImage,
    this.suffixImage,
    this.activeImageColor,
    this.disableImageColor,
    this.imageSize,
    this.boxShadow,
    this.isWhite = false,
  });

  const SmartButton.white({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.isEnabled = true,
    this.isShadow = false,
    this.height,
    this.width,
    this.activeBackgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.borderColor,
    this.padding,
    this.disableBackgroudColor,
    this.margin,
    this.disableTitleStyle,
    this.prefixImage,
    this.suffixImage,
    this.activeImageColor,
    this.disableImageColor,
    this.imageSize,
    this.boxShadow,
  }) : isWhite = true;

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).primaryButtonStyle;
    return isLoading
        ? SmartCircularProgressIndicator(
            padding: EdgeInsetsDirectional.zero,
            size: height ?? 42.w,
          )
        : Bounceable(
            onTap: isEnabled && !isLoading ? onTap : null,
            child: Container(
              margin: margin,
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  if (isShadow)
                    BoxShadow(
                      color: style.activeBackgroundColor.withValues(alpha: 0.9),
                      blurRadius: 10.0.r,
                      spreadRadius: -8.0,
                      offset: const Offset(0.0, 8.0),
                    ),
                  if (boxShadow != null) boxShadow!
                ],
                color: isEnabled
                    ? (activeBackgroundColor ?? (isWhite ? style.activeWhiteBackgroundColor : style.activeBackgroundColor))
                    : (disableBackgroudColor ?? style.disableBackgroundColor), // Change the color when disabled
                borderRadius: borderRadius ?? BorderRadius.circular(4.r),
                border: borderColor != null
                    ? Border.all(
                        width: 1.w,
                        color: borderColor!,
                      )
                    : null,
              ),
              height: height ?? 42.w,
              width: width /*?? double.infinity*/,
              padding: padding ?? EdgeInsetsDirectional.symmetric(horizontal: 12.w),
              child: prefixImage.isNotNullNorEmpty || suffixImage.isNotNullNorEmpty
                  ? Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (prefixImage.isNotNullNorEmpty) ...[
                            SmartImage(
                              path: prefixImage!,
                              height: imageSize ?? 24.w,
                              width: imageSize ?? 24.w,
                              color: isEnabled
                                  ? (activeImageColor ?? (isWhite ? style.activeWhiteImageColor : style.activeImageColor))
                                  : (disableImageColor ?? style.disableImageColor),
                            ),
                            SizedBox(width: 8.w),
                          ],
                          Flexible(
                            child: SmartText(
                              title,
                              textAlign: TextAlign.center,
                              isAutoSizeText: true,
                              maxLines: 1,
                              style: isEnabled
                                  ? (isWhite ? style.titleWhiteStyle : style.titleStyle).merge(titleStyle)
                                  : style.disableTitleStyle.merge(disableTitleStyle),
                            ),
                          ),
                          if (suffixImage.isNotNullNorEmpty) ...[
                            SizedBox(width: 8.w),
                            SmartImage(
                              path: suffixImage!,
                              height: imageSize ?? 24.w,
                              width: imageSize ?? 24.w,
                              color: isEnabled
                                  ? (activeImageColor ?? (isWhite ? style.activeWhiteImageColor : style.activeImageColor))
                                  : (disableImageColor ?? style.disableImageColor),
                            ),
                          ]
                        ],
                      ),
                    )
                  : Center(
                      child: SmartText(
                        title,
                        textAlign: TextAlign.center,
                        style: isEnabled
                            ? (isWhite ? style.titleWhiteStyle : style.titleStyle).merge(titleStyle)
                            : style.disableTitleStyle.merge(disableTitleStyle),
                      ),
                    ),
            ),
          );
  }
}
