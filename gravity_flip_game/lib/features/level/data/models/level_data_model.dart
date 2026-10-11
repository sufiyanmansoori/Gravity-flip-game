import 'package:equatable/equatable.dart';

import '../../domain/entities/level_entity.dart';
import '../../domain/value_objects/level_difficulty.dart';

class LevelDataModel extends Equatable {
  const LevelDataModel({
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
  final String difficulty;
  final String description;
  final String goal;
  final int targetScore;
  final int requiredStars;
  final bool isUnlocked;
  final int bestScore;
  final int stars;

  factory LevelDataModel.fromJson(Map<String, dynamic> json) {
    return LevelDataModel(
      id: json['id'] as String? ?? 'level_${json['number'] ?? 1}',
      number: json['number'] as int? ?? 1,
      name: json['name'] as String? ?? 'Level 1',
      difficulty: json['difficulty'] as String? ?? 'normal',
      description: json['description'] as String? ?? 'Complete the objective.',
      goal: json['goal'] as String? ?? 'Reach the target score',
      targetScore: json['targetScore'] as int? ?? 2500,
      requiredStars: json['requiredStars'] as int? ?? 0,
      isUnlocked: json['isUnlocked'] as bool? ?? false,
      bestScore: json['bestScore'] as int? ?? 0,
      stars: json['stars'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'name': name,
      'difficulty': difficulty,
      'description': description,
      'goal': goal,
      'targetScore': targetScore,
      'requiredStars': requiredStars,
      'isUnlocked': isUnlocked,
      'bestScore': bestScore,
      'stars': stars,
    };
  }

  LevelEntity toEntity() {
    return LevelEntity(
      id: id,
      number: number,
      name: name,
      difficulty: LevelDifficultyX.fromString(difficulty),
      description: description,
      goal: goal,
      targetScore: targetScore,
      requiredStars: requiredStars,
      isUnlocked: isUnlocked,
      bestScore: bestScore,
      stars: stars,
    );
  }

  static LevelDataModel fromEntity(LevelEntity entity) {
    return LevelDataModel(
      id: entity.id,
      number: entity.number,
      name: entity.name,
      difficulty: entity.difficulty.name,
      description: entity.description,
      goal: entity.goal,
      targetScore: entity.targetScore,
      requiredStars: entity.requiredStars,
      isUnlocked: entity.isUnlocked,
      bestScore: entity.bestScore,
      stars: entity.stars,
    );
  }

  LevelDataModel copyWith({
    String? id,
    int? number,
    String? name,
    String? difficulty,
    String? description,
    String? goal,
    int? targetScore,
    int? requiredStars,
    bool? isUnlocked,
    int? bestScore,
    int? stars,
  }) {
    return LevelDataModel(
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
