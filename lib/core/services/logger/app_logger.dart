import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// A mixin that provides logging capabilities for classes.
///
/// This mixin allows classes to easily access logging functionality
/// by providing a convenient [log] getter and a static method for
/// creating named loggers.
mixin AppLogger {
  Logger get log => Logger('$runtimeType');
  /// Creates a static logger with the given logger name.
  ///
  /// This method allows creating a named logger without requiring an instance
  /// of a class that uses the [AppLogger] mixin.
  ///
  /// - [loggerName] The name to assign to the logger.
  /// - Returns a [Logger] instance with the specified name.
  static Logger staticLog(String loggerName) => Logger(loggerName);
}

void initializeLogger({String? prefix}) {
  Logger.root.level = Level.ALL;

  const separator = ' | ';
  const horizontalSeparator = '--------------------------------';

  Logger.root.onRecord.listen((rec) {
    final content = [
      if (prefix != null) ...[prefix, separator],
      rec.level.name.padRight(7),
      separator,
      rec.loggerName.padRight(22),
      separator,
      rec.message,
    ];

    debugPrint(content.join());

    if (rec.error != null) {
      debugPrint(horizontalSeparator);
      debugPrint('ERROR');

      if (rec.stackTrace != null) {
        debugPrint('STACK TRACE');
        rec.stackTrace.toString().trim().split('\n').forEach(debugPrint);
        debugPrint(horizontalSeparator);
      }
    }
  });
}
