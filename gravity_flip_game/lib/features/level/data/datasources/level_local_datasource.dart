import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/level_data_model.dart';

abstract class LevelLocalDataSource {
  Future<List<LevelDataModel>> getAllLevels();
  Future<LevelDataModel> getLevel(String id);
  Future<void> saveLevel(LevelDataModel model);
  Future<void> saveLevels(List<LevelDataModel> models);
}

class LevelLocalDataSourceImpl implements LevelLocalDataSource {
  LevelLocalDataSourceImpl({this._preferences});

  final SharedPreferences? _preferences;
  static const String _storageKey = 'gravity_flip_levels';

  Future<SharedPreferences> get _prefs async =>
      _preferences ?? await SharedPreferences.getInstance();

  @override
  Future<List<LevelDataModel>> getAllLevels() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_storageKey);

    if (raw == null || raw.isEmpty) {
      final defaults = _defaultLevels();
      await saveLevels(defaults);
      return defaults;
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map(
          (e) => LevelDataModel.fromJson(Map<String, dynamic>.from(e as Map)),
        )
        .toList();
  }

  @override
  Future<LevelDataModel> getLevel(String id) async {
    final levels = await getAllLevels();
    return levels.firstWhere(
      (level) => level.id == id,
      orElse: () => levels.first,
    );
  }

  @override
  Future<void> saveLevel(LevelDataModel model) async {
    final levels = await getAllLevels();
    final updated = levels
        .map((level) => level.id == model.id ? model : level)
        .toList();
    await saveLevels(updated);
  }

  @override
  Future<void> saveLevels(List<LevelDataModel> models) async {
    final prefs = await _prefs;
    final payload = jsonEncode(models.map((e) => e.toJson()).toList());
    await prefs.setString(_storageKey, payload);
  }

  List<LevelDataModel> _defaultLevels() {
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
      const LevelDataModel(
        id: 'level_3',
        number: 3,
        name: 'Gravity Rift',
        difficulty: 'hard',
        description: 'Fast pattern transitions and sharper reactions.',
        goal: 'Score enough points before the timer expires.',
        targetScore: 8000,
        requiredStars: 2,
        isUnlocked: false,
        bestScore: 0,
        stars: 0,
      ),
      const LevelDataModel(
        id: 'level_4',
        number: 4,
        name: 'Void Pulse',
        difficulty: 'expert',
        description: 'A high-risk challenge for advanced players.',
        goal: 'Clear every obstacle and finish with maximum score.',
        targetScore: 12000,
        requiredStars: 3,
        isUnlocked: false,
        bestScore: 0,
        stars: 0,
      ),
    ];
  }
}
