import 'package:kgk/kgk.dart';

/// It returns the context of the navigator key
///
/// Returns:
///   The current context of the navigator key.
BuildContext get getNavigatorKeyContext => NavigatorKey.navigatorKey.currentContext!;

///[printWrapped] this function is used to print only in debug mode
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}

///[Throttle] this function is used to throttle the api calls and avoid multiple api calls
class Throttle {
  final int milliseconds;
  bool _isThrottling = false;

  Throttle({required this.milliseconds});

  void run(VoidCallback action) {
    if (_isThrottling) return; // Ignore if currently throttling
    _isThrottling = true;
    action();
    Future.delayed(Duration(milliseconds: milliseconds), () {
      _isThrottling = false; // Reset after the delay
    });
  }
}

extension PreferredSizeExtensions on BuildContext {
  ///appbar height
  Size get appBarHeight => AppBar().preferredSize;
}
