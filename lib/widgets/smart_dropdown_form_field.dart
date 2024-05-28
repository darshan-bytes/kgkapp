import 'package:kgk/kgk.dart';

class SmartDropdownButtonFormField<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final String Function(T) itemLabelBuilder;
  final void Function(T?)? onChanged;
  final TextStyle? textStyle;
  final double menuMaxHeight;
  final Widget? icon;
  final double height;
  final EdgeInsetsGeometry? contentPadding;

  const SmartDropdownButtonFormField({
    super.key,
    required this.items,
    required this.itemLabelBuilder,
    this.value,
    this.onChanged,
    this.textStyle,
    this.height = 48,
    this.menuMaxHeight = 300,
    this.icon,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).customPageIndicatorStyle;
    return SizedBox(
      height: height,
      child: DropdownButtonFormField<T>(
        value: value,
        style: textStyle ?? style.textStyle,
        menuMaxHeight: menuMaxHeight,
        icon: icon ?? const Icon(Icons.keyboard_arrow_down_sharp),
        dropdownColor: style.dropDownBackgroundColor,
        decoration: InputDecoration(
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: style.borderColor,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: style.borderColor,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.0),
            borderSide: BorderSide(
              color: style.borderColor,
              width: 1,
            ),
          ),
        ),
        onChanged: onChanged,
        items: items.map((T value) {
          return DropdownMenuItem<T>(
              value: value,
              child: SmartText(
                itemLabelBuilder(value),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ));
        }).toList(),
      ),
    );
  }
}
