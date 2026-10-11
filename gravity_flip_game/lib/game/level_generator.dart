class LevelConfig {
  final int worldIndex;
  final int levelNumber;
  final String worldName;
  final String levelName;
  final double baseSpeed;
  final double gravityStrength;
  final double spawnInterval;

  const LevelConfig({
    required this.worldIndex,
    required this.levelNumber,
    required this.worldName,
    required this.levelName,
    required this.baseSpeed,
    required this.gravityStrength,
    required this.spawnInterval,
  });
}

class WorldDefinition {
  final int index;
  final String name;
  final String subtitle;
  final int totalLevels;

  const WorldDefinition({
    required this.index,
    required this.name,
    required this.subtitle,
    required this.totalLevels,
  });
}

class LevelGenerator {
  static const int worldCount = 6;
  static const int levelsPerWorld = 20;

  static List<WorldDefinition> generateWorlds() {
    const worldNames = [
      'Gravity Valley',
      'Neon Factory',
      'Crystal Rift',
      'Cyber Pulse',
      'Orbital Drift',
      'Void Echo',
    ];

    return List.generate(worldCount, (index) {
      return WorldDefinition(
        index: index + 1,
        name: worldNames[index],
        subtitle: 'World ${index + 1}',
        totalLevels: levelsPerWorld,
      );
    });
  }

  static LevelConfig generateLevel(int worldIndex, int levelNumber) {
    final safeWorld = worldIndex.clamp(1, worldCount);
    final safeLevel = levelNumber.clamp(1, levelsPerWorld);
    final difficulty = (safeWorld - 1) * 0.2 + (safeLevel / levelsPerWorld) * 1.2;
    final world = generateWorlds()[safeWorld - 1];
    final name = 'L${safeLevel.toString().padLeft(2, '0')}';
    return LevelConfig(
      worldIndex: safeWorld,
      levelNumber: safeLevel,
      worldName: world.name,
      levelName: '$name • ${world.subtitle}',
      baseSpeed: 150 + difficulty * 90,
      gravityStrength: 1400 + difficulty * 190,
      spawnInterval: 1.15 - difficulty * 0.18,
    );
  }
}
