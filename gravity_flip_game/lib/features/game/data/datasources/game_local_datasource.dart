import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/game_model.dart';
import '../models/level_model.dart';
import '../../domain/value_objects/game_state.dart';
import 'abstractions/local_datasource.dart';

class GameLocalDataSource implements LocalDataSource {
  GameLocalDataSource({this._preferences});
  final SharedPreferences? _preferences;

  static const String _gameKey = 'game_state';
  static const String _levelPrefix = 'level_';
  static const String _currentStateKey = 'current_game_state';

  @override
  Future<GameModel> loadGame() async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    final raw = prefs.getString(_gameKey);
    if (raw == null || raw.isEmpty) {
      return const GameModel(
        id: 'default_game',
        score: 0,
        bestScore: 0,
        lives: 3,
        currentLevel: 1,
        state: GameState.ready,
      );
    }

    return GameModel.fromJson(jsonDecode(raw));
  }

  @override
  Future<LevelModel> loadLevel(int levelNumber) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    final raw = prefs.getString('$_levelPrefix$levelNumber');
    if (raw == null || raw.isEmpty) {
      return LevelModel(
        number: levelNumber,
        name: 'Level $levelNumber',
        difficulty: 'normal',
        speed: 180,
        gravity: 1800,
        obstacles: const [],
        collectibles: const [],
        baseScore: 0,
      );
    }

    return LevelModel.fromJson(jsonDecode(raw));
  }

  @override
  Future<void> saveGame(GameModel model) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    await prefs.setString(_gameKey, jsonEncode(model.toJson()));
  }

  @override
  Future<void> saveLevel(LevelModel model) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    await prefs.setString(
      '$_levelPrefix${model.number}',
      jsonEncode(model.toJson()),
    );
  }

  @override
  Future<GameState> getCurrentState() async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    final value = prefs.getString(_currentStateKey);
    return GameState.values.firstWhere(
      (state) => state.name == value,
      orElse: () => GameState.ready,
    );
  }

  @override
  Future<void> saveCurrentState(GameState state) async {
    final prefs = _preferences ?? await SharedPreferences.getInstance();
    await prefs.setString(_currentStateKey, state.name);
  }

  Future<String> getLocalFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/gravity_flip_game_state.json';
  }

  Future<void> writeJsonFile(Map<String, dynamic> data) async {
    final file = File(await getLocalFilePath());
    await file.writeAsString(jsonEncode(data));
  }
}
