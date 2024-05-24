import 'package:kgk/kgk.dart';

class SmartCheckbox extends StatelessWidget {
  final String? label;
  final bool value;
  final Function onChanged;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final EdgeInsets? padding;

  const SmartCheckbox({
    super.key,
    this.label,
    required this.value,
    required this.onChanged,
    this.height,
    this.width,
    this.labelStyle,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final CheckboxStyle style = AppTheme.of(context).checkboxStyle;
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding ?? const EdgeInsets.all(0.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height ?? 20,
              width: width ?? 20,
              child: Checkbox(
                activeColor: style.activeColor,
                checkColor: style.checkColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                side: BorderSide(color: borderColor ?? style.borderColor),
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue);
                },
              ),
            ),
            const SizedBox(width: 8),
            if (label != null)
              Expanded(
                child: SmartText(label, style: style.textStyle.merge(labelStyle)),
              )
          ],
        ),
      ),
    );
  }
}
