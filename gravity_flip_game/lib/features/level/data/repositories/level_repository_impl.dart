import '../../domain/entities/level_entity.dart';
import '../../domain/repositories/level_repository.dart';
import '../datasources/level_local_datasource.dart';
import '../datasources/level_remote_datasource.dart';
import '../mappers/level_mapper.dart';

class LevelRepositoryImpl implements LevelRepository {
  LevelRepositoryImpl({
    required this._localDataSource,
    required this._remoteDataSource,
  });

  final LevelLocalDataSource _localDataSource;
  final LevelRemoteDataSource _remoteDataSource;

  @override
  Future<List<LevelEntity>> getAllLevels() async {
    final remoteLevels = await _remoteDataSource.fetchLevels();
    final cachedLevels = await _localDataSource.getAllLevels();
    final merged = remoteLevels.isNotEmpty ? remoteLevels : cachedLevels;

    await _localDataSource.saveLevels(merged);
    return merged.map(LevelMapper.fromModel).toList();
  }

  @override
  Future<LevelEntity> getLevel(String id) async {
    final model = await _localDataSource.getLevel(id);
    return LevelMapper.fromModel(model);
  }

  @override
  Future<LevelEntity> unlockLevel(String id) async {
    final levels = await _localDataSource.getAllLevels();
    final model = levels.firstWhere(
      (level) => level.id == id,
      orElse: () => levels.first,
    );

    final updated = model.copyWith(isUnlocked: true, stars: model.stars);

    await _localDataSource.saveLevel(updated);
    return LevelMapper.fromModel(updated);
  }

  @override
  Future<LevelEntity> updateProgress({
    required String id,
    required int bestScore,
    required int stars,
  }) async {
    final levels = await _localDataSource.getAllLevels();
    final current = levels.firstWhere(
      (level) => level.id == id,
      orElse: () => levels.first,
    );

    final updated = current.copyWith(
      bestScore: bestScore,
      stars: stars,
      isUnlocked: true,
    );

    await _localDataSource.saveLevel(updated);
    return LevelMapper.fromModel(updated);
  }

  @override
  Future<int> getLevelProgress(String id) async {
    final model = await _localDataSource.getLevel(id);
    return model.stars;
  }
}
