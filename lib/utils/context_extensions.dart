import 'package:kgk/kgk.dart';

extension ContextSizeExtension on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;
}
