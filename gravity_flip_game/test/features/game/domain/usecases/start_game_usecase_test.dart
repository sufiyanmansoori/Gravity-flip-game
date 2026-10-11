import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_local_datasource.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_remote_datasource.dart';
import 'package:gravity_flip_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:gravity_flip_game/features/game/domain/usecases/start_game_usecase.dart';
import 'package:gravity_flip_game/features/game/domain/value_objects/game_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/game_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StartGameUseCase', () {
    test('starts a ready game and updates the repository state', () async {
      SharedPreferences.setMockInitialValues({});
      final localDatasource = GameLocalDataSource();
      final repository = GameRepositoryImpl(
        localDataSource: localDatasource,
        remoteDataSource: MockGameRemoteDataSource(),
      );

      await repository.saveProgress(GameFixtures.defaultGameEntity);
      final useCase = StartGameUseCase(repository);

      final game = await useCase();

      expect(game.state, GameState.playing);
      expect(game.id, GameFixtures.defaultGameEntity.id);
    });
  });
}

class MockGameRemoteDataSource extends GameRemoteDataSource {
  MockGameRemoteDataSource();
}
