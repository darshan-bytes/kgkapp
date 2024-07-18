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
  final RefreshCallback? onRefresh;

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
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    Widget view = SingleChildScrollView(
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
    );

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _getRefreshIndicatorView(view: view),
    );
  }

  Widget _getRefreshIndicatorView({required Widget view}) {
    if (onRefresh != null) {
      return RefreshIndicator.adaptive(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        onRefresh: onRefresh!,
        child: view,
      );
    }
    return view;
  }
}
