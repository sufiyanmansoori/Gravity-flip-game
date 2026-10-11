import '../../domain/entities/achievement_entity.dart';
import '../../domain/repositories/achievement_repository.dart';
import '../datasources/achievement_local_datasource.dart';
import '../models/achievement_model.dart';

class AchievementRepositoryImpl implements AchievementRepository {
  AchievementRepositoryImpl({required this._localDataSource});

  final AchievementLocalDataSource _localDataSource;

  @override
  Future<List<AchievementEntity>> getAchievements() async {
    final raw = await _localDataSource.loadAchievements();
    final items = raw
        .map(
          (entry) =>
              AchievementModel.fromJson(Map<String, dynamic>.from(entry)),
        )
        .toList();

    items.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return items.map((item) => item.toEntity()).toList();
  }

  @override
  Future<AchievementEntity?> getAchievementById(String achievementId) async {
    final items = await getAchievements();
    return items.where((item) => item.id == achievementId).firstOrNull;
  }

  @override
  Future<int> getAchievementProgress(String achievementId) async {
    final item = await getAchievementById(achievementId);
    if (item == null) return 0;
    return item.progress;
  }

  @override
  Future<AchievementEntity> unlockAchievement(String achievementId) async {
    final achievements = await _localDataSource.loadAchievements();
    final updated = achievements.map((entry) {
      final model = AchievementModel.fromJson(Map<String, dynamic>.from(entry));
      if (model.id != achievementId) {
        return entry;
      }

      final unlocked = model.copyWith(
        progress: model.target,
        isUnlocked: true,
        unlockedAt: DateTime.now(),
      );

      return unlocked.toJson();
    }).toList();

    await _localDataSource.saveAchievements(updated);

    final selected = AchievementModel.fromJson(
      Map<String, dynamic>.from(
        updated.firstWhere(
          (entry) => Map<String, dynamic>.from(entry)['id'] == achievementId,
        ),
      ),
    );

    return selected.toEntity();
  }
}
