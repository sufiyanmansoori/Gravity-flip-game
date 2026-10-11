class GameConstants {
  GameConstants._();

  static const double gravity = 1800;
  static const double jumpVelocity = -620;
  static const double worldWidth = 360;
  static const double worldHeight = 640;
  static const double baseScrollSpeed = 180;
  static const double maxScrollSpeed = 420;
  static const double playerRadius = 18;
  static const double obstacleWidth = 64;
  static const double obstacleGap = 150;
  static const double gapVariance = 32;
  static const double safeZone = 110;
  static const int initialLives = 3;
  static const int maxCombo = 20;
  static const int pointsPerObstacle = 10;
  static const int levelProgressGoal = 1000;

  static const List<double> difficultyRamp = [
    1.0,
    1.15,
    1.3,
    1.45,
    1.65,
    1.9,
    2.2,
  ];

  static const Map<String, dynamic> defaultLevelConfig = {
    'gravity': gravity,
    'jumpVelocity': jumpVelocity,
    'scrollSpeed': baseScrollSpeed,
    'obstacleGap': obstacleGap,
    'spawnInterval': 1.5,
  };
}
