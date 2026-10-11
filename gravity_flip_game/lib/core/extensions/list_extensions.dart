extension ListExtensions<T> on List<T> {
  T? firstOrNullWhere(bool Function(T element) predicate) {
    for (final item in this) {
      if (predicate(item)) return item;
    }
    return null;
  }

  List<T> uniqueBy(Object Function(T item) keySelector) {
    final seen = <Object>{};
    final result = <T>[];

    for (final item in this) {
      final key = keySelector(item);
      if (!seen.contains(key)) {
        seen.add(key);
        result.add(item);
      }
    }

    return result;
  }

  List<T> get shuffledCopy => [...this]..shuffle();
}
