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
    // Get stored locale
    LanguageDatum? locale = StorageManager().getLocale();
    String languageCode = locale?.code ?? 'en';

    // Function to remove symbols and only keep letters/numbers
    String extractValidText(String text) {
      return text.replaceAll(RegExp(r'[^\w\u3040-\u30FF\u4E00-\u9FFF]'), '');
    }

    // Function to check if the text contains only numbers (English or CJK)
    bool isNumeric(String text) {
      return RegExp(r'^[0-9]+$').hasMatch(text); // English numbers (0-9)
    }

    bool isCJKNumeric(String text) {
      return RegExp(r'^[\u4E00-\u9FFF]+$').hasMatch(text); // Chinese/Japanese numbers
    }

    // Validate and detect language
    if (_text != null && _text.trim().isNotEmpty) {
      String filteredText = extractValidText(_text);

      if (filteredText.isNotEmpty) {
        try {
          if (isNumeric(filteredText)) {
            languageCode = 'en'; // English-style numbers
          } else if (isCJKNumeric(filteredText)) {
            languageCode = 'ja'; // Japanese/Chinese numbers
          } else if (filteredText.length > 2) {
            languageCode = detect(filteredText);
          }
        } catch (e) {
          debugPrint("Language detection failed: $e");
        }
      }
    }

    // Base font size
    double baseFontSize = _style?.fontSize ?? 14.0.sp;

    // ✅ Only reduce font size for Japanese (ja)
    if (languageCode == 'ja') {
      baseFontSize *= 0.85; // Reduce size by 15% for Japanese
    }

    // Apply font size adjustments
    TextStyle style = (_style ?? TextStyle()).copyWith(fontSize: baseFontSize);

    // Create text widget
    Widget child = isAutoSizeText
        ? AutoSizeText(
            _text?.tr ?? _text ?? '',
            style: style,
            overflow: overflow,
            textAlign: textAlign,
            maxLines: maxLines,
          )
        : Text(
            _text?.tr ?? _text ?? '',
            style: style,
            overflow: overflow,
            textAlign: textAlign,
            maxLines: maxLines,
          );

    // Add padding if needed
    if (_text != null && _text.isNotEmpty && optionalPadding != null) {
      child = Padding(padding: optionalPadding!, child: child);
    }

    // Add tap gesture if needed
    if (onTap != null) {
      child = GestureDetector(onTap: onTap, child: child);
    }

    return child;
  }
}
