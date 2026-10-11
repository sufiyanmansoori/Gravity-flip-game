from __future__ import annotations

from django.urls import path

from .views import (
    AchievementListView,
    GameLevelDetailView,
    GameLevelListView,
    GameSessionDetailView,
    GameSessionListView,
    LeaderboardView,
    UserAchievementListView,
    game_stats,
    submit_score,
)

urlpatterns = [
    path('levels/', GameLevelListView.as_view(), name='game-level-list'),
    path('levels/<int:pk>/', GameLevelDetailView.as_view(), name='game-level-detail'),
    path('sessions/', GameSessionListView.as_view(), name='game-session-list'),
    path('sessions/<int:pk>/', GameSessionDetailView.as_view(), name='game-session-detail'),
    path('leaderboard/', LeaderboardView.as_view(), name='game-leaderboard'),
    path('achievements/', AchievementListView.as_view(), name='achievement-list'),
    path('my-achievements/', UserAchievementListView.as_view(), name='user-achievement-list'),
    path('stats/', game_stats, name='game-stats'),
    path('submit-score/', submit_score, name='submit-score'),
]
