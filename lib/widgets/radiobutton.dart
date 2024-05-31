import 'package:kgk/kgk.dart';

class SmartRadioButton<T> extends StatelessWidget {
  final String? label;
  final T value;
  final T? groupValue;
  final Function(T?) onChanged;
  final TextStyle? textStyle;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final Widget? textLabel;
  final bool isToggle;
  final FocusNode? focusNode;

  const SmartRadioButton({
    super.key,
    this.label,
    this.groupValue,
    required this.value,
    required this.onChanged,
    this.textStyle,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.padding,
    this.textLabel,
    this.isToggle = false,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).radioButtonStyle;
    bool isSelected = groupValue == value;
    return GestureDetector(
      onTap: () {
        if (isToggle && groupValue == value) {
          onChanged(null);
        } else {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SmartImage(
                path: isSelected ? AppImages.icRadioSelected : AppImages.icRadio,
                height: 24,
                width: 24,
              ),
            ),
            if (label != null) const SizedBox(width: 4),
            if (label != null)
              SmartText(
                label,
                style: style.textStyle.merge(textStyle),
              ),
          ],
        ),
      ),
    );
  }
}
