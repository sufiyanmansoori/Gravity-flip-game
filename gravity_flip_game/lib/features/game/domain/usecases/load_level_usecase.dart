import '../entities/game_entity.dart';
import '../repositories/game_repository.dart';

class LoadLevelUseCase {
  const LoadLevelUseCase(this.repository);

  final GameRepository repository;

  Future<GameEntity> call(int levelNumber) async {
    final game = await repository.loadGame();
    final levels = await repository.getLevels();

    final chosenLevel = levels.firstWhere(
      (level) => level.number == levelNumber,
      orElse: () => levels.first,
    );

    final updated = game.copyWith(
      currentLevel: chosenLevel.number,
      state: game.state,
    );

    await repository.saveProgress(updated);
    return updated;
  }
}
