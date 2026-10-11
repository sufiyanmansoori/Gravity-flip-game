import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/game_model.dart';
import '../models/level_model.dart';
import 'abstractions/remote_datasource.dart';

class GameRemoteDataSource implements RemoteDataSource {
  GameRemoteDataSource({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;

  static const String _baseUrl = 'https://api.gravityflipgame.com';

  @override
  Future<GameModel> fetchGame() async {
    final response = await _client.get(Uri.parse('$_baseUrl/game'));
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch remote game state');
    }
    return GameModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<LevelModel> fetchLevel(int levelNumber) async {
    final response = await _client.get(
      Uri.parse('$_baseUrl/levels/$levelNumber'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to fetch remote level');
    }
    return LevelModel.fromJson(jsonDecode(response.body));
  }

  @override
  Future<void> syncGame(GameModel model) async {
    final response = await _client.post(
      Uri.parse('$_baseUrl/game/sync'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Failed to sync game state');
    }
  }
}
