import 'package:equatable/equatable.dart';

import '../entities/physics_entity.dart';
import '../value_objects/game_state.dart';

typedef PlayerPosition = ({double x, double y});

class GameEntity extends Equatable {
  const GameEntity({
    required this.id,
    required this.score,
    required this.bestScore,
    required this.lives,
    required this.currentLevel,
    required this.state,
    this.physics = const PhysicsEntity(
      gravity: 1800,
      jumpVelocity: -620,
      velocityY: 0,
      velocityX: 0,
      drag: 0,
      airResistance: 0,
    ),
    this.playerPosition = (x: 120, y: 320),
  });

  final String id;
  final int score;
  final int bestScore;
  final int lives;
  final int currentLevel;
  final GameState state;
  final PhysicsEntity physics;
  final PlayerPosition playerPosition;

  GameEntity copyWith({
    String? id,
    int? score,
    int? bestScore,
    int? lives,
    int? currentLevel,
    GameState? state,
    PhysicsEntity? physics,
    PlayerPosition? playerPosition,
  }) {
    return GameEntity(
      id: id ?? this.id,
      score: score ?? this.score,
      bestScore: bestScore ?? this.bestScore,
      lives: lives ?? this.lives,
      currentLevel: currentLevel ?? this.currentLevel,
      state: state ?? this.state,
      physics: physics ?? this.physics,
      playerPosition: playerPosition ?? this.playerPosition,
    );
  }

  @override
  List<Object?> get props => [
    id,
    score,
    bestScore,
    lives,
    currentLevel,
    state,
    physics,
    playerPosition,
  ];
}
