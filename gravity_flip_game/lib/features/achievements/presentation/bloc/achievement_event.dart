part of 'achievement_bloc.dart';

abstract class AchievementEvent {
  const AchievementEvent();
}

class LoadAchievements extends AchievementEvent {
  const LoadAchievements();
}

class UnlockAchievement extends AchievementEvent {
  const UnlockAchievement(this.achievementId);

  final String achievementId;
}

class RefreshAchievements extends AchievementEvent {
  const RefreshAchievements();
}
