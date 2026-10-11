import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/achievement_entity.dart';
import '../../domain/usecases/get_achievements_usecase.dart';
import '../../domain/usecases/unlock_achievement_usecase.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  AchievementBloc({
    required this._getAchievementsUseCase,
    required this._unlockAchievementUseCase,
  }) : super(const AchievementInitial()) {
    on<LoadAchievements>(_onLoadAchievements);
    on<UnlockAchievement>(_onUnlockAchievement);
    on<RefreshAchievements>(_onRefreshAchievements);
  }

  final GetAchievementsUseCase _getAchievementsUseCase;
  final UnlockAchievementUseCase _unlockAchievementUseCase;

  Future<void> _onLoadAchievements(
    LoadAchievements event,
    Emitter<AchievementState> emit,
  ) async {
    emit(const AchievementLoading());

    try {
      final achievements = await _getAchievementsUseCase();
      emit(AchievementLoaded(achievements: achievements));
    } catch (error) {
      emit(AchievementFailure('Failed to load achievements: $error'));
    }
  }

  Future<void> _onUnlockAchievement(
    UnlockAchievement event,
    Emitter<AchievementState> emit,
  ) async {
    emit(const AchievementLoading());

    try {
      final unlocked = await _unlockAchievementUseCase(event.achievementId);
      emit(AchievementUnlocked(unlocked));
      add(const LoadAchievements());
    } catch (error) {
      emit(AchievementFailure('Failed to unlock achievement: $error'));
    }
  }

  Future<void> _onRefreshAchievements(
    RefreshAchievements event,
    Emitter<AchievementState> emit,
  ) async {
    add(const LoadAchievements());
  }
}
