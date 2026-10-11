import 'package:equatable/equatable.dart';

class AudioSettingsEntity extends Equatable {
  const AudioSettingsEntity({
    this.musicVolume = 0.7,
    this.sfxVolume = 0.8,
    this.musicEnabled = true,
    this.sfxEnabled = true,
    this.masterEnabled = true,
  });

  final double musicVolume;
  final double sfxVolume;
  final bool musicEnabled;
  final bool sfxEnabled;
  final bool masterEnabled;

  AudioSettingsEntity copyWith({
    double? musicVolume,
    double? sfxVolume,
    bool? musicEnabled,
    bool? sfxEnabled,
    bool? masterEnabled,
  }) {
    return AudioSettingsEntity(
      musicVolume: musicVolume ?? this.musicVolume,
      sfxVolume: sfxVolume ?? this.sfxVolume,
      musicEnabled: musicEnabled ?? this.musicEnabled,
      sfxEnabled: sfxEnabled ?? this.sfxEnabled,
      masterEnabled: masterEnabled ?? this.masterEnabled,
    );
  }

  double get effectiveMusicVolume =>
      masterEnabled && musicEnabled ? musicVolume.clamp(0.0, 1.0) : 0.0;

  double get effectiveSfxVolume =>
      masterEnabled && sfxEnabled ? sfxVolume.clamp(0.0, 1.0) : 0.0;

  @override
  List<Object?> get props => [
    musicVolume,
    sfxVolume,
    musicEnabled,
    sfxEnabled,
    masterEnabled,
  ];
}
