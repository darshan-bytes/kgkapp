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
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final String? prefixImage;
  final Color? activeImageColor;
  final Color? disableImageColor;
  final double? imageSize;

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
    this.activeImageColor,
    this.disableImageColor,
    this.imageSize,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).primaryButtonStyle;
    return GestureDetector(
      onTap: isEnabled && !isLoading ? onTap : null,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          boxShadow: isShadow
              ? <BoxShadow>[
                  BoxShadow(
                    color: style.activeBackgroundColor.withOpacity(0.9),
                    blurRadius: 10.0.r,
                    spreadRadius: -8.0,
                    offset: const Offset(0.0, 8.0),
                  )
                ]
              : null,
          color: isEnabled
              ? (activeBackgroundColor ?? style.activeBackgroundColor)
              : (disableBackgroudColor ?? style.disableBackgroundColor), // Change the color when disabled
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          border: borderColor != null
              ? Border.all(
                  width: 1.w,
                  color: borderColor!,
                )
              : null,
        ),
        height: height ?? 48.h,
        width: width ?? double.infinity,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: prefixImage.isNotNullNorEmpty
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SmartImage(
                      path: prefixImage!,
                      height: imageSize ?? 24.w,
                      width: imageSize ?? 24.w,
                      color: isEnabled ? (activeImageColor ?? style.activeImageColor) : (disableImageColor ?? style.disableImageColor),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      title,
                      style: isEnabled ? style.titleStyle.merge(titleStyle) : style.disableTitleStyle.merge(disableTitleStyle),
                    ),
                  ],
                ),
              )
            : Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: isEnabled ? style.titleStyle.merge(titleStyle) : style.disableTitleStyle.merge(disableTitleStyle),
                ),
              ),
      ),
    );
  }
}
