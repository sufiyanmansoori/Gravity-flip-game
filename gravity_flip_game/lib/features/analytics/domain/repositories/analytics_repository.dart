abstract class AnalyticsRepository {
  Future<void> setUserId(String? userId);

  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? properties,
    String? userId,
  });

  Future<void> trackGameplaySession({
    required String levelId,
    required Duration duration,
    required int score,
    required bool cleared,
    Map<String, dynamic>? metadata,
  });

  Future<void> flush();
}
