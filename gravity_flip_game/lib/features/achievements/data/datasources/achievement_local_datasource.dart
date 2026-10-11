import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AchievementLocalDataSource {
  AchievementLocalDataSource({this._preferences});

  final SharedPreferences? _preferences;
  static const String _storageKey = 'gravity_flip_achievements';

  Future<SharedPreferences> get _prefs async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<List<Map<String, dynamic>>> loadAchievements() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return _defaultAchievements();
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return _defaultAchievements();
      }

      return decoded
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();
    } catch (_) {
      return _defaultAchievements();
    }
  }

  Future<void> saveAchievements(List<Map<String, dynamic>> achievements) async {
    final prefs = await _prefs;
    await prefs.setString(_storageKey, jsonEncode(achievements));
  }

  List<Map<String, dynamic>> _defaultAchievements() {
    final now = DateTime.now();
    return [
      {
        'id': 'first_launch',
        'title': 'First Launch',
        'description': 'Open the game for the first time.',
        'icon': '🚀',
        'category': 'general',
        'progress': 1,
        'target': 1,
        'isUnlocked': true,
        'unlockedAt': now.toIso8601String(),
        'rarity': 'common',
        'createdAt': now.toIso8601String(),
      },
      {
        'id': 'level_master',
        'title': 'Level Master',
        'description': 'Complete 5 levels with a 3-star rating.',
        'icon': '🏅',
        'category': 'progression',
        'progress': 0,
        'target': 5,
        'isUnlocked': false,
        'rarity': 'rare',
        'createdAt': now.toIso8601String(),
      },
    ];
  }
}
