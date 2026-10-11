import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';
import '../value_objects/game_state.dart';

class PauseGameUseCase {
  const PauseGameUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call() async {
    final game = await repository.loadGame();
    final paused = game.copyWith(state: GameState.paused);
    await repository.saveProgress(paused);
    return paused;
  }
}
