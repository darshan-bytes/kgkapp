import 'package:kgk/kgk.dart';

class SmartText extends StatelessWidget {
  final String? _text;
  final TextStyle? _style;
  final Color? color;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? optionalPadding;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final GestureTapCallback? onTap;
  final bool isAutoSizeText;

  const SmartText(
    String? text, {
    super.key,
    this.color,
    TextStyle? style,
    this.fontWeight,
    this.optionalPadding,
    this.overflow,
    this.textAlign,
    this.decoration,
    this.maxLines,
    this.isAutoSizeText = false,
    this.onTap,
  })  : _text = text,
        _style = style;

  @override
  Widget build(BuildContext context) {
    TextStyle? style = _style ?? TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w400, color: Colors.black);
    Widget child;
    if (isAutoSizeText) {
      child = AutoSizeText(
        _text?.tr ?? _text ?? '',
        style: ((color != null || fontWeight != null || decoration != null))
            ? style.merge(TextStyle(color: color, fontWeight: fontWeight, decoration: decoration))
            : style,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    } else {
      child = Text(
        _text?.tr ?? _text ?? '',
        style: ((color != null || fontWeight != null || decoration != null))
            ? style.merge(TextStyle(color: color, fontWeight: fontWeight, decoration: decoration))
            : style,
        overflow: overflow,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }

    if (_text != null && _text.isNotEmpty && optionalPadding != null) {
      child = Padding(padding: optionalPadding!, child: child);
    }
    if (onTap != null) {
      child = GestureDetector(
        onTap: onTap,
        child: child,
      );
    }
    return child;
  }
}
