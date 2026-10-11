import '../entities/level_entity.dart';
import '../repositories/level_repository.dart';

class GetLevelUseCase {
  const GetLevelUseCase(this.repository);

  final LevelRepository repository;

  Future<LevelEntity> call(String id) => repository.getLevel(id);
}
