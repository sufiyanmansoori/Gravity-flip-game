import 'dart:async';

abstract class BackgroundService {
  Future<void> initialize();
  Future<void> schedulePeriodic({
    required Duration interval,
    required String taskName,
    Map<String, dynamic>? payload,
  });
  Future<void> cancel({required String taskName});
  Future<void> runOneTime({
    required String taskName,
    required Duration delay,
    Map<String, dynamic>? payload,
  });
}

class DefaultBackgroundService implements BackgroundService {
  DefaultBackgroundService();

  final Map<String, Timer> _timers = <String, Timer>{};

  @override
  Future<void> initialize() async {
    // Reserved for platform-specific initialization.
  }

  @override
  Future<void> schedulePeriodic({
    required Duration interval,
    required String taskName,
    Map<String, dynamic>? payload,
  }) async {
    _timers[taskName]?.cancel();
    _timers[taskName] = Timer.periodic(interval, (timer) {
      // Replace with real task logic when the project needs long-running processing.
      debugLog(taskName, payload);
    });
  }

  @override
  Future<void> cancel({required String taskName}) async {
    _timers[taskName]?.cancel();
    _timers.remove(taskName);
  }

  @override
  Future<void> runOneTime({
    required String taskName,
    required Duration delay,
    Map<String, dynamic>? payload,
  }) async {
    Timer(delay, () {
      debugLog(taskName, payload);
    });
  }

  void debugLog(String taskName, Map<String, dynamic>? payload) {
    // Intentionally left for extension points.
  }
}
