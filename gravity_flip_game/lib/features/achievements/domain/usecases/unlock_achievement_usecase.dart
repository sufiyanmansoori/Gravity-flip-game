import '../entities/achievement_entity.dart';
import '../repositories/achievement_repository.dart';

class UnlockAchievementUseCase {
  const UnlockAchievementUseCase(this.repository);

  final AchievementRepository repository;

  Future<AchievementEntity> call(String achievementId) =>
      repository.unlockAchievement(achievementId);
}
