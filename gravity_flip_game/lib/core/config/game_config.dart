class GameConfig {
  const GameConfig({
    this.gravity = 1800,
    this.jumpVelocity = -620,
    this.scrollSpeed = 180,
    this.obstacleGap = 150,
    this.gapVariance = 32,
    this.playerRadius = 18,
    this.spawnEveryMs = 1450,
    this.maxLives = 3,
    this.maxSpeed = 420,
    this.difficultyCurve = 1.0,
    this.enableParticles = true,
    this.enableShadows = true,
  });

  final double gravity;
  final double jumpVelocity;
  final double scrollSpeed;
  final double obstacleGap;
  final double gapVariance;
  final double playerRadius;
  final int spawnEveryMs;
  final int maxLives;
  final double maxSpeed;
  final double difficultyCurve;
  final bool enableParticles;
  final bool enableShadows;

  GameConfig copyWith({
    double? gravity,
    double? jumpVelocity,
    double? scrollSpeed,
    double? obstacleGap,
    double? gapVariance,
    double? playerRadius,
    int? spawnEveryMs,
    int? maxLives,
    double? maxSpeed,
    double? difficultyCurve,
    bool? enableParticles,
    bool? enableShadows,
  }) {
    return GameConfig(
      gravity: gravity ?? this.gravity,
      jumpVelocity: jumpVelocity ?? this.jumpVelocity,
      scrollSpeed: scrollSpeed ?? this.scrollSpeed,
      obstacleGap: obstacleGap ?? this.obstacleGap,
      gapVariance: gapVariance ?? this.gapVariance,
      playerRadius: playerRadius ?? this.playerRadius,
      spawnEveryMs: spawnEveryMs ?? this.spawnEveryMs,
      maxLives: maxLives ?? this.maxLives,
      maxSpeed: maxSpeed ?? this.maxSpeed,
      difficultyCurve: difficultyCurve ?? this.difficultyCurve,
      enableParticles: enableParticles ?? this.enableParticles,
      enableShadows: enableShadows ?? this.enableShadows,
    );
  }
}
