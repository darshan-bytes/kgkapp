import 'package:kgk/kgk.dart';

class Utils {
  Utils._();

  /// Show common snack bar messages
  static void showMessage(String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 2),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.blue,
      margin: const EdgeInsets.all(10),
      borderRadius: const BorderRadius.all(Radius.circular(10)),
    ).show(NavigatorKey.navigatorKey.currentContext!);
  }
}
