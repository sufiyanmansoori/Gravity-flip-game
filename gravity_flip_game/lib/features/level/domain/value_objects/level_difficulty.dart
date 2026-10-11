import 'package:flutter/material.dart';

enum LevelDifficulty { easy, normal, hard, expert }

extension LevelDifficultyX on LevelDifficulty {
  String get label {
    switch (this) {
      case LevelDifficulty.easy:
        return 'Easy';
      case LevelDifficulty.normal:
        return 'Normal';
      case LevelDifficulty.hard:
        return 'Hard';
      case LevelDifficulty.expert:
        return 'Expert';
    }
  }

  Color get color {
    switch (this) {
      case LevelDifficulty.easy:
        return const Color(0xFF4CAF50);
      case LevelDifficulty.normal:
        return const Color(0xFF2196F3);
      case LevelDifficulty.hard:
        return const Color(0xFFFF9800);
      case LevelDifficulty.expert:
        return const Color(0xFFE53935);
    }
  }

  int get sortOrder {
    switch (this) {
      case LevelDifficulty.easy:
        return 1;
      case LevelDifficulty.normal:
        return 2;
      case LevelDifficulty.hard:
        return 3;
      case LevelDifficulty.expert:
        return 4;
    }
  }

  static LevelDifficulty fromString(String value) {
    switch (value.toLowerCase()) {
      case 'easy':
        return LevelDifficulty.easy;
      case 'normal':
        return LevelDifficulty.normal;
      case 'hard':
        return LevelDifficulty.hard;
      case 'expert':
        return LevelDifficulty.expert;
      default:
        return LevelDifficulty.normal;
    }
  }
}
