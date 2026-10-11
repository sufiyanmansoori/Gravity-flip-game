import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ScoreLocalDataSource {
  ScoreLocalDataSource({this._preferences});

  final SharedPreferences? _preferences;
  static const String _storageKey = 'gravity_flip_scores';

  Future<SharedPreferences> get _prefs async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<List<Map<String, dynamic>>> loadScores() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_storageKey);
    if (raw == null || raw.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((entry) => Map<String, dynamic>.from(entry as Map))
        .toList();
  }

  Future<void> saveScores(List<Map<String, dynamic>> scores) async {
    final prefs = await _prefs;
    await prefs.setString(_storageKey, jsonEncode(scores));
  }
}
