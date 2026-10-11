import 'package:gravity_flip_game/features/game/data/models/game_model.dart';
import 'package:gravity_flip_game/features/game/data/models/level_model.dart';
import 'package:gravity_flip_game/features/game/domain/entities/game_entity.dart';
import 'package:gravity_flip_game/features/game/domain/value_objects/game_state.dart';

class GameFixtures {
  const GameFixtures._();

  static const GameModel defaultGameModel = GameModel(
    id: 'game_001',
    score: 1200,
    bestScore: 1800,
    lives: 3,
    currentLevel: 1,
    state: GameState.ready,
  );

  static const GameModel playingGameModel = GameModel(
    id: 'game_001',
    score: 2400,
    bestScore: 1800,
    lives: 2,
    currentLevel: 2,
    state: GameState.playing,
  );

  static final GameEntity defaultGameEntity = const GameEntity(
    id: 'game_001',
    score: 1200,
    bestScore: 1800,
    lives: 3,
    currentLevel: 1,
    state: GameState.ready,
  );

  static const LevelModel levelOneModel = LevelModel(
    number: 1,
    name: 'Neon Drift',
    difficulty: 'easy',
    speed: 180,
    gravity: 1800,
    obstacles: [
      {'x': 100, 'y': 200, 'width': 100, 'height': 20},
    ],
    collectibles: [
      {'x': 150, 'y': 150, 'value': 50},
    ],
    baseScore: 1000,
  );

  static const LevelModel levelTwoModel = LevelModel(
    number: 2,
    name: 'Skyline Switch',
    difficulty: 'normal',
    speed: 220,
    gravity: 1900,
    obstacles: [
      {'x': 120, 'y': 260, 'width': 92, 'height': 18},
      {'x': 320, 'y': 180, 'width': 110, 'height': 18},
    ],
    collectibles: [
      {'x': 220, 'y': 150, 'value': 80},
      {'x': 420, 'y': 120, 'value': 90},
    ],
    baseScore: 1800,
  );

  static Map<String, dynamic> jsonGame() => defaultGameModel.toJson();

  static Map<String, dynamic> jsonLevelOne() => levelOneModel.toJson();
}
