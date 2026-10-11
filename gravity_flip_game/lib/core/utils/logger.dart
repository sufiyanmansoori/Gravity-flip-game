import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger();

  static const String tag = 'GravityFlip';

  static void debug(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      developer.log(message, name: tag, error: error, stackTrace: stackTrace);
      debugPrint('[${DateTime.now().toIso8601String()}] $tag: $message');
    }
  }

  static void info(String message) {
    if (kDebugMode) {
      debugPrint('[INFO] $tag: $message');
    }
  }

  static void warning(String message, {Object? error}) {
    if (kDebugMode) {
      debugPrint('[WARN] $tag: $message');
      if (error != null) {
        debugPrint('Cause: $error');
      }
    }
  }

  static void error(String message, {Object? error, StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('[ERROR] $tag: $message');
      if (error != null) {
        debugPrint('Error: $error');
      }
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }
}
