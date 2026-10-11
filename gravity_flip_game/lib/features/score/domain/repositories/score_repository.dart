import '../entities/score_entity.dart';

abstract class ScoreRepository {
  Future<void> saveScore(ScoreEntity score);
  Future<List<ScoreEntity>> getHighScores({String? levelId});
  Future<List<ScoreEntity>> getLeaderboard({String? levelId, int limit = 10});
}
