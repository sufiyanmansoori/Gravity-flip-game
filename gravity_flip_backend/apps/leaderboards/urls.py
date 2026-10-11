from __future__ import annotations

from django.urls import path

from .views import ChallengeAttemptListView, DailyChallengeListView, submit_challenge_attempt

urlpatterns = [
    path('daily/', DailyChallengeListView.as_view(), name='daily-challenges'),
    path('attempts/', ChallengeAttemptListView.as_view(), name='challenge-attempts'),
    path('submit/', submit_challenge_attempt, name='submit-challenge-attempt'),
]
