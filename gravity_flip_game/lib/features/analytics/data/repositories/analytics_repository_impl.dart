import '../../domain/repositories/analytics_repository.dart';
import '../datasources/analytics_local_datasource.dart';
import '../datasources/analytics_remote_datasource.dart';
import '../models/analytics_event_model.dart';

class AnalyticsRepositoryImpl implements AnalyticsRepository {
  AnalyticsRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
  });

  final AnalyticsLocalDataSource _localDataSource;
  final AnalyticsRemoteDataSource _remoteDataSource;

  String? _userId;

  @override
  Future<void> setUserId(String? userId) async {
    _userId = userId;
    await _localDataSource.setUserId(userId);
  }

  @override
  Future<void> logEvent(
    String name, {
    Map<String, dynamic>? properties,
    String? userId,
  }) async {
    final payload = AnalyticsEventModel(
      name: name,
      timestamp: DateTime.now(),
      userId: userId ?? _userId ?? _localDataSource.getUserId(),
      properties: {...?properties, 'source': 'gravity_flip_game'},
    );

    await _localDataSource.saveEvent(payload.toJson());
    await _remoteDataSource.logEvent(
      name,
      properties: payload.properties,
      userId: payload.userId,
    );
  }

  @override
  Future<void> trackGameplaySession({
    required String levelId,
    required Duration duration,
    required int score,
    required bool cleared,
    Map<String, dynamic>? metadata,
  }) async {
    final payload = {
      'levelId': levelId,
      'durationMs': duration.inMilliseconds,
      'score': score,
      'cleared': cleared,
      'metadata': metadata ?? const <String, dynamic>{},
      'userId': _userId ?? _localDataSource.getUserId(),
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    };

    await _localDataSource.saveEvent(payload);
    await _remoteDataSource.trackGameplaySession(
      levelId: levelId,
      duration: duration,
      score: score,
      cleared: cleared,
      metadata: metadata,
      userId: _userId ?? _localDataSource.getUserId(),
    );
  }

  @override
  Future<void> flush() async {
    final pending = await _localDataSource.loadPendingEvents();
    if (pending.isEmpty) {
      return;
    }

    for (final event in pending) {
      final model = AnalyticsEventModel.fromJson(event);
      await _remoteDataSource.logEvent(
        model.name,
        properties: model.properties,
        userId: model.userId,
      );
    }

    await _localDataSource.clearPendingEvents();
  }
}
