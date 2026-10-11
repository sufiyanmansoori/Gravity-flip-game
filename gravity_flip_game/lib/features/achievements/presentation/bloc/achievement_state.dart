part of 'achievement_bloc.dart';

abstract class AchievementState extends Equatable {
  const AchievementState();
}

class AchievementInitial extends AchievementState {
  const AchievementInitial();

  @override
  List<Object?> get props => const [];
}

class AchievementLoading extends AchievementState {
  const AchievementLoading();

  @override
  List<Object?> get props => const [];
}

class AchievementLoaded extends AchievementState {
  const AchievementLoaded({required this.achievements});

  final List<AchievementEntity> achievements;

  @override
  List<Object?> get props => [achievements];
}

class AchievementUnlocked extends AchievementState {
  const AchievementUnlocked(this.achievement);

  final AchievementEntity achievement;

  @override
  List<Object?> get props => [achievement];
}

class AchievementFailure extends AchievementState {
  const AchievementFailure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
