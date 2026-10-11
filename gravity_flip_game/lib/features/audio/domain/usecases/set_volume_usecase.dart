import '../repositories/audio_repository.dart';

class SetVolumeUseCase {
  const SetVolumeUseCase(this.repository);

  final AudioRepository repository;

  Future<void> call({
    double? musicVolume,
    double? sfxVolume,
    bool? musicEnabled,
    bool? sfxEnabled,
    bool? masterEnabled,
  }) async {
    if (musicVolume != null) {
      await repository.setMusicVolume(musicVolume);
    }

    if (sfxVolume != null) {
      await repository.setSfxVolume(sfxVolume);
    }

    if (musicEnabled != null || sfxEnabled != null || masterEnabled != null) {
      await repository.setEnabled(
        musicEnabled: musicEnabled,
        sfxEnabled: sfxEnabled,
        masterEnabled: masterEnabled,
      );
    }
  }
}
