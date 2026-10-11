class AchievementService {
  static const List<AchievementDefinition> defaultAchievements = [
    AchievementDefinition(
      title: 'First Flip',
      description: 'Tap to reverse gravity for the first time.',
      icon: 'touch_app',
      target: 1,
    ),
    AchievementDefinition(
      title: '100 Points',
      description: 'Reach 100 points in a single run.',
      icon: 'score',
      target: 100,
    ),
    AchievementDefinition(
      title: '500 Points',
      description: 'Reach 500 points in a single run.',
      icon: 'rocket',
      target: 500,
    ),
    AchievementDefinition(
      title: 'Gravity Master',
      description: 'Beat level 10.',
      icon: 'auto_awesome',
      target: 10,
    ),
  ];

  static List<AchievementProgress> buildProgress({int flips = 1, int score = 0, int level = 1}) {
    final progress = <AchievementProgress>[];
    progress.add(AchievementProgress(
      title: defaultAchievements[0].title,
      description: defaultAchievements[0].description,
      icon: defaultAchievements[0].icon,
      current: flips.clamp(0, defaultAchievements[0].target),
      target: defaultAchievements[0].target,
      unlocked: flips >= defaultAchievements[0].target,
    ));
    progress.add(AchievementProgress(
      title: defaultAchievements[1].title,
      description: defaultAchievements[1].description,
      icon: defaultAchievements[1].icon,
      current: score.clamp(0, defaultAchievements[1].target),
      target: defaultAchievements[1].target,
      unlocked: score >= defaultAchievements[1].target,
    ));
    progress.add(AchievementProgress(
      title: defaultAchievements[2].title,
      description: defaultAchievements[2].description,
      icon: defaultAchievements[2].icon,
      current: score.clamp(0, defaultAchievements[2].target),
      target: defaultAchievements[2].target,
      unlocked: score >= defaultAchievements[2].target,
    ));
    progress.add(AchievementProgress(
      title: defaultAchievements[3].title,
      description: defaultAchievements[3].description,
      icon: defaultAchievements[3].icon,
      current: level.clamp(0, defaultAchievements[3].target),
      target: defaultAchievements[3].target,
      unlocked: level >= defaultAchievements[3].target,
    ));
    return progress;
  }
}

class AchievementDefinition {
  final String title;
  final String description;
  final String icon;
  final int target;

  const AchievementDefinition({
    required this.title,
    required this.description,
    required this.icon,
    required this.target,
  });
}

class AchievementProgress {
  final String title;
  final String description;
  final String icon;
  final int current;
  final int target;
  final bool unlocked;

  const AchievementProgress({
    required this.title,
    required this.description,
    required this.icon,
    required this.current,
    required this.target,
    required this.unlocked,
  });
}
