import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NotificationLocalDataSource {
  const NotificationLocalDataSource({required this._preferences});

  final SharedPreferences _preferences;

  static const String _queueKey = 'notifications_queue';

  Future<void> saveQueuedNotification(Map<String, dynamic> notification) async {
    final current = _preferences.getStringList(_queueKey) ?? <String>[];
    final next = [...current, jsonEncode(notification)];
    await _preferences.setStringList(_queueKey, next);
  }

  Future<List<Map<String, dynamic>>> loadQueuedNotifications() async {
    final raw = _preferences.getStringList(_queueKey) ?? const <String>[];
    final items = <Map<String, dynamic>>[];

    for (final item in raw) {
      try {
        final decoded = jsonDecode(item);
        if (decoded is Map) {
          items.add(Map<String, dynamic>.from(decoded));
        }
      } catch (_) {
        continue;
      }
    }

    return items;
  }

  Future<void> clearQueuedNotifications() async {
    await _preferences.remove(_queueKey);
  }
}
