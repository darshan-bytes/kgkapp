import '../kgk.dart';

enum Edge { top, right, bottom, left }

enum Clipper { start, center, end }

/// Chevron Progress Widget

class ChevronProgress extends StatelessWidget {
  const ChevronProgress({
    super.key,
    required this.child,
    required this.clipper,
    this.color = Colors.blue,
    this.edge = Edge.right,
  });

  ///The widget that is going to be clipped as chevron shape
  final Widget child;

  ///The edge the chevron points
  final Edge edge;

  /// The background color of Chevron
  final Color color;

  final Clipper clipper;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ClipShadowPainter(getClipperPainter(clipper), []),
      child: ClipPath(
        clipper: getClipperPainter(clipper),
        child: Container(
          width: clipper != Clipper.center ? 130.w : 145.w,
          color: color,
          child: child,
        ),
      ),
    );
  }

  CustomClipper<Path> getClipperPainter(clipper) {
    switch (clipper) {
      case Clipper.start:
        return PointClipper(Edge.right);
      case Clipper.center:
        return ChevronClipper(Edge.right);
      case Clipper.end:
        return LabelClipper(Edge.left);
      default:
        return ChevronClipper(edge);
    }
  }
}

class ClipShadowPainter extends CustomPainter {
  final CustomClipper<Path> clipper;
  final List<ClipShadow> clipShadows;

  ClipShadowPainter(this.clipper, this.clipShadows);

  @override
  void paint(Canvas canvas, Size size) {
    for (var shadow in clipShadows) {
      canvas.drawShadow(clipper.getClip(size), shadow.color, shadow.elevation, true);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class ClipShadow {
  final Color color;
  final double elevation;

  ClipShadow({required this.color, this.elevation = 5});
}

/// Start Clipper
class PointClipper extends CustomClipper<Path> {
  PointClipper(this.edge);

  final double triangleHeight = 30;
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.top:
        return _getTopPath(size);
      case Edge.right:
        return _getRightPath(size);
      case Edge.bottom:
        return _getBottomPath(size);
      case Edge.left:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getTopPath(Size size) {
    var path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(0.0, triangleHeight);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, triangleHeight);
    path.close();
    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    path.lineTo(size.width - triangleHeight, 0.0);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - triangleHeight, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - triangleHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width, size.height - triangleHeight);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height / 2);
    path.lineTo(triangleHeight, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(triangleHeight, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    PointClipper oldie = oldClipper as PointClipper;
    return triangleHeight != oldie.triangleHeight || edge != oldie.edge;
  }
}

/// Center Clipper
class ChevronClipper extends CustomClipper<Path> {
  ChevronClipper(this.edge);

  ///The height of triangle
  final double triangleHeight = 30;

  ///The edge the chevron points
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.top:
        return _getTopPath(size);
      case Edge.right:
        return _getRightPath(size);
      case Edge.bottom:
        return _getBottomPath(size);
      case Edge.left:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getTopPath(Size size) {
    var path = Path();
    path.moveTo(0.0, triangleHeight);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2, size.height - triangleHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, triangleHeight);
    path.lineTo(size.width / 2, 0.0);
    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    path.lineTo(triangleHeight, size.height / 2);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width - triangleHeight, size.height);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width - triangleHeight, 0.0);
    path.close();
    return path;
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.lineTo(size.width / 2, triangleHeight);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height - triangleHeight);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(0.0, size.height - triangleHeight);
    path.close();
    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    path.moveTo(0.0, size.height / 2);
    path.lineTo(triangleHeight, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width - triangleHeight, size.height / 2);
    path.lineTo(size.width, 0.0);
    path.lineTo(triangleHeight, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    ChevronClipper oldie = oldClipper as ChevronClipper;
    return triangleHeight != oldie.triangleHeight || edge != oldie.edge;
  }
}

/// End Clipper
class LabelClipper extends CustomClipper<Path> {
  LabelClipper(this.edge);

  ///The height of triangle that is going to be used to clip the [edge]
  final double triangleHeight = 30;

  ///The edge that triangle clipping is going to be applied
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.top:
        return _getTopPath(size);
      case Edge.right:
        return _getRightPath(size);
      case Edge.bottom:
        return _getBottomPath(size);
      case Edge.left:
        return _getLeftPath(size);
      default:
        return _getRightPath(size);
    }
  }

  Path _getTopPath(Size size) {
    var path = Path();
    path.lineTo(size.width / 2, triangleHeight);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  Path _getRightPath(Size size) {
    var path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width - triangleHeight, size.height / 2);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  Path _getBottomPath(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width / 2, size.height - triangleHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  Path _getLeftPath(Size size) {
    var path = Path();
    path.lineTo(triangleHeight, size.height / 2);
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.lineTo(0.0, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    LabelClipper oldie = oldClipper as LabelClipper;
    return triangleHeight != oldie.triangleHeight || edge != oldie.edge;
  }
}
