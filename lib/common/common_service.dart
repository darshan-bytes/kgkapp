import 'package:kgk/kgk.dart';

/// It returns the context of the navigator key
///
/// Returns:
///   The current context of the navigator key.
BuildContext get getNavigatorKeyContext => NavigatorKey.navigatorKey.currentContext!;

///[printWrapped] this function is used to print only in debug model
void printWrapped(String text) {
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
}