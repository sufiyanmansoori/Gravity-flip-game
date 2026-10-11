import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AnalyticsLocalDataSource {
  const AnalyticsLocalDataSource({required this._preferences});

  final SharedPreferences _preferences;

  static const String _pendingEventsKey = 'analytics_pending_events';
  static const String _userIdKey = 'analytics_user_id';

  Future<void> setUserId(String? userId) async {
    if (userId == null || userId.trim().isEmpty) {
      await _preferences.remove(_userIdKey);
      return;
    }

    await _preferences.setString(_userIdKey, userId);
  }

  String? getUserId() => _preferences.getString(_userIdKey);

  Future<void> saveEvent(Map<String, dynamic> event) async {
    final existing =
        _preferences.getStringList(_pendingEventsKey) ?? <String>[];
    final updated = [...existing, jsonEncode(event)];
    await _preferences.setStringList(_pendingEventsKey, updated);
  }

  Future<List<Map<String, dynamic>>> loadPendingEvents() async {
    final raw =
        _preferences.getStringList(_pendingEventsKey) ?? const <String>[];
    final events = <Map<String, dynamic>>[];

    for (final item in raw) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map<String, dynamic>) {
          events.add(decoded);
        } else if (decoded is Map) {
          events.add(Map<String, dynamic>.from(decoded));
        }
      } catch (_) {
        continue;
      }
    }

    return events;
  }

  Future<void> clearPendingEvents() async {
    await _preferences.remove(_pendingEventsKey);
  }
}
