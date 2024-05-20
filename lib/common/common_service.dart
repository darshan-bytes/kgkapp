import 'package:kgk/kgk.dart';

/// It returns the context of the navigator key
///
/// Returns:
///   The current context of the navigator key.
BuildContext get getNavigatorKeyContext => NavigatorKey.navigatorKey.currentContext!;
