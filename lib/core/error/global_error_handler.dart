import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:ricknotmorty/core/services/logger/app_logger.dart';

/// A global error handler that manages application-wide error handling and logging.
///
/// This class wraps the application's main entry point with a zoned error handler
/// to intercept and log unhandled errors while preventing the app from crashing.
///
/// Uses [runZonedGuarded] to catch and process errors, with optional logging
/// and potential integration with crash reporting services.
class GlobalErrorHandler with AppLogger {
  GlobalErrorHandler({required FutureOr<Widget> Function() builder}) {
    runZonedGuarded(() async {
      final child = await builder();
      runApp(child);
    }, _handleError);
  }

  Future<void> _handleError(Object error, StackTrace stackTrace) async {
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
    if (error is! StateError) {
      log.severe('Handled error', error, stackTrace);
    }
  }
}
