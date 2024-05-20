import 'package:kgk/kgk.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onClick;
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

  const PrimaryButton({
    super.key,
    required this.onClick,
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
    return Opacity(
      opacity: isEnabled ? 1 : 0.5,
      child: GestureDetector(
        onTap: isEnabled && !isLoading ? onClick : null,
        child: Container(
          margin: margin,
          decoration: BoxDecoration(
            color: isEnabled
                ? (activeBackgroundColor ?? style.activeBackgroundColor)
                : (disableBackgroudColor ?? style.activeBackgroundColor), // Change the color when disabled
            borderRadius: borderRadius ?? BorderRadius.circular(12),
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
            child: Text(title, textAlign: TextAlign.center, style: style.titleStyle.merge(titleStyle)),
          ),
        ),
      ),
    );
  }
}
