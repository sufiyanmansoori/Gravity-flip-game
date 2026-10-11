import '../../domain/entities/level_entity.dart';
import '../models/level_model.dart';

class LevelMapper {
  const LevelMapper._();

  static LevelEntity fromModel(LevelModel model) {
    return LevelEntity(
      number: model.number,
      name: model.name,
      difficulty: model.difficulty,
      speed: model.speed,
      gravity: model.gravity,
      obstacles: model.obstacles,
      collectibles: model.collectibles,
      baseScore: model.baseScore,
    );
  }

  static LevelModel toModel(LevelEntity entity) {
    return LevelModel(
      number: entity.number,
      name: entity.name,
      difficulty: entity.difficulty,
      speed: entity.speed,
      gravity: entity.gravity,
      obstacles: entity.obstacles,
      collectibles: entity.collectibles,
      baseScore: entity.baseScore,
    );
  }
}
