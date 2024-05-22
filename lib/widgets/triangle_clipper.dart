import 'package:kgk/kgk.dart';

class TriangleClipper extends CustomClipper<Path> {
  final ArrowPosition arrowPosition;

  TriangleClipper({this.arrowPosition = ArrowPosition.centerTop});

  @override
  Path getClip(Size size) {
    final path = Path();
    switch (arrowPosition) {
      case ArrowPosition.leftTop:
        path.moveTo(0.0, size.height); // Move to bottom-left corner
        path.lineTo(size.width / 2, 0.0); // Line to top-center
        path.lineTo(size.width, size.height); // Line to bottom-right corner
        break;
      case ArrowPosition.centerTop:
        path.moveTo(0.0, size.height); // Move to bottom-left corner
        path.lineTo(size.width / 2, 0.0); // Line to top-center
        path.lineTo(size.width, size.height); // Line to bottom-right corner
        break;
      case ArrowPosition.rightTop:
        path.moveTo(0.0, size.height); // Move to bottom-left corner
        path.lineTo(size.width / 2, 0.0); // Line to top-center
        path.lineTo(size.width, size.height); // Line to bottom-right corner
        break;
    }
    path.close(); // Close the path to form a triangle
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
