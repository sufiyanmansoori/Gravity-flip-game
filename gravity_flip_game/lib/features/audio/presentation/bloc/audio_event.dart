part of 'audio_bloc.dart';

abstract class AudioEvent {
  const AudioEvent();
}

class AudioInitialized extends AudioEvent {
  const AudioInitialized();
}

class AudioSettingsChanged extends AudioEvent {
  const AudioSettingsChanged({
    this.musicVolume,
    this.sfxVolume,
    this.musicEnabled,
    this.sfxEnabled,
    this.masterEnabled,
  });

  final double? musicVolume;
  final double? sfxVolume;
  final bool? musicEnabled;
  final bool? sfxEnabled;
  final bool? masterEnabled;
}

class MusicRequested extends AudioEvent {
  const MusicRequested({required this.assetPath, this.loop = true});

  final String assetPath;
  final bool loop;
}

class SfxRequested extends AudioEvent {
  const SfxRequested({required this.assetPath});

  final String assetPath;
}

class AudioStopped extends AudioEvent {
  const AudioStopped();
}
