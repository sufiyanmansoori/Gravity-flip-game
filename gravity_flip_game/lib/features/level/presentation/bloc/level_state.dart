part of 'level_bloc.dart';

abstract class LevelState {
  const LevelState();
}

class LevelInitial extends LevelState {
  const LevelInitial();
}

class LevelLoading extends LevelState {
  const LevelLoading();
}

class LevelLoaded extends LevelState {
  const LevelLoaded({required this.levels, this.selectedLevel});

  final List<LevelEntity> levels;
  final LevelEntity? selectedLevel;
}

class LevelFailure extends LevelState {
  const LevelFailure({required this.message});

  final String message;
}
