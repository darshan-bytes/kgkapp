import 'package:kgk/kgk.dart';

class SmartCheckbox extends StatelessWidget {
  final String? label;
  final bool value;
  final Function(bool?) onChanged;
  final TextStyle? labelStyle;
  final double? height;
  final double? width;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final MainAxisSize? mainAxisSize;
  final double? spaceBetweenLabelAndCheckbox;
  final bool isRadio;

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
    this.mainAxisSize,
    this.spaceBetweenLabelAndCheckbox,
  }) : isRadio = false;

  const SmartCheckbox.radio({
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
    this.mainAxisSize,
    this.spaceBetweenLabelAndCheckbox,
  }) : isRadio = true;

  @override
  Widget build(BuildContext context) {
    final CheckboxStyle style = AppTheme.of(context).checkboxStyle;
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding ?? EdgeInsetsDirectional.zero,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: mainAxisSize ?? MainAxisSize.max,
          children: [
            SizedBox(
              height: height ?? 20.w,
              width: width ?? 20.w,
              child:
                  isRadio
                      ? SmartImage(
                        path: value ? AppImages.icRadioSelected : AppImages.icRadio,
                        height: height ?? 20.w,
                        width: width ?? 20.w,
                      )
                      : Checkbox(
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
            SizedBox(width: spaceBetweenLabelAndCheckbox ?? 6.w),
            if (label != null) Flexible(child: SmartText(label, style: style.textStyle.merge(labelStyle))),
          ],
        ),
      ),
    );
  }
}
