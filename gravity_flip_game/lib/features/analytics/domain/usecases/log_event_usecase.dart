import '../repositories/analytics_repository.dart';

class LogEventUseCase {
  const LogEventUseCase(this.repository);

  final AnalyticsRepository repository;

  Future<void> call(
    String name, {
    Map<String, dynamic>? properties,
    String? userId,
  }) async {
    await repository.logEvent(name, properties: properties, userId: userId);
  }
}
