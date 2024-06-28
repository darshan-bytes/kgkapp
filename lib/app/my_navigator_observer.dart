import 'package:kgk/kgk.dart';

class MyNavigatorObserver extends NavigatorObserver {
  bool _keyboardVisible = false;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    hideKeyboard();
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    hideKeyboard();
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    hideKeyboard();
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    hideKeyboard();
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didStartUserGesture(route, previousRoute);
    hideKeyboard();
  }

  @override
  void didStopUserGesture() {
    super.didStopUserGesture();
    hideKeyboard();
  }

  void hideKeyboard() {
    _keyboardVisible = MediaQuery.of(getNavigatorKeyContext).viewInsets.bottom > 0;
    if (_keyboardVisible) {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    }
  }
}
