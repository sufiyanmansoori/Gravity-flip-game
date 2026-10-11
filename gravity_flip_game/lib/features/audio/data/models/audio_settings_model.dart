import 'package:equatable/equatable.dart';

import '../../domain/entities/audio_settings_entity.dart';

class AudioSettingsModel extends Equatable {
  const AudioSettingsModel({
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

  factory AudioSettingsModel.fromEntity(AudioSettingsEntity entity) {
    return AudioSettingsModel(
      musicVolume: entity.musicVolume,
      sfxVolume: entity.sfxVolume,
      musicEnabled: entity.musicEnabled,
      sfxEnabled: entity.sfxEnabled,
      masterEnabled: entity.masterEnabled,
    );
  }

  AudioSettingsEntity toEntity() {
    return AudioSettingsEntity(
      musicVolume: musicVolume,
      sfxVolume: sfxVolume,
      musicEnabled: musicEnabled,
      sfxEnabled: sfxEnabled,
      masterEnabled: masterEnabled,
    );
  }

  factory AudioSettingsModel.fromJson(Map<String, dynamic> json) {
    return AudioSettingsModel(
      musicVolume: (json['musicVolume'] as num?)?.toDouble() ?? 0.7,
      sfxVolume: (json['sfxVolume'] as num?)?.toDouble() ?? 0.8,
      musicEnabled: json['musicEnabled'] as bool? ?? true,
      sfxEnabled: json['sfxEnabled'] as bool? ?? true,
      masterEnabled: json['masterEnabled'] as bool? ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'musicVolume': musicVolume,
      'sfxVolume': sfxVolume,
      'musicEnabled': musicEnabled,
      'sfxEnabled': sfxEnabled,
      'masterEnabled': masterEnabled,
    };
  }

  @override
  List<Object?> get props => [
    musicVolume,
    sfxVolume,
    musicEnabled,
    sfxEnabled,
    masterEnabled,
  ];
}
