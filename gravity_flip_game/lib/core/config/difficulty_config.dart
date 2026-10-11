class DifficultyConfig {
  const DifficultyConfig._();

  static const Map<String, dynamic> easy = {
    'label': 'Easy',
    'gravityMultiplier': 1.0,
    'speedMultiplier': 1.0,
    'gapMultiplier': 1.0,
    'spawnIntervalMs': 1600,
    'lives': 3,
  };

  static const Map<String, dynamic> normal = {
    'label': 'Normal',
    'gravityMultiplier': 1.1,
    'speedMultiplier': 1.15,
    'gapMultiplier': 0.95,
    'spawnIntervalMs': 1450,
    'lives': 3,
  };

  static const Map<String, dynamic> hard = {
    'label': 'Hard',
    'gravityMultiplier': 1.25,
    'speedMultiplier': 1.3,
    'gapMultiplier': 0.9,
    'spawnIntervalMs': 1300,
    'lives': 2,
  };

  static const Map<String, dynamic> insane = {
    'label': 'Insane',
    'gravityMultiplier': 1.45,
    'speedMultiplier': 1.5,
    'gapMultiplier': 0.8,
    'spawnIntervalMs': 1150,
    'lives': 1,
  };

  static const List<Map<String, dynamic>> presets = [
    easy,
    normal,
    hard,
    insane,
  ];
}
