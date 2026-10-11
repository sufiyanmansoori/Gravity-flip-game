import 'dart:async';

class CrashAnalytics {
  CrashAnalytics._();

  static final CrashAnalytics _instance = CrashAnalytics._();

  factory CrashAnalytics() => _instance;

  final StreamController<Map<String, dynamic>> _events =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get events => _events.stream;

  void recordException(
    Object error, {
    StackTrace? stackTrace,
    String? context,
  }) {
    _events.add({
      'type': 'exception',
      'error': error.toString(),
      'context': context ?? 'unknown',
      'stackTrace': stackTrace?.toString() ?? 'none',
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  void recordEvent(String name, {Map<String, dynamic>? attributes}) {
    _events.add({
      'type': 'event',
      'name': name,
      'attributes': attributes ?? const <String, dynamic>{},
      'timestamp': DateTime.now().toIso8601String(),
    });
  }

  Future<void> dispose() async {
    await _events.close();
  }
}
