class AnalyticsRemoteDataSource {
  const AnalyticsRemoteDataSource();

  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? properties,
    String? userId,
  }) async {
    // Placeholder for future backend or vendor analytics integration.
    // Keeping the call as a non-blocking no-op enables offline-first analytics.
    // In production, this could be connected to Firebase, Mixpanel, Amplitude,
    // or a custom analytics API with proper batching and retry logic.
    return;
  }

  Future<void> trackGameplaySession({
    required String levelId,
    required Duration duration,
    required int score,
    required bool cleared,
    Map<String, dynamic>? metadata,
    String? userId,
  }) async {
    // Same placeholder behavior for gameplay telemetry.
    return;
  }
}
