import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesStorage {
  SharedPreferencesStorage._();

  static SharedPreferencesStorage? _instance;

  static Future<SharedPreferencesStorage> getInstance() async {
    _instance ??= SharedPreferencesStorage._();
    await _instance!._initialize();
    return _instance!;
  }

  SharedPreferences? _preferences;

  Future<void> _initialize() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> setString(String key, String value) async {
    await _initialize();
    await _preferences!.setString(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await _initialize();
    await _preferences!.setBool(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await _initialize();
    await _preferences!.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await _initialize();
    await _preferences!.setDouble(key, value);
  }

  Future<void> setStringList(String key, List<String> value) async {
    await _initialize();
    await _preferences!.setStringList(key, value);
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

  Future<bool> remove(String key) async {
    await _initialize();
    return _preferences!.remove(key);
  }

  Future<bool> clear() async {
    await _initialize();
    return _preferences!.clear();
  }
}
