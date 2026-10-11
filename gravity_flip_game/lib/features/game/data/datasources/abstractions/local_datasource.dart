import '../../models/game_model.dart';
import '../../models/level_model.dart';
import '../../../domain/value_objects/game_state.dart';

abstract class LocalDataSource {
  Future<GameModel> loadGame();
  Future<LevelModel> loadLevel(int levelNumber);
  Future<void> saveGame(GameModel model);
  Future<void> saveLevel(LevelModel model);
  Future<GameState> getCurrentState();
  Future<void> saveCurrentState(GameState state);
}
