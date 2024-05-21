import 'package:kgk/kgk.dart';

class SmartTextSpan {
  final String text;
  final TextStyle? style;
  final VoidCallback? onTap;

  SmartTextSpan({
    required this.text,
    this.style,
    this.onTap,
  });
}

class SmartRichText extends StatelessWidget {
  final List<SmartTextSpan> spans;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;

  const SmartRichText({
    super.key,
    required this.spans,
    this.textAlign = TextAlign.start,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).smartRichTextStyle;
    List<TextSpan> textSpans = spans.map((span) {
      return TextSpan(
        text: span.text,
        style: span.style ?? style.textStyle,
        recognizer: span.onTap != null ? (TapGestureRecognizer()..onTap = span.onTap) : null,
      );
    }).toList();

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: RichText(
        text: TextSpan(
          style: style.textStyle,
          children: textSpans,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
