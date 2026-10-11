import 'package:equatable/equatable.dart';

class LevelEntity extends Equatable {
  const LevelEntity({
    required this.number,
    required this.name,
    required this.difficulty,
    required this.speed,
    required this.gravity,
    required this.obstacles,
    required this.collectibles,
    required this.baseScore,
  });

  final int number;
  final String name;
  final String difficulty;
  final double speed;
  final double gravity;
  final List<Map<String, dynamic>> obstacles;
  final List<Map<String, dynamic>> collectibles;
  final int baseScore;

  LevelEntity copyWith({
    int? number,
    String? name,
    String? difficulty,
    double? speed,
    double? gravity,
    List<Map<String, dynamic>>? obstacles,
    List<Map<String, dynamic>>? collectibles,
    int? baseScore,
  }) {
    return LevelEntity(
      number: number ?? this.number,
      name: name ?? this.name,
      difficulty: difficulty ?? this.difficulty,
      speed: speed ?? this.speed,
      gravity: gravity ?? this.gravity,
      obstacles: obstacles ?? this.obstacles,
      collectibles: collectibles ?? this.collectibles,
      baseScore: baseScore ?? this.baseScore,
    );
  }

  @override
  List<Object?> get props => [
    number,
    name,
    difficulty,
    speed,
    gravity,
    obstacles,
    collectibles,
    baseScore,
  ];
}
