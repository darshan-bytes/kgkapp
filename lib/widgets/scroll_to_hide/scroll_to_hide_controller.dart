//
// Copyright 2021-2022 present Insolite. All rights reserved.
// Use of this source code is governed by Apache 2.0 license
// that can be found in the LICENSE file.
//

import 'package:kgk/kgk.dart';

/// Simple extension to generate [ScrollToHideController] from scroll controller instance directly.
extension ScrollToHideControllerExt on ScrollController {
  static final scrollToHideControllers = <int, ScrollToHideController>{};

  /// Creates new [ScrollToHideController] or returns already created existing [ScrollToHideController]
  /// from [scrollToHideControllers].
  ///
  /// Identifys each controller via passed [hashCode] property.
  ScrollToHideController scrollToHide(int hashCode, ScrollToHideVisibility? visibility, double deltaFactor) {
    // If the same instance was created before, we should keep using it.
    if (scrollToHideControllers.containsKey(hashCode)) {
      return scrollToHideControllers[hashCode]!;
    }

    return scrollToHideControllers[hashCode] = ScrollToHideController(
      scrollController: this,
      scrollToHideVisibility: visibility,
      deltaFactor: deltaFactor,
    );
  }
}

/// Defines a function signature for determining the visibility of a scrollable element
/// that can be hidden or revealed based on scrolling behavior.
///
/// The `HidableVisibility` function takes four parameters:
/// - `position`: A [ScrollPosition] object representing the current scroll position.
/// - `currentVisibility`: A [double] representing the current visibility status, typically
///   a value between 0.0 (completely hidden) and 1.0 (completely visible).
///
/// The function should return a [double] value representing the updated visibility status
/// of the scrollable element, typically also in the range of 0.0 to 1.0.
///
/// Example usage:
/// ```dart
/// HidableVisibility myVisibilityFunction(ScrollPosition position, double currentVisibility) {
///   // Your visibility logic here.
///   // Return the updated visibility value.
/// }
/// ```
///
/// This typedef is often used in conjunction with a [ScrollToHideController] to define custom
/// visibility behavior for scrollable elements.
typedef ScrollToHideVisibility = double Function(
  ScrollPosition position,
  double currentVisibility,
);

/// A custom wrapper for scroll controller.
///
/// Implements the main listener mehtod for [ScrollController].
/// And the [sizeNotifier] for providing/updating the hideable status.
class ScrollToHideController {
  ScrollController scrollController;
  ScrollToHideVisibility? scrollToHideVisibility;
  double deltaFactor;

  ScrollToHideController({
    required this.scrollController,
    this.scrollToHideVisibility,
    required this.deltaFactor,
  }) {
    scrollController.addListener(() => updateVisibility(scrollToHideVisibility, deltaFactor));
  }

  final visibilityNotifier = ValueNotifier<double>(1.0);

  Timer? _showTimer;

  void updateVisibility(ScrollToHideVisibility? visibility, double deltaFactor) {
    final position = scrollController.position;

    if (visibility != null) {
      visibilityNotifier.value = visibility(
        position,
        visibilityNotifier.value,
      );
      return;
    }

    _showTimer?.cancel();
    if (position.userScrollDirection == ScrollDirection.reverse) {
      visibilityNotifier.value = (visibilityNotifier.value - deltaFactor).clamp(0, 1);
    } else if (position.userScrollDirection == ScrollDirection.forward) {
      visibilityNotifier.value = (visibilityNotifier.value + deltaFactor).clamp(0, 1);
    }

    _showTimer = Timer(const Duration(milliseconds: 500), () async {
      visibilityNotifier.value = 0.0;
      while (visibilityNotifier.value < 1.0) {
        await Future.delayed(const Duration(milliseconds: 2));
        visibilityNotifier.value = (visibilityNotifier.value + deltaFactor).clamp(0, 1);
      }
    });

    // Check if at the top of the scroll view
    if (position.pixels == 0) {
      _showTimer?.cancel();
      visibilityNotifier.value = 1.0;
    }
  }

  void close() {
    _showTimer?.cancel();
    visibilityNotifier.dispose();
  }
}
