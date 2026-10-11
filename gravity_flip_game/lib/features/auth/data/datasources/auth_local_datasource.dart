import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDataSource {
  AuthLocalDataSource({this._preferences});

  final SharedPreferences? _preferences;
  static const String _sessionKey = 'gravity_flip_auth_session';

  Future<SharedPreferences> get _prefs async =>
      _preferences ?? await SharedPreferences.getInstance();

  Future<Map<String, dynamic>?> getSession() async {
    final prefs = await _prefs;
    final raw = prefs.getString(_sessionKey);
    if (raw == null || raw.isEmpty) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } catch (_) {}

    return null;
  }

  Future<void> saveSession(Map<String, dynamic> session) async {
    final prefs = await _prefs;
    await prefs.setString(_sessionKey, jsonEncode(session));
  }

  Future<void> clearSession() async {
    final prefs = await _prefs;
    await prefs.remove(_sessionKey);
  }
}
