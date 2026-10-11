import '../entities/level_entity.dart';
import '../repositories/level_repository.dart';

class UnlockLevelUseCase {
  const UnlockLevelUseCase(this.repository);

  final LevelRepository repository;

  Future<LevelEntity> call(String id) => repository.unlockLevel(id);
}
