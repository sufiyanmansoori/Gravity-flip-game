import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/audio_settings_model.dart';

class AudioLocalDataSource {
  const AudioLocalDataSource({required this._preferences});

  final SharedPreferences _preferences;

  static const String _musicVolumeKey = 'audio_music_volume';
  static const String _sfxVolumeKey = 'audio_sfx_volume';
  static const String _musicEnabledKey = 'audio_music_enabled';
  static const String _sfxEnabledKey = 'audio_sfx_enabled';
  static const String _masterEnabledKey = 'audio_master_enabled';

  Future<AudioSettingsModel> loadSettings() async {
    final musicVolume = _preferences.getDouble(_musicVolumeKey) ?? 0.7;
    final sfxVolume = _preferences.getDouble(_sfxVolumeKey) ?? 0.8;
    final musicEnabled = _preferences.getBool(_musicEnabledKey) ?? true;
    final sfxEnabled = _preferences.getBool(_sfxEnabledKey) ?? true;
    final masterEnabled = _preferences.getBool(_masterEnabledKey) ?? true;

    return AudioSettingsModel(
      musicVolume: musicVolume,
      sfxVolume: sfxVolume,
      musicEnabled: musicEnabled,
      sfxEnabled: sfxEnabled,
      masterEnabled: masterEnabled,
    );
  }

  Future<void> saveSettings(AudioSettingsModel settings) async {
    await _preferences.setDouble(_musicVolumeKey, settings.musicVolume);
    await _preferences.setDouble(_sfxVolumeKey, settings.sfxVolume);
    await _preferences.setBool(_musicEnabledKey, settings.musicEnabled);
    await _preferences.setBool(_sfxEnabledKey, settings.sfxEnabled);
    await _preferences.setBool(_masterEnabledKey, settings.masterEnabled);
  }
}
