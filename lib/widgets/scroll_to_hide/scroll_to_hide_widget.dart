//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:kgk/kgk.dart';

/// ScrollToHide is a widget that makes any static located widget hideable while scrolling.
///
/// To use ScrollToHide, wrap your static located widget with [ScrollToHideWidget].
/// This will enable scroll-to-hide functionality for the widget.
///
/// Note: The scroll controller provided to [ScrollToHideWidget] must also be given to your scrollable widget,
/// such as [ListView], [GridView], etc.
///
/// For more information, refer to the [documentation](https://github.com/insolite-dev/ScrollToHide#readme).
class ScrollToHideWidget extends StatelessWidget {
  /// The child widget to which you want to add scroll-to-hide effect.
  ///
  /// This should be a static located widget, such as [BottomNavigationBar], [FloatingActionButton], [AppBar], etc.
  final Widget child;

  /// The main scroll controller that listens to user's scrolls.
  ///
  /// This scroll controller must also be provided to your scrollable widget.
  final ScrollController controller;

  /// Enable or disable opacity animation.
  ///
  /// Defaults to `true`.
  final bool enableOpacityAnimation;

  /// This parameter allows you to define a custom visibility behavior for the [child] widget
  /// based on scrolling actions. You can provide a function of type [ScrollToHideVisibility]
  /// to determine when and how the widget should be hidden or revealed during scrolling.
  ///
  /// Example usage:
  /// ```dart
  /// ScrollToHide(
  ///   child: MyWidget(),
  ///   controller: scrollController,
  ///   visibility: (position, currentVisibility) {
  ///     // Custom visibility logic here.
  ///     // Return the updated visibility value.
  ///   },
  /// )
  /// ```
  ///
  /// If not provided, the default visibility behavior will be used.
  final ScrollToHideVisibility? visibility;

  /// A factor that determines the speed at which the [child] widget's visibility changes
  /// when scrolling occurs.
  ///
  /// The `deltaFactor` value should be a double between 0.0 and 1.0, where:
  /// - 0.0 indicates that the [child] widget's visibility won't change when scrolling.
  /// - 1.0 indicates that the [child] widget's visibility will change rapidly when scrolling.
  ///
  /// A lower `deltaFactor` value results in a slower change in visibility, making the
  /// [child] widget's hiding/revealing behavior more gradual. Conversely, a higher value
  /// makes the change in visibility more immediate.
  ///
  /// The default value is 0.04, which provides a moderate speed of visibility change.
  final double deltaFactor;

  const ScrollToHideWidget({
    super.key,
    required this.child,
    required this.controller,
    this.enableOpacityAnimation = true,
    this.visibility,
    this.deltaFactor = 0.06,
  });

  @override
  Widget build(BuildContext context) {
    final scrollToHide = controller.scrollToHide(hashCode, visibility, deltaFactor);
    return ValueListenableBuilder<double>(
      valueListenable: scrollToHide.visibilityNotifier,
      builder: (_, factor, __) {
        return Align(
          heightFactor: factor,
          alignment: const Alignment(0, -1),
          child: enableOpacityAnimation ? Opacity(opacity: factor, child: child) : child,
        );
      },
    );
  }
}
