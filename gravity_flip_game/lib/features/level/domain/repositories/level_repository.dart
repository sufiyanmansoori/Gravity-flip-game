import '../entities/level_entity.dart';

abstract class LevelRepository {
  Future<List<LevelEntity>> getAllLevels();
  Future<LevelEntity> getLevel(String id);
  Future<LevelEntity> unlockLevel(String id);
  Future<LevelEntity> updateProgress({
    required String id,
    required int bestScore,
    required int stars,
  });
  Future<int> getLevelProgress(String id);
}
