extension StringExtensions on String {
  String get trimToNullIfEmpty => trim().isEmpty ? '' : trim();

  bool get isValidEmail {
    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    return regex.hasMatch(this);
  }

  bool get isNumeric => double.tryParse(this) != null;

  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  String get capitalizeWords {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalize).join(' ');
  }
}
