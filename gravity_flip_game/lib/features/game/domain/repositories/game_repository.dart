import '../entities/game_entity.dart';
import '../entities/level_entity.dart';
import '../value_objects/game_state.dart';

abstract class GameRepository {
  Future<GameEntity> loadGame();
  Future<LevelEntity> loadLevel(int levelNumber);
  Future<List<LevelEntity>> getLevels();
  Future<void> saveProgress(GameEntity game);
  Future<void> saveLevelState(LevelEntity level);
  Future<GameState> getCurrentState();
  Future<void> updateCurrentState(GameState state);
  Stream<GameEntity> watchGame();
  Stream<LevelEntity> watchLevel(int levelNumber);
}
