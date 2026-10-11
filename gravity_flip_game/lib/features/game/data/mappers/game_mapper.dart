import '../../domain/entities/game_entity.dart';
import '../models/game_model.dart';

class GameMapper {
  const GameMapper._();

  static GameEntity fromModel(GameModel model) {
    return GameEntity(
      id: model.id,
      score: model.score,
      bestScore: model.bestScore,
      lives: model.lives,
      currentLevel: model.currentLevel,
      state: model.state,
    );
  }

  static GameModel toModel(GameEntity entity) {
    return GameModel(
      id: entity.id,
      score: entity.score,
      bestScore: entity.bestScore,
      lives: entity.lives,
      currentLevel: entity.currentLevel,
      state: entity.state,
    );
  }
}
