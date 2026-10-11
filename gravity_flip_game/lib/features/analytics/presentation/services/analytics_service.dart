import 'package:get_it/get_it.dart';

import '../../domain/repositories/analytics_repository.dart';
import '../../domain/usecases/log_event_usecase.dart';
import '../../domain/usecases/track_gameplay_usecase.dart';

class AnalyticsService {
  AnalyticsService({required AnalyticsRepository repository})
    : _repository = repository,
      _logEventUseCase = LogEventUseCase(repository),
      _trackGameplayUseCase = TrackGameplayUseCase(repository);

  final AnalyticsRepository _repository;
  final LogEventUseCase _logEventUseCase;
  final TrackGameplayUseCase _trackGameplayUseCase;

  Future<void> setUserId(String? userId) async {
    await _repository.setUserId(userId);
  }

  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? properties,
    String? userId,
  }) async {
    await _logEventUseCase(name, properties: properties, userId: userId);
  }

  Future<void> trackGameplaySession({
    required String levelId,
    required Duration duration,
    required int score,
    required bool cleared,
    Map<String, dynamic>? metadata,
  }) async {
    await _trackGameplayUseCase(
      levelId: levelId,
      duration: duration,
      score: score,
      cleared: cleared,
      metadata: metadata,
    );
  }

  Future<void> flush() async {
    await _repository.flush();
  }

  static AnalyticsService of() {
    final repo = GetIt.instance<AnalyticsRepository>();
    return AnalyticsService(repository: repo);
  }
}
