import 'package:kgk/kgk.dart';

/// Used by [Responsive] of app and web
class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;

  const Responsive({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  /// This size work fine on my design, maybe you need some customization depends on your design

  /// This isMobile, isMobileTablet, isDesktop help us later
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.shortestSide < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.shortestSide < 1100 && MediaQuery.of(context).size.shortestSide >= 650;

  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.shortestSide >= 1100;

  @override
  Widget build(BuildContext context) {
    return isMobile(context) ? mobile : tablet;
  }
}
