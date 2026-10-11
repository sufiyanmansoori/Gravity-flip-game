import 'package:equatable/equatable.dart';

import '../value_objects/level_difficulty.dart';

class LevelEntity extends Equatable {
  const LevelEntity({
    required this.id,
    required this.number,
    required this.name,
    required this.difficulty,
    required this.description,
    required this.goal,
    required this.targetScore,
    required this.requiredStars,
    required this.isUnlocked,
    required this.bestScore,
    required this.stars,
  });

  final String id;
  final int number;
  final String name;
  final LevelDifficulty difficulty;
  final String description;
  final String goal;
  final int targetScore;
  final int requiredStars;
  final bool isUnlocked;
  final int bestScore;
  final int stars;

  LevelEntity copyWith({
    String? id,
    int? number,
    String? name,
    LevelDifficulty? difficulty,
    String? description,
    String? goal,
    int? targetScore,
    int? requiredStars,
    bool? isUnlocked,
    int? bestScore,
    int? stars,
  }) {
    return LevelEntity(
      id: id ?? this.id,
      number: number ?? this.number,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      description: description ?? this.description,
      goal: goal ?? this.goal,
      targetScore: targetScore ?? this.targetScore,
      requiredStars: requiredStars ?? this.requiredStars,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      bestScore: bestScore ?? this.bestScore,
      stars: stars ?? this.stars,
    );
  }

  @override
  List<Object?> get props => [
    id,
    number,
    name,
    difficulty,
    description,
    goal,
    targetScore,
    requiredStars,
    isUnlocked,
    bestScore,
    stars,
  ];
}
