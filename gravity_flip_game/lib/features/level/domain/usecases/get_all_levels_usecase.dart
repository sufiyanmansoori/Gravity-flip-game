import '../entities/level_entity.dart';
import '../repositories/level_repository.dart';

class GetAllLevelsUseCase {
  const GetAllLevelsUseCase(this.repository);

  final LevelRepository repository;

  Future<List<LevelEntity>> call() => repository.getAllLevels();
}
