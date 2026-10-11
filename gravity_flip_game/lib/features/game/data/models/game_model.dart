import 'package:equatable/equatable.dart';

import '../../domain/value_objects/game_state.dart';

class GameModel extends Equatable {
  const GameModel({
    required this.id,
    required this.score,
    required this.bestScore,
    required this.lives,
    required this.currentLevel,
    required this.state,
  });

  final String id;
  final int score;
  final int bestScore;
  final int lives;
  final int currentLevel;
  final GameState state;

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'] as String? ?? 'default_game',
      score: json['score'] as int? ?? 0,
      bestScore: json['bestScore'] as int? ?? 0,
      lives: json['lives'] as int? ?? 3,
      currentLevel: json['currentLevel'] as int? ?? 1,
      state: GameState.values.firstWhere(
        (value) => value.name == (json['state'] as String? ?? 'ready'),
        orElse: () => GameState.ready,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'score': score,
      'bestScore': bestScore,
      'lives': lives,
      'currentLevel': currentLevel,
      'state': state.name,
    };
  }

  GameModel copyWith({
    String? id,
    int? score,
    int? bestScore,
    int? lives,
    int? currentLevel,
    GameState? state,
  }) {
    return GameModel(
      id: id ?? this.id,
      score: score ?? this.score,
      bestScore: bestScore ?? this.bestScore,
      lives: lives ?? this.lives,
      currentLevel: currentLevel ?? this.currentLevel,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [id, score, bestScore, lives, currentLevel, state];
}
