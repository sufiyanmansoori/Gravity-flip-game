import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';

class CalculateScoreUseCase {
  const CalculateScoreUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call({
    required int collected,
    required int timeBonus,
    required int levelBonus,
  }) async {
    final game = await repository.loadGame();
    final score = game.score + collected * 10 + timeBonus + levelBonus;

    final updated = game.copyWith(score: score);
    await repository.saveProgress(updated);
    return updated;
  }
}
