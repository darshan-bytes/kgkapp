import 'package:kgk/kgk.dart';

class SmartDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T) itemLableBuilder;
  final void Function(T?)? onChanged;
  final TextStyle? textStyle;
  final double? menuMaxHeight;
  final Widget? icon;
  final double? height;
  final EdgeInsetsGeometry? contentPadding;

  const SmartDropdownButtonFormField({
    super.key,
    required this.items,
    required this.itemLableBuilder,
    this.value,
    this.onChanged,
    this.textStyle,
    this.height,
    this.menuMaxHeight,
    this.icon,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).customPageIndicatorStyle;
    return SizedBox(
      height: height ?? 48.h,
      child: DropdownButtonFormField<T>(
        isExpanded: true,
        value: value,
        style: textStyle ?? style.textStyle,
        menuMaxHeight: menuMaxHeight ?? 300.h,
        icon: icon ?? const Icon(Icons.keyboard_arrow_down_sharp),
        dropdownColor: style.dropDownBackgroundColor,
        decoration: InputDecoration(
          contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 10.0.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: BorderSide(
              color: style.borderColor,
              width: 1.w,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: BorderSide(
              color: style.borderColor,
              width: 1.w,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0.r),
            borderSide: BorderSide(
              color: style.borderColor,
              width: 1.w,
            ),
          ),
        ),
        onChanged: onChanged,
        items: items.map((T value) {
          return DropdownMenuItem<T>(
              value: value,
              child: SmartText(
                itemLableBuilder(value),
                style: textStyle ?? style.textStyle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ));
        }).toList(),
      ),
    );
  }
}
