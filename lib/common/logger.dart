import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

enum Logger {
  debug,
  error,
  firebase;

  static void logError(
    String message, {
    required Object error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    dev.log(
      message,
      name: 'LOG-ERROR',
      error: error,
      stackTrace: stackTrace,
    );
  }

  void log(String message) {
    if (!kDebugMode) return;

    dev.log(
      message,
      name: 'LOG-${name.toUpperCase()}',
    );
  }
}
