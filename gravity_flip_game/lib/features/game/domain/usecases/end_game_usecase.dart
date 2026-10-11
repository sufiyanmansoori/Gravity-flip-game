import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';
import '../value_objects/game_state.dart';

class EndGameUseCase {
  const EndGameUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call({int? finalScore}) async {
    final game = await repository.loadGame();
    final ended = game.copyWith(
      score: finalScore ?? game.score,
      state: GameState.gameOver,
    );
    await repository.saveProgress(ended);
    return ended;
  }
}
