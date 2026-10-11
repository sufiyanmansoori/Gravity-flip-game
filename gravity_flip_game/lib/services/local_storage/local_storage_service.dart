import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  LocalStorageService._();

  static LocalStorageService? _instance;

  static Future<LocalStorageService> getInstance() async {
    _instance ??= LocalStorageService._();
    await _instance!._ensureReady();
    return _instance!;
  }

  SharedPreferences? _preferences;

  Future<void> _ensureReady() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _ensureReady();
    await _preferences!.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _ensureReady();
    await _preferences!.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _ensureReady();
    await _preferences!.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _ensureReady();
    await _preferences!.setDouble(key, value);
  }

  Future<void> setStringList(String key, List<String> values) async {
    await _ensureReady();
    await _preferences!.setStringList(key, values);
  }

  Future<void> setJson(String key, Map<String, dynamic> value) async {
    await setString(key, jsonEncode(value));
  }

  Future<void> setJsonList(
    String key,
    List<Map<String, dynamic>> values,
  ) async {
    await setString(key, jsonEncode(values));
  }

  String? getString(String key) {
    return _preferences?.getString(key);
  }

  bool? getBool(String key) {
    return _preferences?.getBool(key);
  }

  int? getInt(String key) {
    return _preferences?.getInt(key);
  }

  double? getDouble(String key) {
    return _preferences?.getDouble(key);
  }

  List<String>? getStringList(String key) {
    return _preferences?.getStringList(key);
  }

  Map<String, dynamic>? getJson(String key) {
    final raw = getString(key);
    if (raw == null) return null;

    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } on FormatException {
      return null;
    }
  }

  List<Map<String, dynamic>>? getJsonList(String key) {
    final raw = getString(key);
    if (raw == null) return null;

    try {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded
            .map((item) => Map<String, dynamic>.from(item as Map))
            .toList();
      }
      return null;
    } on FormatException {
      return null;
    }
  }

  Future<bool> remove(String key) async {
    await _ensureReady();
    return _preferences!.remove(key);
  }

  Future<bool> clear() async {
    await _ensureReady();
    return _preferences!.clear();
  }
}
