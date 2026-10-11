import 'package:audioplayers/audioplayers.dart';

import '../../data/datasources/audio_local_datasource.dart';
import '../../domain/entities/audio_settings_entity.dart';
import '../../domain/repositories/audio_repository.dart';
import '../models/audio_settings_model.dart';

class AudioRepositoryImpl implements AudioRepository {
  AudioRepositoryImpl({required this._localDataSource});

  final AudioLocalDataSource _localDataSource;
  final AudioPlayer _musicPlayer = AudioPlayer();
  final AudioPlayer _sfxPlayer = AudioPlayer();

  AudioSettingsEntity _settings = const AudioSettingsEntity();

  Future<void> _refreshSettings() async {
    _settings = (await _localDataSource.loadSettings()).toEntity();
  }

  Future<void> _applyVolume() async {
    await _musicPlayer.setVolume(_settings.effectiveMusicVolume);
    await _sfxPlayer.setVolume(_settings.effectiveSfxVolume);
  }

  @override
  Future<AudioSettingsEntity> getSettings() async {
    await _refreshSettings();
    return _settings;
  }

  @override
  Future<void> saveSettings(AudioSettingsEntity settings) async {
    _settings = settings;
    await _localDataSource.saveSettings(
      AudioSettingsModel.fromEntity(settings),
    );
    await _applyVolume();
  }

  @override
  Future<void> playBackgroundMusic({
    required String assetPath,
    bool loop = true,
  }) async {
    await _refreshSettings();
    await _musicPlayer.setReleaseMode(
      loop ? ReleaseMode.loop : ReleaseMode.stop,
    );
    await _musicPlayer.setVolume(_settings.effectiveMusicVolume);
    await _musicPlayer.play(AssetSource(assetPath));
  }

  @override
  Future<void> playSfx({required String assetPath}) async {
    await _refreshSettings();
    await _sfxPlayer.setVolume(_settings.effectiveSfxVolume);
    await _sfxPlayer.play(AssetSource(assetPath));
  }

  @override
  Future<void> stopBackgroundMusic() async {
    await _musicPlayer.stop();
  }

  @override
  Future<void> stopAll() async {
    await _musicPlayer.stop();
    await _sfxPlayer.stop();
  }

  @override
  Future<void> setMusicVolume(double volume) async {
    final updated = _settings.copyWith(musicVolume: volume.clamp(0.0, 1.0));
    await saveSettings(updated);
  }

  @override
  Future<void> setSfxVolume(double volume) async {
    final updated = _settings.copyWith(sfxVolume: volume.clamp(0.0, 1.0));
    await saveSettings(updated);
  }

  @override
  Future<void> setEnabled({
    bool? musicEnabled,
    bool? sfxEnabled,
    bool? masterEnabled,
  }) async {
    final updated = _settings.copyWith(
      musicEnabled: musicEnabled ?? _settings.musicEnabled,
      sfxEnabled: sfxEnabled ?? _settings.sfxEnabled,
      masterEnabled: masterEnabled ?? _settings.masterEnabled,
    );
    await saveSettings(updated);
  }
}
