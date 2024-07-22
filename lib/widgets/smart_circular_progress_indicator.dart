import 'package:kgk/kgk.dart';

class SmartCircularProgressIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final double? size;

  const SmartCircularProgressIndicator({
    super.key,
    this.padding,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = const CircularProgressIndicator();
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      padding: padding ?? EdgeInsets.all(16.w),
      child: child,
    );
  }
}
