import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  WorkManagerService();

  Future<void> initialize() async {
    await Workmanager().initialize(callbackDispatcher);
  }

  Future<void> registerOneOffTask({
    required String uniqueName,
    required String taskName,
    required Duration delay,
  }) async {
    await Workmanager().registerOneOffTask(
      uniqueName,
      taskName,
      initialDelay: delay,
    );
  }

  Future<void> registerPeriodicTask({
    required String uniqueName,
    required String taskName,
    required Duration frequency,
  }) async {
    await Workmanager().registerPeriodicTask(
      uniqueName,
      taskName,
      frequency: frequency,
      constraints: Constraints(networkType: NetworkType.connected),
    );
  }

  Future<void> cancelByUniqueName(String uniqueName) async {
    await Workmanager().cancelByUniqueName(uniqueName);
  }
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    // Replace with real background task logic for sync or cleanup.
    return Future.value(true);
  });
}
