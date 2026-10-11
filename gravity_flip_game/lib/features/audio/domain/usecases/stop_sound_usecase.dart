import '../repositories/audio_repository.dart';

class StopSoundUseCase {
  const StopSoundUseCase(this.repository);

  final AudioRepository repository;

  Future<void> call() async {
    await repository.stopAll();
  }
}
