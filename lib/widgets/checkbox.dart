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
        padding: padding ?? EdgeInsets.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height ?? 20.w,
              width: width ?? 20.w,
              child: Checkbox(
                activeColor: style.activeColor,
                checkColor: style.checkColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                side: BorderSide(color: borderColor ?? style.borderColor),
                value: value,
                onChanged: (bool? newValue) {
                  onChanged(newValue);
                },
              ),
            ),
            SizedBox(width: 6.w),
            if (label != null)
              Flexible(
                child: SmartText(label, style: style.textStyle.merge(labelStyle)),
              )
          ],
        ),
      ),
    );
  }
}
