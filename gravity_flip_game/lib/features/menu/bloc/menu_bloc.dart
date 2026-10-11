import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(const MenuState()) {
    on<LoadMenu>(_onLoadMenu);
    on<NavigateToScreen>(_onNavigateToScreen);
    on<TogglePauseMenu>(_onTogglePauseMenu);
    on<UpdateSettings>(_onUpdateSettings);
  }

  Future<void> _onLoadMenu(LoadMenu event, Emitter<MenuState> emit) async {
    emit(state.copyWith(currentScreen: 'main'));
  }

  Future<void> _onNavigateToScreen(
    NavigateToScreen event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(currentScreen: event.screen));
  }

  Future<void> _onTogglePauseMenu(
    TogglePauseMenu event,
    Emitter<MenuState> emit,
  ) async {
    emit(state.copyWith(isPaused: event.isPaused));
  }

  Future<void> _onUpdateSettings(
    UpdateSettings event,
    Emitter<MenuState> emit,
  ) async {
    emit(
      state.copyWith(
        musicVolume: event.musicVolume ?? state.musicVolume,
        sfxVolume: event.sfxVolume ?? state.sfxVolume,
        soundEnabled: event.soundEnabled ?? state.soundEnabled,
        vibrationEnabled: event.vibrationEnabled ?? state.vibrationEnabled,
        showHints: event.showHints ?? state.showHints,
      ),
    );
  }
}
