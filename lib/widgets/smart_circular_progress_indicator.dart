import 'package:kgk/kgk.dart';

class SmartCircularProgressIndicator extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const SmartCircularProgressIndicator({
    super.key,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = const CircularProgressIndicator();
    return Container(
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.all(16.w),
      child: child,
    );
  }
}
