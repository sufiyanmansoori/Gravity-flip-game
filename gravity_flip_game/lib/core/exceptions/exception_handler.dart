import 'package:flutter/foundation.dart';

import 'app_exceptions.dart';
import 'game_exceptions.dart';

class ExceptionHandler {
  const ExceptionHandler._();

  static void report(Object error, {StackTrace? stackTrace}) {
    if (kDebugMode) {
      debugPrint('ExceptionHandler: $error');
      if (stackTrace != null) {
        debugPrintStack(stackTrace: stackTrace);
      }
    }
  }

  static String getFriendlyMessage(Object error) {
    if (error is AppException) {
      return error.message;
    }
    if (error is GameException) {
      return error.message;
    }
    if (error is FormatException) {
      return 'Data format is invalid.';
    }
    return 'Something went wrong. Please try again.';
  }
}
