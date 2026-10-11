part of 'level_bloc.dart';

abstract class LevelEvent {
  const LevelEvent();
}

class LoadLevels extends LevelEvent {
  const LoadLevels();
}

class SelectLevel extends LevelEvent {
  const SelectLevel(this.id);

  final String id;
}

class UnlockLevel extends LevelEvent {
  const UnlockLevel(this.id);

  final String id;
}
