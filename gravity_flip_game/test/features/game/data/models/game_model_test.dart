import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_flip_game/features/game/data/models/game_model.dart';
import 'package:gravity_flip_game/features/game/domain/value_objects/game_state.dart';

void main() {
  group('GameModel', () {
    test('creates a model from valid JSON', () {
      final model = GameModel.fromJson(const {
        'id': 'game_42',
        'score': 1500,
        'bestScore': 1800,
        'lives': 2,
        'currentLevel': 3,
        'state': 'playing',
      });

      expect(model.id, 'game_42');
      expect(model.score, 1500);
      expect(model.bestScore, 1800);
      expect(model.currentLevel, 3);
      expect(model.state, GameState.playing);
    });

    test('falls back to defaults when JSON fields are missing', () {
      final model = GameModel.fromJson(const {});

      expect(model.id, 'default_game');
      expect(model.score, 0);
      expect(model.bestScore, 0);
      expect(model.lives, 3);
      expect(model.currentLevel, 1);
      expect(model.state, GameState.ready);
    });

    test('converts to JSON and back without data loss', () {
      const model = GameModel(
        id: 'game_99',
        score: 900,
        bestScore: 1100,
        lives: 1,
        currentLevel: 5,
        state: GameState.gameOver,
      );

      final json = model.toJson();
      final reconstructed = GameModel.fromJson(json);

      expect(reconstructed, equals(model));
      expect(json['state'], 'gameOver');
    });

    test('supports copyWith updates', () {
      const game = GameModel(
        id: 'game_1',
        score: 100,
        bestScore: 150,
        lives: 3,
        currentLevel: 1,
        state: GameState.ready,
      );

      final updated = game.copyWith(score: 250, state: GameState.playing);

      expect(updated.score, 250);
      expect(updated.state, GameState.playing);
      expect(updated.id, game.id);
    });
  });
}
