import '../repositories/analytics_repository.dart';

class TrackGameplayUseCase {
  const TrackGameplayUseCase(this.repository);

  final AnalyticsRepository repository;

  Future<void> call({
    required String levelId,
    required Duration duration,
    required int score,
    required bool cleared,
    Map<String, dynamic>? metadata,
  }) async {
    await repository.trackGameplaySession(
      levelId: levelId,
      duration: duration,
      score: score,
      cleared: cleared,
      metadata: metadata,
    );
  }
}
