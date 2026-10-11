abstract class AppException implements Exception {
  const AppException(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() => 'AppException(${code ?? 'unknown'}): $message';
}

class ConfigurationException extends AppException {
  const ConfigurationException(super.message, {super.code, super.cause});
}

class StorageException extends AppException {
  const StorageException(super.message, {super.code, super.cause});
}

class NetworkException extends AppException {
  const NetworkException(super.message, {super.code, super.cause});
}

class ValidationException extends AppException {
  const ValidationException(super.message, {super.code, super.cause});
}

class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code, super.cause});
}
