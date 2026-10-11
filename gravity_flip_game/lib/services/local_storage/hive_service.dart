import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static final HiveService _instance = HiveService._();

  factory HiveService() => _instance;

  Box<dynamic>? _box;

  Future<void> initialize() async {
    if (Hive.isBoxOpen('gravity_flip_game')) {
      _box = Hive.box('gravity_flip_game');
      return;
    }

    await Hive.initFlutter();
    _box = await Hive.openBox<dynamic>('gravity_flip_game');
  }

  Future<void> put<T>(String key, T value) async {
    await _box?.put(key, value);
  }

  T? get<T>(String key, {T? defaultValue}) {
    return _box?.get(key, defaultValue: defaultValue) as T?;
  }

  Future<void> delete(String key) async {
    await _box?.delete(key);
  }

  Future<void> clear() async {
    await _box?.clear();
  }

  Future<void> close() async {
    await _box?.close();
    _box = null;
  }

  bool get isReady => _box != null;
}
