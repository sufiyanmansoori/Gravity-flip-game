import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_local_datasource.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_remote_datasource.dart';
import 'package:gravity_flip_game/features/game/domain/value_objects/game_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../fixtures/game_fixtures.dart';

class _MockGameHttpClient extends http.BaseClient {
  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    throw UnimplementedError();
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return http.Response(jsonEncode(GameFixtures.jsonGame()), 200);
  }

  @override
  Future<http.Response> post(
    Uri url, {
    Map<String, String>? headers,
    Object? body,
    Encoding? encoding,
  }) async {
    return http.Response('', 200);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('GameLocalDataSource', () {
    test('loads the default game state when storage is empty', () async {
      SharedPreferences.setMockInitialValues({});
      final datasource = GameLocalDataSource();

      final game = await datasource.loadGame();

      expect(game.id, 'default_game');
      expect(game.score, 0);
      expect(game.lives, 3);
      expect(game.state, GameState.ready);
    });

    test('saves and reloads a game model', () async {
      SharedPreferences.setMockInitialValues({});
      final datasource = GameLocalDataSource();

      await datasource.saveGame(GameFixtures.playingGameModel);
      final loaded = await datasource.loadGame();

      expect(loaded.id, GameFixtures.playingGameModel.id);
      expect(loaded.score, GameFixtures.playingGameModel.score);
      expect(loaded.state, GameFixtures.playingGameModel.state);
    });

    test('persists and retrieves level state', () async {
      SharedPreferences.setMockInitialValues({});
      final datasource = GameLocalDataSource();

      await datasource.saveLevel(GameFixtures.levelOneModel);
      final loaded = await datasource.loadLevel(1);

      expect(loaded.number, 1);
      expect(loaded.name, 'Neon Drift');
      expect(loaded.baseScore, 1000);
    });
  });

  group('GameRemoteDataSource', () {
    test('fetches a game model from the API', () async {
      final datasource = GameRemoteDataSource(client: _MockGameHttpClient());

      final game = await datasource.fetchGame();

      expect(game.id, 'game_001');
      expect(game.score, 1200);
      expect(game.bestScore, 1800);
    });

    test('fetches a level model from the API', () async {
      final datasource = GameRemoteDataSource(client: _MockGameHttpClient());

      final level = await datasource.fetchLevel(1);

      expect(level.number, 1);
      expect(level.name, 'Neon Drift');
      expect(level.speed, 180);
    });

    test('syncs game state without throwing', () async {
      final datasource = GameRemoteDataSource(client: _MockGameHttpClient());

      await datasource.syncGame(GameFixtures.defaultGameModel);

      expect(true, isTrue);
    });
  });
}
