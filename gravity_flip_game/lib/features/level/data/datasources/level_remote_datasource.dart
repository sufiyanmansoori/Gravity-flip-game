import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/level_data_model.dart';

abstract class LevelRemoteDataSource {
  Future<List<LevelDataModel>> fetchLevels();
}

class LevelRemoteDataSourceImpl implements LevelRemoteDataSource {
  LevelRemoteDataSourceImpl({http.Client? client})
    : _client = client ?? http.Client();

  final http.Client _client;
  static const String _endpoint = 'https://example.com/api/levels';

  @override
  Future<List<LevelDataModel>> fetchLevels() async {
    final response = await _client.get(Uri.parse(_endpoint));
    if (response.statusCode != 200) {
      return _fallbackLevels();
    }

    final decoded = jsonDecode(response.body) as List<dynamic>;
    return decoded
        .map(
          (entry) =>
              LevelDataModel.fromJson(Map<String, dynamic>.from(entry as Map)),
        )
        .toList();
  }

  List<LevelDataModel> _fallbackLevels() {
    return [
      const LevelDataModel(
        id: 'level_1',
        number: 1,
        name: 'Neon Drift',
        difficulty: 'easy',
        description: 'Warm up with a short gravity challenge.',
        goal: 'Collect coins and finish the level in time.',
        targetScore: 2500,
        requiredStars: 0,
        isUnlocked: true,
        bestScore: 0,
        stars: 0,
      ),
      const LevelDataModel(
        id: 'level_2',
        number: 2,
        name: 'Skyline Switch',
        difficulty: 'normal',
        description: 'Improve your timing and rhythm.',
        goal: 'Reach the checkpoint without losing momentum.',
        targetScore: 5000,
        requiredStars: 1,
        isUnlocked: false,
        bestScore: 0,
        stars: 0,
      ),
    ];
  }
}
