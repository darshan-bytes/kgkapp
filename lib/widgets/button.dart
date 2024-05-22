import 'package:kgk/kgk.dart';

class SmartButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isLoading;
  final bool isEnabled;
  final double? height;
  final Color? activeBackgroundColor;
  final Color? disableBackgroudColor;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? titleStyle;
  final TextStyle? disableTitleStyle;
  final Color? borderColor;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  const SmartButton({
    super.key,
    required this.onTap,
    required this.title,
    this.isLoading = false,
    this.isEnabled = true,
    this.height,
    this.activeBackgroundColor,
    this.borderRadius,
    this.titleStyle,
    this.borderColor,
    this.padding,
    this.disableBackgroudColor,
    this.margin,
    this.disableTitleStyle,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).primaryButtonStyle;
    return GestureDetector(
      onTap: isEnabled && !isLoading ? onTap : null,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: isEnabled
              ? (activeBackgroundColor ?? style.activeBackgroundColor)
              : (disableBackgroudColor ?? style.disableBackgroundColor), // Change the color when disabled
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          border: borderColor != null
              ? Border.all(
                  width: 1,
                  color: borderColor!,
                )
              : null,
        ),
        height: height ?? 48,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Center(
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
