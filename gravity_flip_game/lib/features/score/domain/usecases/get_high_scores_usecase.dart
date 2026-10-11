import '../entities/score_entity.dart';
import '../repositories/score_repository.dart';

class GetHighScoresUseCase {
  const GetHighScoresUseCase(this.repository);

  final ScoreRepository repository;

  Future<List<ScoreEntity>> call({String? levelId}) =>
      repository.getHighScores(levelId: levelId);
}
