import '../entities/achievement_entity.dart';

abstract class AchievementRepository {
  Future<List<AchievementEntity>> getAchievements();
  Future<AchievementEntity?> getAchievementById(String achievementId);
  Future<int> getAchievementProgress(String achievementId);
  Future<AchievementEntity> unlockAchievement(String achievementId);
}
