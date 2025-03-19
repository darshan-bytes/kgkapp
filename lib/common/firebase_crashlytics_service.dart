import 'package:kgk/kgk.dart';

class AppCrashlytics {
  AppCrashlytics._();

  static final AppCrashlytics instance = AppCrashlytics._();

  bool _initialized = false;

  /// Initializes Firebase Crashlytics.
  Future<void> initialize() async {
    if (_initialized) {
      debugPrint('[Crashlytics] Already initialized.');
      return;
    }
    _initialized = true;

    try {
      if (isCrashlyticsEnabled) {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
        debugPrint('[Crashlytics] Enabled in Production.');
      } else {
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
        debugPrint('[Crashlytics] Disabled in Debug/Profile.');
      }

      FlutterError.onError = (errorDetails) async {
        if (isCrashlyticsEnabled) {
          await _handleFlutterError(errorDetails, fatal: true);
        }
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        if (isCrashlyticsEnabled) {
          _handlePlatformError(error, stack, fatal: true);
        }
        return true;
      };

      logAppMode();
    } catch (e, stackTrace) {
      debugPrint('[Crashlytics] Initialization failed: $e');
      if (isCrashlyticsEnabled) {
        FirebaseCrashlytics.instance.recordError(e, stackTrace);
      }
    }
  }

  /// Check whether Crashlytics is enabled
  bool get isCrashlyticsEnabled => kReleaseMode;

  // bool get isCrashlyticsEnabled => true;

  /// Logs the current app mode (Debug, Profile, or Release)
  void logAppMode() {
    if (kDebugMode) {
      debugPrint('[App Mode] Running in Debug mode');
    } else if (kProfileMode) {
      debugPrint('[App Mode] Running in Profile mode');
    } else if (kReleaseMode) {
      debugPrint('[App Mode] Running in Release mode');
    }
  }

  /// Force crash for testing purposes.
  Future<void> forceCrash() async {
    debugPrint('[Crashlytics] Force crash triggered.');
    throw StateError('This is a test crash');
  }

  /// Sets user identifier for tracking crash reports.
  Future<void> setUserId(String userId) async {
    try {
      await FirebaseCrashlytics.instance.setUserIdentifier(userId);
      debugPrint('[Crashlytics] User ID set: $userId');
    } catch (e) {
      debugPrint('[Crashlytics] Failed to set User ID: $e');
    }
  }

  /// Records an error manually.
  Future<void> recordError(Object error, StackTrace stack, {bool fatal = false}) async {
    try {
      await FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
      debugPrint('[Crashlytics] Error recorded: $error, Fatal: $fatal');
    } catch (e) {
      debugPrint('[Crashlytics] Failed to record error: $e');
    }
  }

  /// Adds custom logs to track app behavior.
  Future<void> logMessage(String message) async {
    try {
      await FirebaseCrashlytics.instance.log(message);
      debugPrint('[Crashlytics] Log added: $message');
    } catch (e) {
      debugPrint('[Crashlytics] Failed to log message: $e');
    }
  }

  /// Handles Flutter errors.
  Future<void> _handleFlutterError(FlutterErrorDetails errorDetails, {required bool fatal}) async {
    if (isCrashlyticsEnabled) {
      try {
        if (fatal) {
          await FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
        } else {
          await FirebaseCrashlytics.instance.recordFlutterError(errorDetails);
        }
        debugPrint('[Crashlytics] Flutter error handled: ${errorDetails.exceptionAsString()}');
      } catch (e) {
        debugPrint('[Crashlytics] Failed to handle Flutter error: $e');
      }
    }
  }

  /// Handles platform-specific errors.
  Future<void> _handlePlatformError(Object error, StackTrace stack, {required bool fatal}) async {
    if (isCrashlyticsEnabled) {
      try {
        await FirebaseCrashlytics.instance.recordError(error, stack, fatal: fatal);
        debugPrint('[Crashlytics] Platform error handled: $error');
      } catch (e) {
        debugPrint('[Crashlytics] Failed to handle platform error: $e');
      }
    }
  }
}
