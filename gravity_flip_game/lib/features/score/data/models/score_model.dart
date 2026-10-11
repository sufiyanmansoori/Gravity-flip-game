import 'package:equatable/equatable.dart';

import '../../domain/entities/score_entity.dart';

class ScoreModel extends Equatable {
  const ScoreModel({
    required this.id,
    required this.playerName,
    required this.score,
    required this.levelId,
    required this.levelName,
    required this.rank,
    required this.createdAt,
  });

  final String id;
  final String playerName;
  final int score;
  final String levelId;
  final String levelName;
  final int rank;
  final DateTime createdAt;

  factory ScoreModel.fromJson(Map<String, dynamic> json) {
    return ScoreModel(
      id:
          json['id'] as String? ??
          'score_${DateTime.now().millisecondsSinceEpoch}',
      playerName: json['playerName'] as String? ?? 'Player',
      score: json['score'] as int? ?? 0,
      levelId: json['levelId'] as String? ?? 'level_1',
      levelName: json['levelName'] as String? ?? 'Level 1',
      rank: json['rank'] as int? ?? 0,
      createdAt:
          DateTime.tryParse(
            json['createdAt'] as String? ?? DateTime.now().toIso8601String(),
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'playerName': playerName,
      'score': score,
      'levelId': levelId,
      'levelName': levelName,
      'rank': rank,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  ScoreEntity toEntity() {
    return ScoreEntity(
      id: id,
      playerName: playerName,
      score: score,
      levelId: levelId,
      levelName: levelName,
      rank: rank,
      createdAt: createdAt,
    );
  }

  static ScoreModel fromEntity(ScoreEntity entity) {
    return ScoreModel(
      id: entity.id,
      playerName: entity.playerName,
      score: entity.score,
      levelId: entity.levelId,
      levelName: entity.levelName,
      rank: entity.rank,
      createdAt: entity.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    playerName,
    score,
    levelId,
    levelName,
    rank,
    createdAt,
  ];
}
