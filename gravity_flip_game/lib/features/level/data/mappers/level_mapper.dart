import '../../domain/entities/level_entity.dart';
import '../models/level_data_model.dart';

class LevelMapper {
  const LevelMapper._();

  static LevelEntity fromModel(LevelDataModel model) => model.toEntity();

  static LevelDataModel toModel(LevelEntity entity) =>
      LevelDataModel.fromEntity(entity);
}
