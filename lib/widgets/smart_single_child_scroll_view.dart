import 'package:kgk/kgk.dart';

class SmartSingleChildScrollView extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final Axis? scrollDirection;
  final ScrollPhysics? physics;
  final bool reverse;
  final EdgeInsetsGeometry? padding;
  final bool? primary;
  final DragStartBehavior dragStartBehavior;
  final Clip clipBehavior;
  final String? restorationId;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;

  const SmartSingleChildScrollView({
    super.key,
    required this.child,
    this.controller,
    this.scrollDirection,
    this.physics,
    this.reverse = false,
    this.padding,
    this.primary,
    this.dragStartBehavior = DragStartBehavior.start,
    this.clipBehavior = Clip.hardEdge,
    this.restorationId,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.manual,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        controller: controller,
        scrollDirection: scrollDirection ?? Axis.vertical,
        physics: physics,
        reverse: reverse,
        padding: padding,
        primary: primary,
        dragStartBehavior: dragStartBehavior,
        clipBehavior: clipBehavior,
        restorationId: restorationId,
        keyboardDismissBehavior: keyboardDismissBehavior,
        child: child,
      ),
    );
  }
}
