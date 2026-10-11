import '../../domain/entities/score_entity.dart';
import '../../domain/repositories/score_repository.dart';
import '../datasources/score_local_datasource.dart';
import '../datasources/score_remote_datasource.dart';
import '../models/score_model.dart';

class ScoreRepositoryImpl implements ScoreRepository {
  ScoreRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
  });

  final ScoreLocalDataSource _localDataSource;
  final ScoreRemoteDataSource _remoteDataSource;

  @override
  Future<void> saveScore(ScoreEntity score) async {
    final scores = await _localDataSource.loadScores();
    final model = ScoreModel.fromEntity(score);
    final list = [...scores, model.toJson()];
    await _localDataSource.saveScores(list);
  }

  @override
  Future<List<ScoreEntity>> getHighScores({String? levelId}) async {
    final scores = await _localDataSource.loadScores();
    final parsed = scores
        .map((entry) => ScoreModel.fromJson(Map<String, dynamic>.from(entry)))
        .where((score) => levelId == null || score.levelId == levelId)
        .toList();

    parsed.sort((a, b) => b.score.compareTo(a.score));
    return parsed.take(10).map((item) => item.toEntity()).toList();
  }

  @override
  Future<List<ScoreEntity>> getLeaderboard({
    String? levelId,
    int limit = 10,
  }) async {
    final remoteScores = await _remoteDataSource.fetchLeaderboard();
    final localScores = await _localDataSource.loadScores();
    final merged = [...remoteScores, ...localScores];

    final parsed = merged
        .map((entry) => ScoreModel.fromJson(Map<String, dynamic>.from(entry)))
        .where((score) => levelId == null || score.levelId == levelId)
        .toList();

    parsed.sort((a, b) => b.score.compareTo(a.score));
    return parsed.take(limit).map((item) => item.toEntity()).toList();
  }
}
