import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/audio_settings_entity.dart';
import '../../domain/repositories/audio_repository.dart';
import '../../domain/usecases/play_sound_usecase.dart';
import '../../domain/usecases/set_volume_usecase.dart';
import '../../domain/usecases/stop_sound_usecase.dart';

part 'audio_event.dart';
part 'audio_state.dart';

class AudioBloc extends Bloc<AudioEvent, AudioState> {
  AudioBloc({required AudioRepository repository})
    : _repository = repository,
      _playSoundUseCase = PlaySoundUseCase(repository),
      _stopSoundUseCase = StopSoundUseCase(repository),
      _setVolumeUseCase = SetVolumeUseCase(repository),
      super(const AudioState()) {
    on<AudioInitialized>(_onInitialized);
    on<AudioSettingsChanged>(_onSettingsChanged);
    on<MusicRequested>(_onMusicRequested);
    on<SfxRequested>(_onSfxRequested);
    on<AudioStopped>(_onAudioStopped);
  }

  final AudioRepository _repository;
  final PlaySoundUseCase _playSoundUseCase;
  final StopSoundUseCase _stopSoundUseCase;
  final SetVolumeUseCase _setVolumeUseCase;

  Future<void> _onInitialized(
    AudioInitialized event,
    Emitter<AudioState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AudioStatus.loading));
      final settings = await _repository.getSettings();
      emit(
        state.copyWith(
          settings: settings,
          isMusicPlaying: false,
          isSfxPlaying: false,
          status: AudioStatus.idle,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: AudioStatus.error));
    }
  }

  Future<void> _onSettingsChanged(
    AudioSettingsChanged event,
    Emitter<AudioState> emit,
  ) async {
    try {
      final current = state.settings;
      final updated = current.copyWith(
        musicVolume: event.musicVolume ?? current.musicVolume,
        sfxVolume: event.sfxVolume ?? current.sfxVolume,
        musicEnabled: event.musicEnabled ?? current.musicEnabled,
        sfxEnabled: event.sfxEnabled ?? current.sfxEnabled,
        masterEnabled: event.masterEnabled ?? current.masterEnabled,
      );

      await _setVolumeUseCase(
        musicVolume: event.musicVolume,
        sfxVolume: event.sfxVolume,
        musicEnabled: event.musicEnabled,
        sfxEnabled: event.sfxEnabled,
        masterEnabled: event.masterEnabled,
      );
      await _repository.saveSettings(updated);
      emit(state.copyWith(settings: updated));
    } catch (_) {
      emit(state.copyWith(status: AudioStatus.error));
    }
  }

  Future<void> _onMusicRequested(
    MusicRequested event,
    Emitter<AudioState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AudioStatus.loading));
      await _repository.playBackgroundMusic(
        assetPath: event.assetPath,
        loop: event.loop,
      );
      emit(state.copyWith(isMusicPlaying: true, status: AudioStatus.playing));
    } catch (_) {
      emit(state.copyWith(status: AudioStatus.error));
    }
  }

  Future<void> _onSfxRequested(
    SfxRequested event,
    Emitter<AudioState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AudioStatus.loading));
      await _playSoundUseCase(assetPath: event.assetPath);
      emit(
        state.copyWith(
          isSfxPlaying: true,
          lastPlayedSfx: event.assetPath,
          status: AudioStatus.playing,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: AudioStatus.error));
    }
  }

  Future<void> _onAudioStopped(
    AudioStopped event,
    Emitter<AudioState> emit,
  ) async {
    try {
      await _stopSoundUseCase();
      emit(
        state.copyWith(
          isMusicPlaying: false,
          isSfxPlaying: false,
          status: AudioStatus.stopped,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: AudioStatus.error));
    }
  }
}
