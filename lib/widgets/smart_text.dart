import 'package:kgk/kgk.dart';

class SmartText extends StatelessWidget {
  final String? text;
  final TextStyle? style;
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
      this.text, {
        super.key,
        this.color,
        this.style,
        this.fontWeight,
        this.optionalPadding,
        this.overflow,
        this.textAlign,
        this.decoration,
        this.maxLines,
        this.isAutoSizeText = false,
        this.onTap,
      });

  @override
  Widget build(BuildContext context) {
    // Detect language
    final String languageCode = LanguageHelper.detectLanguage(text);

    // Calculate base font size
    final double baseFontSize = style?.fontSize ?? 14.0.sp;

    // Apply font size adjustments
    final double adjustedFontSize = LanguageHelper.adjustFontSize(baseFontSize, languageCode);

    // Create final style with all properties
    final TextStyle finalStyle = (style ?? TextStyle(
      fontSize: adjustedFontSize,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    )).copyWith(
      fontSize: adjustedFontSize,
      fontWeight: fontWeight ?? style?.fontWeight,
      color: color ?? style?.color,
      decoration: decoration ?? style?.decoration,
    );

    // Display text with translation if available
    final String displayText = text?.tr ?? text ?? '';

    // Create appropriate text widget
    Widget child = isAutoSizeText
        ? AutoSizeText(
      displayText,
      style: finalStyle,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    )
        : Text(
      displayText,
      style: finalStyle,
      overflow: overflow,
      textAlign: textAlign,
      maxLines: maxLines,
    );

    // Add padding if needed
    if (text != null && text!.isNotEmpty && optionalPadding != null) {
      child = Padding(padding: optionalPadding!, child: child);
    }

    // Add tap gesture if needed
    if (onTap != null) {
      child = GestureDetector(onTap: onTap, child: child);
    }

    return child;
  }
}