class Validators {
  Validators._();

  static String? validateNonEmpty(String? value, {String fieldName = 'Field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required.';
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required.';
    }
    final emailRegexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegexp.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required.';
    }
    if (value.length < 8) {
      return 'Password must contain at least 8 characters.';
    }
    return null;
  }

  static String? validateNumberRange(
    num? value, {
    required num min,
    required num max,
    String fieldName = 'Value',
  }) {
    if (value == null) {
      return '$fieldName is required.';
    }
    if (value < min || value > max) {
      return '$fieldName must be between $min and $max.';
    }
    return null;
  }
}
