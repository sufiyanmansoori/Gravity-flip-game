import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_local_datasource.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_remote_datasource.dart';
import 'package:gravity_flip_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:gravity_flip_game/features/game/domain/value_objects/game_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/game_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late GameLocalDataSource localDatasource;
  late GameRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    localDatasource = GameLocalDataSource();
    repository = GameRepositoryImpl(
      localDataSource: localDatasource,
      remoteDataSource: GameRemoteDataSource(),
    );
  });

  group('GameRepositoryImpl', () {
    test('loads the existing game from local storage', () async {
      await localDatasource.saveGame(GameFixtures.defaultGameModel);

      final game = await repository.loadGame();

      expect(game.id, GameFixtures.defaultGameModel.id);
      expect(game.score, GameFixtures.defaultGameModel.score);
      expect(game.state, GameFixtures.defaultGameModel.state);
    });

    test('saves a new game progress snapshot', () async {
      final updated = GameFixtures.defaultGameEntity.copyWith(
        score: 2500,
        lives: 2,
        state: GameState.playing,
      );

      await repository.saveProgress(updated);
      final reloaded = await repository.loadGame();

      expect(reloaded.score, 2500);
      expect(reloaded.lives, 2);
      expect(reloaded.state, GameState.playing);
    });

    test('returns the available levels from the local datasource', () async {
      await localDatasource.saveLevel(GameFixtures.levelOneModel);
      await localDatasource.saveLevel(GameFixtures.levelTwoModel);

      final levels = await repository.getLevels();

      expect(levels.length, 3);
      expect(levels.first.number, 1);
      expect(levels.any((level) => level.number == 2), isTrue);
    });

    test('updates and reads current game state', () async {
      await repository.updateCurrentState(GameState.paused);
      final state = await repository.getCurrentState();

      expect(state, GameState.paused);
    });
  });
}
