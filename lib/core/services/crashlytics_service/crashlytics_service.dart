import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// A service interface for handling crash reporting and logging.
/// 
/// This abstract class defines the contract for crash reporting services,
/// allowing logging of messages, recording errors, and setting user identifiers.
abstract class CrashlyticsService {
  void log(String message);
  void recordError(dynamic exception, StackTrace? stack, {bool fatal = false});
  void setUserId(String userId);
}

class FirebaseCrashlyticsService implements CrashlyticsService {
  final FirebaseCrashlytics _crashlytics = FirebaseCrashlytics.instance;

  @override
  void log(String message) {
    _crashlytics.log(message);
  }

  @override
  void recordError(dynamic exception, StackTrace? stack, {bool fatal = false}) {
    _crashlytics.recordError(exception, stack, fatal: fatal);
  }

  @override
  void setUserId(String userId) {
    _crashlytics.setUserIdentifier(userId);
  }
}
