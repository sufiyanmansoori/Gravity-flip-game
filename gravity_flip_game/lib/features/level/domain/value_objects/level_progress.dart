class LevelProgress {
  const LevelProgress({
    required this.completed,
    required this.highestStars,
    required this.bestScore,
    required this.unlocked,
  });

  final bool completed;
  final int highestStars;
  final int bestScore;
  final bool unlocked;

  int get percentage =>
      highestStars == 0 && !completed ? 0 : (highestStars * 33).clamp(0, 100);

  LevelProgress copyWith({
    bool? completed,
    int? highestStars,
    int? bestScore,
    bool? unlocked,
  }) {
    return LevelProgress(
      completed: completed ?? this.completed,
      highestStars: highestStars ?? this.highestStars,
      bestScore: bestScore ?? this.bestScore,
      unlocked: unlocked ?? this.unlocked,
    );
  }
}
