import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_local_datasource.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_remote_datasource.dart';
import 'package:gravity_flip_game/features/game/data/repositories/game_repository_impl.dart';
import 'package:gravity_flip_game/features/game/domain/usecases/calculate_score_usecase.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/game_fixtures.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('CalculateScoreUseCase', () {
    test(
      'adds collected points, time bonus, and level bonus to the saved score',
      () async {
        SharedPreferences.setMockInitialValues({});
        final localDatasource = GameLocalDataSource();
        final repository = GameRepositoryImpl(
          localDataSource: localDatasource,
          remoteDataSource: MockGameRemoteDataSource(),
        );

        await repository.saveProgress(GameFixtures.defaultGameEntity);
        final useCase = CalculateScoreUseCase(repository);

        final updated = await useCase(
          collected: 10,
          timeBonus: 250,
          levelBonus: 400,
        );

        expect(updated.score, 1200 + (10 * 10) + 250 + 400);
        expect(updated.bestScore, 1800);
      },
    );
  });
}

class MockGameRemoteDataSource extends GameRemoteDataSource {
  MockGameRemoteDataSource();
}
