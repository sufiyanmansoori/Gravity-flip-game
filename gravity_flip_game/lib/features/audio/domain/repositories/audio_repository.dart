import '../entities/audio_settings_entity.dart';

abstract class AudioRepository {
  Future<AudioSettingsEntity> getSettings();
  Future<void> saveSettings(AudioSettingsEntity settings);

  Future<void> playBackgroundMusic({
    required String assetPath,
    bool loop = true,
  });

  Future<void> playSfx({required String assetPath});

  Future<void> stopBackgroundMusic();
  Future<void> stopAll();

  Future<void> setMusicVolume(double volume);
  Future<void> setSfxVolume(double volume);

  Future<void> setEnabled({
    bool? musicEnabled,
    bool? sfxEnabled,
    bool? masterEnabled,
  });
}
