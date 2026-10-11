class GameException implements Exception {
  const GameException(this.message, {this.code});

  final String message;
  final String? code;

  @override
  String toString() => 'GameException(${code ?? 'unknown'}): $message';
}

class GameInitializationException extends GameException {
  const GameInitializationException(super.message, {super.code});
}

class InvalidGameStateException extends GameException {
  const InvalidGameStateException(super.message, {super.code});
}

class PhysicsException extends GameException {
  const PhysicsException(super.message, {super.code});
}

class LevelLoadException extends GameException {
  const LevelLoadException(super.message, {super.code});
}
