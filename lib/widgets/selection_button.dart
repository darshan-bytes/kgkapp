import 'package:kgk/kgk.dart';

class SelectionButton extends StatelessWidget {
  final bool isSelected;
  final String? title;
  final String? image;
  final GestureTapCallback onTap;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
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

  const SelectionButton({
    super.key,
    required this.isSelected,
    this.title,
    this.image,
    required this.onTap,
    this.height,
    this.width,
    this.padding,
    this.selectedButtonColor,
    this.unselectedButtonColor,
    this.selectedButtonBorderColor,
    this.unselectedButtonBorderColor,
    this.selectedButtonIconColor,
    this.unselectedButtonIconColor,
    this.selectedButtonTextStyle,
    this.unselectedButtonTextStyle,
    this.borderRadius,
    this.iconBetweenSpace
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).selectionButtonStyle;

    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 48,
        width: width,
        padding: padding,
        decoration: BoxDecoration(
          color: isSelected ? (selectedButtonColor ?? style.selectedButtonColor) : (unselectedButtonColor ?? style.unselectedButtonColor),
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          border: Border.all(
            color: isSelected
                ? (selectedButtonBorderColor ?? style.selectedButtonBorderColor)
                : (unselectedButtonBorderColor ?? style.unselectedButtonBorderColor),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null)
              SmartImage(
                path: image!,
                color: isSelected
                    ? (selectedButtonIconColor ?? style.selectedButtonIconColor)
                    : (unselectedButtonIconColor ?? style.unselectedButtonIconColor),
              ),
            if (image != null && title != null)   SizedBox(width:iconBetweenSpace ?? 8),
            if (title != null)
              Flexible(
                child: SmartText(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isSelected
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
