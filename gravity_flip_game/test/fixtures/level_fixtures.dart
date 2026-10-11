import 'package:gravity_flip_game/features/level/data/models/level_data_model.dart';
import 'package:gravity_flip_game/features/level/domain/entities/level_entity.dart';
import 'package:gravity_flip_game/features/level/domain/value_objects/level_difficulty.dart';

class LevelFixtures {
  const LevelFixtures._();

  static const LevelDataModel levelOneData = LevelDataModel(
    id: 'level_1',
    number: 1,
    name: 'Neon Drift',
    difficulty: 'easy',
    description: 'Warm up and tune your timing.',
    goal: 'Reach the finish line.',
    targetScore: 2500,
    requiredStars: 0,
    isUnlocked: true,
    bestScore: 0,
    stars: 0,
  );

  static const LevelDataModel levelTwoData = LevelDataModel(
    id: 'level_2',
    number: 2,
    name: 'Skyline Switch',
    difficulty: 'normal',
    description: 'Stay in rhythm while gravity flips.',
    goal: 'Collect coins and maintain control.',
    targetScore: 5000,
    requiredStars: 1,
    isUnlocked: false,
    bestScore: 0,
    stars: 0,
  );

  static const LevelEntity levelOneEntity = LevelEntity(
    id: 'level_1',
    number: 1,
    name: 'Neon Drift',
    difficulty: LevelDifficulty.easy,
    description: 'Warm up and tune your timing.',
    goal: 'Reach the finish line.',
    targetScore: 2500,
    requiredStars: 0,
    isUnlocked: true,
    bestScore: 0,
    stars: 0,
  );

  static const LevelEntity levelTwoEntity = LevelEntity(
    id: 'level_2',
    number: 2,
    name: 'Skyline Switch',
    difficulty: LevelDifficulty.normal,
    description: 'Stay in rhythm while gravity flips.',
    goal: 'Collect coins and maintain control.',
    targetScore: 5000,
    requiredStars: 1,
    isUnlocked: false,
    bestScore: 0,
    stars: 0,
  );

  static List<LevelDataModel> defaultLevels() => [levelOneData, levelTwoData];
}
