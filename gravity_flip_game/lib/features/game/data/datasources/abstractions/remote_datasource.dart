import '../../models/game_model.dart';
import '../../models/level_model.dart';

abstract class RemoteDataSource {
  Future<GameModel> fetchGame();
  Future<LevelModel> fetchLevel(int levelNumber);
  Future<void> syncGame(GameModel model);
}
