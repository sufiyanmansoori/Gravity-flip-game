import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';
import '../value_objects/game_state.dart';

class ResumeGameUseCase {
  const ResumeGameUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call() async {
    final game = await repository.loadGame();
    final resumed = game.copyWith(state: GameState.playing);
    await repository.saveProgress(resumed);
    return resumed;
  }
}
