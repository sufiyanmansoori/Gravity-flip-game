import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_local_datasource.dart';
import 'package:gravity_flip_game/features/game/data/datasources/game_remote_datasource.dart';
import 'package:gravity_flip_game/features/game/data/models/game_model.dart';
import 'package:gravity_flip_game/features/game/data/models/level_model.dart';
import 'package:gravity_flip_game/features/game/domain/entities/game_entity.dart';
import 'package:gravity_flip_game/features/game/domain/value_objects/game_state.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MockGameLocalDataSource extends GameLocalDataSource {
  MockGameLocalDataSource({super.preferences});

  GameModel? storedGame;
  LevelModel? storedLevel;

  @override
  Future<GameModel> loadGame() async =>
      storedGame ??
      const GameModel(
        id: 'game_test',
        score: 0,
        bestScore: 0,
        lives: 3,
        currentLevel: 1,
        state: GameState.ready,
      );

  @override
  Future<LevelModel> loadLevel(int levelNumber) async =>
      storedLevel ??
      LevelModel(
        number: levelNumber,
        name: 'Mock Level',
        difficulty: 'normal',
        speed: 180,
        gravity: 1800,
        obstacles: const [],
        collectibles: const [],
        baseScore: 0,
      );

  @override
  Future<void> saveGame(GameModel model) async {
    storedGame = model;
  }

  @override
  Future<void> saveLevel(LevelModel model) async {
    storedLevel = model;
  }

  @override
  Future<GameState> getCurrentState() async =>
      storedGame?.state ?? GameState.ready;

  @override
  Future<void> saveCurrentState(GameState state) async {
    storedGame =
        (storedGame ??
                const GameModel(
                  id: 'game_test',
                  score: 0,
                  bestScore: 0,
                  lives: 3,
                  currentLevel: 1,
                  state: GameState.ready,
                ))
            .copyWith(state: state);
  }
}

class MockGameRemoteDataSource extends GameRemoteDataSource {
  MockGameRemoteDataSource() : super(client: _MockHttpClient());
}

class _MockHttpClient implements http.Client {
  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    return http.Response(
      '{"id":"game_test","score":0,"bestScore":0,"lives":3,"currentLevel":1,"state":"ready"}',
      200,
    );
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

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class TestNavigationObserver extends NavigatorObserver {}

Future<SharedPreferences> createTestPreferences() async {
  SharedPreferences.setMockInitialValues({});
  return SharedPreferences.getInstance();
}

class TestGameEntityFactory {
  const TestGameEntityFactory._();

  static GameEntity create({
    String id = 'game_01',
    int score = 0,
    int bestScore = 0,
    int lives = 3,
    int currentLevel = 1,
    GameState state = GameState.ready,
  }) {
    return GameEntity(
      id: id,
      score: score,
      bestScore: bestScore,
      lives: lives,
      currentLevel: currentLevel,
      state: state,
    );
  }
}
