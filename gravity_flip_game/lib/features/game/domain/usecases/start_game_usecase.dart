import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';
import '../value_objects/game_state.dart';

class StartGameUseCase {
  const StartGameUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call() async {
    final game = await repository.loadGame();
    final started = game.copyWith(state: GameState.playing);
    await repository.saveProgress(started);
    return started;
  }
}
