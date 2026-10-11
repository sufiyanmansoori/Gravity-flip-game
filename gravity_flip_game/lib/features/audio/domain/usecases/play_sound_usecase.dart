import '../repositories/audio_repository.dart';

class PlaySoundUseCase {
  const PlaySoundUseCase(this.repository);

  final AudioRepository repository;

  Future<void> call({required String assetPath}) async {
    await repository.playSfx(assetPath: assetPath);
  }
}
