import '../entities/score_entity.dart';
import '../repositories/score_repository.dart';

class GetLeaderboardUseCase {
  const GetLeaderboardUseCase(this.repository);

  final ScoreRepository repository;

  Future<List<ScoreEntity>> call({String? levelId, int limit = 10}) =>
      repository.getLeaderboard(levelId: levelId, limit: limit);
}
