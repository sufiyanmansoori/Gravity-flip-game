class CacheEntry<T> {
  CacheEntry({required this.value, required this.expiresAt});

  final T value;
  final DateTime expiresAt;

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class CacheService {
  CacheService();

  final Map<String, CacheEntry<dynamic>> _cache = {};

  void put<T>(
    String key,
    T value, {
    Duration ttl = const Duration(minutes: 10),
  }) {
    _cache[key] = CacheEntry<dynamic>(
      value: value,
      expiresAt: DateTime.now().add(ttl),
    );
  }

  T? get<T>(String key) {
    final entry = _cache[key];
    if (entry == null) return null;
    if (entry.isExpired) {
      _cache.remove(key);
      return null;
    }
    return entry.value as T?;
  }

  bool contains(String key) =>
      _cache.containsKey(key) && !(_cache[key]?.isExpired ?? true);

  void remove(String key) => _cache.remove(key);

  void clear() => _cache.clear();

  void invalidateExpired() {
    final expiredKeys = _cache.entries
        .where((entry) => entry.value.isExpired)
        .map((entry) => entry.key)
        .toList();

    for (final key in expiredKeys) {
      _cache.remove(key);
    }
  }
}
