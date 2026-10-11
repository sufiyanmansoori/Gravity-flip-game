part of 'audio_bloc.dart';

class AudioState extends Equatable {
  const AudioState({
    this.settings = const AudioSettingsEntity(),
    this.isMusicPlaying = false,
    this.isSfxPlaying = false,
    this.lastPlayedSfx,
    this.status = AudioStatus.idle,
  });

  final AudioSettingsEntity settings;
  final bool isMusicPlaying;
  final bool isSfxPlaying;
  final String? lastPlayedSfx;
  final AudioStatus status;

  AudioState copyWith({
    AudioSettingsEntity? settings,
    bool? isMusicPlaying,
    bool? isSfxPlaying,
    String? lastPlayedSfx,
    AudioStatus? status,
  }) {
    return AudioState(
      settings: settings ?? this.settings,
      isMusicPlaying: isMusicPlaying ?? this.isMusicPlaying,
      isSfxPlaying: isSfxPlaying ?? this.isSfxPlaying,
      lastPlayedSfx: lastPlayedSfx ?? this.lastPlayedSfx,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
    settings,
    isMusicPlaying,
    isSfxPlaying,
    lastPlayedSfx,
    status,
  ];
}

enum AudioStatus { idle, loading, playing, stopped, error }
