import 'package:equatable/equatable.dart';

class ScoreEntity extends Equatable {
  const ScoreEntity({
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

  ScoreEntity copyWith({
    String? id,
    String? playerName,
    int? score,
    String? levelId,
    String? levelName,
    int? rank,
    DateTime? createdAt,
  }) {
    return ScoreEntity(
      id: id ?? this.id,
      playerName: playerName ?? this.playerName,
      score: score ?? this.score,
      levelId: levelId ?? this.levelId,
      levelName: levelName ?? this.levelName,
      rank: rank ?? this.rank,
      createdAt: createdAt ?? this.createdAt,
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
