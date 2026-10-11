import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/level_entity.dart';
import '../../domain/usecases/get_all_levels_usecase.dart';
import '../../domain/usecases/get_level_usecase.dart';
import '../../domain/usecases/unlock_level_usecase.dart';

part 'level_event.dart';
part 'level_state.dart';

class LevelBloc extends Bloc<LevelEvent, LevelState> {
  LevelBloc({
    required this._getAllLevelsUseCase,
    required this._getLevelUseCase,
    required this._unlockLevelUseCase,
  }) : super(const LevelInitial()) {
    on<LoadLevels>(_onLoadLevels);
    on<SelectLevel>(_onSelectLevel);
    on<UnlockLevel>(_onUnlockLevel);
  }

  final GetAllLevelsUseCase _getAllLevelsUseCase;
  final GetLevelUseCase _getLevelUseCase;
  final UnlockLevelUseCase _unlockLevelUseCase;

  Future<void> _onLoadLevels(LoadLevels event, Emitter<LevelState> emit) async {
    emit(const LevelLoading());
    try {
      final levels = await _getAllLevelsUseCase();
      emit(LevelLoaded(levels: levels));
    } catch (error) {
      emit(LevelFailure(message: error.toString()));
    }
  }

  Future<void> _onSelectLevel(
    SelectLevel event,
    Emitter<LevelState> emit,
  ) async {
    try {
      final level = await _getLevelUseCase(event.id);
      final current = state is LevelLoaded
          ? (state as LevelLoaded).levels
          : <LevelEntity>[];
      emit(LevelLoaded(levels: current, selectedLevel: level));
    } catch (error) {
      emit(LevelFailure(message: error.toString()));
    }
  }

  Future<void> _onUnlockLevel(
    UnlockLevel event,
    Emitter<LevelState> emit,
  ) async {
    try {
      final level = await _unlockLevelUseCase(event.id);
      final currentState = state is LevelLoaded
          ? state as LevelLoaded
          : const LevelLoaded(levels: []);
      final updated = currentState.levels
          .map((item) => item.id == level.id ? level : item)
          .toList();
      emit(LevelLoaded(levels: updated, selectedLevel: level));
    } catch (error) {
      emit(LevelFailure(message: error.toString()));
    }
  }
}
