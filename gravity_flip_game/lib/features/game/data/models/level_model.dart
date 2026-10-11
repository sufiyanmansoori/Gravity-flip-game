import 'package:equatable/equatable.dart';

class LevelModel extends Equatable {
  const LevelModel({
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

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      number: json['number'] as int? ?? 1,
      name: json['name'] as String? ?? 'Level 1',
      difficulty: json['difficulty'] as String? ?? 'normal',
      speed: (json['speed'] as num?)?.toDouble() ?? 180,
      gravity: (json['gravity'] as num?)?.toDouble() ?? 1800,
      obstacles: List<Map<String, dynamic>>.from(
        (json['obstacles'] as List<dynamic>? ?? []).map(
          (element) => Map<String, dynamic>.from(element as Map),
        ),
      ),
      collectibles: List<Map<String, dynamic>>.from(
        (json['collectibles'] as List<dynamic>? ?? []).map(
          (element) => Map<String, dynamic>.from(element as Map),
        ),
      ),
      baseScore: json['baseScore'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'name': name,
      'difficulty': difficulty,
      'speed': speed,
      'gravity': gravity,
      'obstacles': obstacles,
      'collectibles': collectibles,
      'baseScore': baseScore,
    };
  }

  LevelModel copyWith({
    int? number,
    String? name,
    String? difficulty,
    double? speed,
    double? gravity,
    List<Map<String, dynamic>>? obstacles,
    List<Map<String, dynamic>>? collectibles,
    int? baseScore,
  }) {
    return LevelModel(
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
