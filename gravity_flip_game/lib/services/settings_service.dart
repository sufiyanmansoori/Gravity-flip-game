import 'package:shared_preferences/shared_preferences.dart';

class GameSettings {
  final bool musicEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool reducedMotion;
  final double graphicsQuality;

  const GameSettings({
    this.musicEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.reducedMotion = false,
    this.graphicsQuality = 0.8,
  });

  GameSettings copyWith({
    bool? musicEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? reducedMotion,
    double? graphicsQuality,
  }) {
    return GameSettings(
      musicEnabled: musicEnabled ?? this.musicEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      reducedMotion: reducedMotion ?? this.reducedMotion,
      graphicsQuality: graphicsQuality ?? this.graphicsQuality,
    );
  }
}

class SettingsService {
  static const String _musicKey = 'settings_music';
  static const String _soundKey = 'settings_sound';
  static const String _vibrationKey = 'settings_vibration';
  static const String _reducedMotionKey = 'settings_reduced_motion';
  static const String _graphicsKey = 'settings_graphics';

  Future<GameSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    return GameSettings(
      musicEnabled: prefs.getBool(_musicKey) ?? true,
      soundEnabled: prefs.getBool(_soundKey) ?? true,
      vibrationEnabled: prefs.getBool(_vibrationKey) ?? true,
      reducedMotion: prefs.getBool(_reducedMotionKey) ?? false,
      graphicsQuality: prefs.getDouble(_graphicsKey) ?? 0.8,
    );
  }

  Future<void> save(GameSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_musicKey, settings.musicEnabled);
    await prefs.setBool(_soundKey, settings.soundEnabled);
    await prefs.setBool(_vibrationKey, settings.vibrationEnabled);
    await prefs.setBool(_reducedMotionKey, settings.reducedMotion);
    await prefs.setDouble(_graphicsKey, settings.graphicsQuality);
  }
}
