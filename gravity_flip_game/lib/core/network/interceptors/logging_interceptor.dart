import 'package:flutter/foundation.dart';

class LoggingInterceptor {
  const LoggingInterceptor();

  void onRequest(
    String method,
    Uri uri,
    Map<String, String> headers,
    Object? body,
  ) {
    if (kDebugMode) {
      debugPrint('[$method] $uri');
      debugPrint('Headers: $headers');
      if (body != null) {
        debugPrint('Body: $body');
      }
    }
  }

  void onResponse(int statusCode, dynamic data) {
    if (kDebugMode) {
      debugPrint('Response [$statusCode]: $data');
    }
  }

  void onError(Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('Request Error: $error');
      debugPrintStack(stackTrace: stackTrace);
    }
  }
}
