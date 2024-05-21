import 'package:flutter/material.dart';
import 'package:kgk/theme/app_theme.dart';

class SmartRichText extends StatelessWidget {
  final List<InlineSpan> textSpans;
  final EdgeInsetsGeometry? padding;
  final TextAlign textAlign;

  const SmartRichText({
    super.key,
    required this.textSpans,
    this.padding,
    this.textAlign = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    final style = AppTheme.of(context).smartRichTextStyle;
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: RichText(
        text: TextSpan(
          children: textSpans,
        ),
        textAlign: textAlign,
      ),
    );
  }
}
