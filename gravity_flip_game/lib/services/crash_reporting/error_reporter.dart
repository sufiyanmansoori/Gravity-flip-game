import 'dart:async';

class ErrorReporter {
  ErrorReporter._();

  static final ErrorReporter _instance = ErrorReporter._();

  factory ErrorReporter() => _instance;

  final StreamController<ReportedError> _controller =
      StreamController<ReportedError>.broadcast();

  Stream<ReportedError> get errors => _controller.stream;

  void report(
    Object error, {
    StackTrace? stackTrace,
    String? tag,
    Map<String, dynamic>? metadata,
  }) {
    _controller.add(
      ReportedError(
        error: error,
        stackTrace: stackTrace ?? StackTrace.current,
        tag: tag ?? 'unknown',
        metadata: metadata ?? const <String, dynamic>{},
        timestamp: DateTime.now(),
      ),
    );
  }

  Future<void> dispose() async {
    await _controller.close();
  }
}

class ReportedError {
  const ReportedError({
    required this.error,
    required this.stackTrace,
    required this.tag,
    required this.metadata,
    required this.timestamp,
  });

  final Object error;
  final StackTrace stackTrace;
  final String tag;
  final Map<String, dynamic> metadata;
  final DateTime timestamp;

  @override
  String toString() {
    return 'ReportedError(tag: $tag, error: $error, time: $timestamp)';
  }
}
