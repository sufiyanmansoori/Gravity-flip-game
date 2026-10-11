import '../entities/score_entity.dart';
import '../repositories/score_repository.dart';

class SaveScoreUseCase {
  const SaveScoreUseCase(this.repository);

  final ScoreRepository repository;

  Future<void> call(ScoreEntity score) => repository.saveScore(score);
}
