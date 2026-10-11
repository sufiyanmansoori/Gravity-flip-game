import '../repositories/achievement_repository.dart';

class GetAchievementProgressUseCase {
  const GetAchievementProgressUseCase(this.repository);

  final AchievementRepository repository;

  Future<int> call(String achievementId) =>
      repository.getAchievementProgress(achievementId);
}
