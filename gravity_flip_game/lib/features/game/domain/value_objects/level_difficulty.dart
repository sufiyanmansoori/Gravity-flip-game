enum LevelDifficulty { easy, normal, hard, insane }

extension LevelDifficultyX on LevelDifficulty {
  String get label {
    switch (this) {
      case LevelDifficulty.easy:
        return 'Easy';
      case LevelDifficulty.normal:
        return 'Normal';
      case LevelDifficulty.hard:
        return 'Hard';
      case LevelDifficulty.insane:
        return 'Insane';
    }
  }
}
