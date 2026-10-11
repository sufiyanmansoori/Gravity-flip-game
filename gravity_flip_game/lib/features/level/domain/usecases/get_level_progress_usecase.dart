import '../repositories/level_repository.dart';

class GetLevelProgressUseCase {
  const GetLevelProgressUseCase(this.repository);

  final LevelRepository repository;

  Future<int> call(String id) => repository.getLevelProgress(id);
}
