import '../kgk.dart';

enum Edge { TOP, RIGHT, BOTTOM, LEFT }

class Chevron extends StatelessWidget {
  const Chevron(
      {super.key,
      this.triangleHeight = 30,
      this.color = Colors.blue,
      required this.child,
      this.edge = Edge.RIGHT,
      this.clipShadows = const []});

  ///The widget that is going to be clipped as point shape
  final Widget child;

  ///The height of the triangle
  final double triangleHeight;

  ///The edge that Point points
  final Edge edge;

  /// The background color of Chevron
  final Color color;

  ///List of shadows to be cast on the border
  final List<ClipShadow> clipShadows;

  @override
  Widget build(BuildContext context) {
    var clipper = PointClipper(triangleHeight, edge);
    return CustomPaint(
      painter: ClipShadowPainter(clipper, clipShadows),
      child: ClipPath(
        clipper: clipper,
        child: Container(
          width: 130,
          color: color,
          child: child,
        ),
      ),
    );
  }
}

class PointClipper extends CustomClipper<Path> {
  PointClipper(this.triangleHeight, this.edge);

  final double triangleHeight;
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.TOP:
        return _getTopPath(size);
      case Edge.RIGHT:
        return _getRightPath(size);
      case Edge.BOTTOM:
        return _getBottomPath(size);
      case Edge.LEFT:
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

/// Chevron Progress Widget

class ChevronProgress extends StatelessWidget {
  const ChevronProgress(
      {super.key,
      this.triangleHeight = 30,
      required this.isLabel,
      required this.child,
      this.color = Colors.blue,
      this.edge = Edge.RIGHT,
      this.clipShadows = const []});

  ///The widget that is going to be clipped as chevron shape
  final Widget child;

  ///The height of triangle
  final double triangleHeight;

  ///The edge the chevron points
  final Edge edge;

  /// The background color of Chevron
  final Color color;

  ///List of shadows to be cast on the border
  final List<ClipShadow> clipShadows;

  final bool isLabel;

  @override
  Widget build(BuildContext context) {
    var chevronClipper = ChevronClipper(triangleHeight, edge);
    var labelClipper = LabelClipper(triangleHeight, Edge.LEFT);
    return CustomPaint(
      painter: ClipShadowPainter(isLabel ? labelClipper : chevronClipper, clipShadows),
      child: ClipPath(
        clipper: isLabel ? labelClipper : chevronClipper,
        child: Container(
          width: isLabel ? 130.w : 145.w,
          color: color,
          child: child,
        ),
      ),
    );
  }
}

class ChevronClipper extends CustomClipper<Path> {
  ChevronClipper(this.triangleHeight, this.edge);

  ///The height of triangle
  final double triangleHeight;

  ///The edge the chevron points
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.TOP:
        return _getTopPath(size);
      case Edge.RIGHT:
        return _getRightPath(size);
      case Edge.BOTTOM:
        return _getBottomPath(size);
      case Edge.LEFT:
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

/// Label Clipper

class LabelClipper extends CustomClipper<Path> {
  LabelClipper(this.triangleHeight, this.edge);

  ///The height of triangle that is going to be used to clip the [edge]
  final double triangleHeight;

  ///The edge that triangle clipping is going to be applied
  final Edge edge;

  @override
  Path getClip(Size size) {
    switch (edge) {
      case Edge.TOP:
        return _getTopPath(size);
      case Edge.RIGHT:
        return _getRightPath(size);
      case Edge.BOTTOM:
        return _getBottomPath(size);
      case Edge.LEFT:
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
