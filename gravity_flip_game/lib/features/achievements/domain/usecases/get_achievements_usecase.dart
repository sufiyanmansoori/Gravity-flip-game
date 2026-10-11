import '../entities/achievement_entity.dart';
import '../repositories/achievement_repository.dart';

class GetAchievementsUseCase {
  const GetAchievementsUseCase(this.repository);

  final AchievementRepository repository;

  Future<List<AchievementEntity>> call() => repository.getAchievements();
}
