import 'package:kgk/kgk.dart';

class SvgShapePainter extends CustomPainter {
  final String text;
  final TextStyle? textStyle; // Make nullable

  SvgShapePainter(
      this.text, {
        this.textStyle, // Remove the default value here
      });

  @override
  void paint(Canvas canvas, Size size) {
    // Use a non-null text style by providing a default if null
    final effectiveTextStyle = textStyle ??
        const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        );

    // Measure text first
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: effectiveTextStyle),
      textDirection: TextDirection.ltr,
    )..layout();

    // Rest of the code remains the same
    final textWidth = textPainter.width;
    final textHeight = textPainter.height;

    double paddingLeft = 20.0; // Left padding
    double paddingRight = 30.0; // Right padding

    // Minimum width to preserve the original shape
    double minWidth = 70.0;
    // Total width needed based on text and different paddings
    double requiredWidth = max(minWidth, textPainter.width + paddingLeft + paddingRight);

    // Fixed height
    final height = 28.0;

    // Draw the shape
    final Paint paint = Paint()
      ..color = const Color(0xFF4885A3)
      ..style = PaintingStyle.fill;

    // Create dynamic path that keeps the notch proportions
    final Path path = Path();

    // Left side
    path.moveTo(4, 0);
    // Top edge
    path.lineTo(requiredWidth - 1, 0);
    // Top right corner
    path.arcToPoint(
      Offset(requiredWidth - 0.1295, 1.58124),
      radius: const Radius.circular(1),
    );
    // Right notch top
    path.lineTo(requiredWidth - 8.5848, 13.4188);
    // Right notch middle
    path.arcToPoint(
      Offset(requiredWidth - 8.5848, 14.5812),
      radius: const Radius.circular(1),
    );
    // Right notch bottom
    path.lineTo(requiredWidth - 0.1295, 26.4188);
    // Bottom right corner
    path.arcToPoint(
      Offset(requiredWidth - 1, 28),
      radius: const Radius.circular(1),
    );
    // Bottom edge
    path.lineTo(4, 28);
    // Close path
    path.close();

    canvas.drawPath(path, paint);

    // Draw the decorative lines (adjusted to be on the left side regardless of width)
    final Paint strokePaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 1.25
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Keep decorative lines on the left side at a fixed position
    final Path strokePath = Path()
      ..moveTo(16.4913, 14.6878)
      ..lineTo(22.3486, 20.5451)
      ..moveTo(18.6878, 12.4913)
      ..lineTo(24.5451, 18.3486)
      ..moveTo(15.393, 17.2503)
      ..lineTo(11, 12.8573)
      ..moveTo(21.2503, 11.393)
      ..lineTo(16.8573, 7)
      ..moveTo(20.5182, 10.6608)
      ..lineTo(14.6608, 16.5182)
      ..moveTo(11.7322, 13.5895)
      ..lineTo(17.5895, 7.73217);

    canvas.drawPath(strokePath, strokePaint);

    // Center the text
    final textX = (requiredWidth - textWidth) / 1.5;
    final textY = (height - textHeight) / 2.0;

    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    if (oldDelegate is SvgShapePainter) {
      return oldDelegate.text != text || oldDelegate.textStyle != textStyle;
    }
    return true;
  }
}