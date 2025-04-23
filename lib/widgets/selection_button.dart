import 'package:kgk/kgk.dart';

class SelectionButton extends StatelessWidget {
  final bool isSelected;
  final String? title;
  final String? image;
  final GestureTapCallback onTap;
  final double? height;
  final double? width;
  final double? imageHeight;
  final double? imageWidth;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? selectedButtonColor;
  final Color? unselectedButtonColor;
  final Color? selectedButtonBorderColor;
  final Color? unselectedButtonBorderColor;
  final Color? selectedButtonIconColor;
  final Color? unselectedButtonIconColor;
  final TextStyle? selectedButtonTextStyle;
  final TextStyle? unselectedButtonTextStyle;
  final BorderRadiusGeometry? borderRadius;
  final double? iconBetweenSpace;
  final BoxConstraints? constraints;
  final double scaleFactor;
  final BoxFit? fit;
  final bool matchTextDirection;

  const SelectionButton({
    super.key,
    required this.isSelected,
    this.title,
    this.image,
    required this.onTap,
    this.height,
    this.width,
    this.imageHeight,
    this.imageWidth,
    this.padding,
    this.margin,
    this.selectedButtonColor,
    this.unselectedButtonColor,
    this.selectedButtonBorderColor,
    this.unselectedButtonBorderColor,
    this.selectedButtonIconColor,
    this.unselectedButtonIconColor,
    this.selectedButtonTextStyle,
    this.unselectedButtonTextStyle,
    this.borderRadius,
    this.iconBetweenSpace,
    this.constraints,
    this.scaleFactor = 0.8,
    this.fit,
    this.matchTextDirection = false,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).selectionButtonStyle;

    // This widget is used for both button and icon button in the same way
    // If selected button is true then the button will be work as primaray button else it will be normal widget
    return Bounceable(
      scaleFactor: scaleFactor,
      onTap: onTap,
      child: Container(
        height: height ?? 48.w,
        width: width,
        padding: padding,
        margin: margin,
        constraints: constraints,
        alignment: AlignmentDirectional.center,
        decoration: BoxDecoration(
          color: isSelected ? (selectedButtonColor ?? style.selectedButtonColor) : (unselectedButtonColor ?? style.unselectedButtonColor),
          borderRadius: borderRadius ?? BorderRadius.circular(4.r),
          border: Border.all(
            color:
                isSelected
                    ? (selectedButtonBorderColor ?? style.selectedButtonBorderColor)
                    : (unselectedButtonBorderColor ?? style.unselectedButtonBorderColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (image != null)
              SmartImage(
                path: image!,
                color:
                    isSelected
                        ? (selectedButtonIconColor ?? style.selectedButtonIconColor)
                        : (unselectedButtonIconColor ?? style.unselectedButtonIconColor),
                height: imageHeight,
                width: imageWidth,
                fit: fit,
                matchTextDirection: matchTextDirection,
              ),
            if (image != null && title != null) SizedBox(width: iconBetweenSpace ?? 8.w),
            if (title != null)
              Flexible(
                child: SmartText(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      isSelected
                          ? (selectedButtonTextStyle ?? style.selectedButtonTextStyle)
                          : (unselectedButtonTextStyle ?? style.unselectedButtonTextStyle),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
