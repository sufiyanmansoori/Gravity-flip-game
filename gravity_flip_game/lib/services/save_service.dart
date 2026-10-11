import 'package:shared_preferences/shared_preferences.dart';

class GameProgress {
  final int bestScore;
  final int unlockedLevel;
  final int coins;
  final int stars;

  const GameProgress({
    this.bestScore = 0,
    this.unlockedLevel = 1,
    this.coins = 0,
    this.stars = 0,
  });

  GameProgress copyWith({
    int? bestScore,
    int? unlockedLevel,
    int? coins,
    int? stars,
  }) {
    return GameProgress(
      bestScore: bestScore ?? this.bestScore,
      unlockedLevel: unlockedLevel ?? this.unlockedLevel,
      coins: coins ?? this.coins,
      stars: stars ?? this.stars,
    );
  }
}

class SaveService {
  static const String _bestScoreKey = 'gravity_best_score';
  static const String _unlockedLevelKey = 'gravity_unlocked_level';
  static const String _coinsKey = 'gravity_coins';
  static const String _starsKey = 'gravity_stars';

  Future<GameProgress> load() async {
    final prefs = await SharedPreferences.getInstance();
    return GameProgress(
      bestScore: prefs.getInt(_bestScoreKey) ?? 0,
      unlockedLevel: prefs.getInt(_unlockedLevelKey) ?? 1,
      coins: prefs.getInt(_coinsKey) ?? 0,
      stars: prefs.getInt(_starsKey) ?? 0,
    );
  }

  Future<void> save(GameProgress progress) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_bestScoreKey, progress.bestScore);
    await prefs.setInt(_unlockedLevelKey, progress.unlockedLevel);
    await prefs.setInt(_coinsKey, progress.coins);
    await prefs.setInt(_starsKey, progress.stars);
  }
}
