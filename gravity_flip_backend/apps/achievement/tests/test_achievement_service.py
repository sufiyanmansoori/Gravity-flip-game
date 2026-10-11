from django.test import TestCase
from rest_framework.test import APIClient

from apps.achievement.models import Achievement, AchievementReward, UserAchievement
from apps.achievement.services.achievement_unlock_service import AchievementUnlockService
from apps.level.models import Difficulty, Level
from apps.score.models import UserScoreStats
from apps.users.models import User


class AchievementServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        self.achievement = Achievement.objects.create(code='score-hunter', name='Score Hunter', points=10, criteria={'total_score': 1000})
        AchievementReward.objects.create(achievement=self.achievement, reward_type='points', amount=10)

    def test_unlock_requires_stats_and_is_idempotent(self):
        UserScoreStats.objects.create(user=self.user, total_score=1000)
        first, created, rewards = AchievementUnlockService.unlock(user=self.user, achievement=self.achievement)
        second, duplicate, _ = AchievementUnlockService.unlock(user=self.user, achievement=self.achievement)
        self.assertTrue(created)
        self.assertFalse(duplicate)
        self.assertEqual(first.pk, second.pk)
        self.assertEqual(len(rewards), 1)
        self.assertEqual(UserAchievement.objects.count(), 1)

    def test_unlock_rejects_unmet_criteria(self):
        UserScoreStats.objects.create(user=self.user, total_score=999)
        with self.assertRaises(ValueError):
            AchievementUnlockService.unlock(user=self.user, achievement=self.achievement)


class AchievementIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        self.achievement = Achievement.objects.create(code='first-flight', name='First Flight', criteria={})
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    def test_sync_unlocks_eligible_achievement(self):
        response = self.client.post('/api/v1/achievements/sync/', format='json')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['unlocked'][0]['achievement'], 'first-flight')

    def test_mine_lists_unlocks(self):
        self.client.post('/api/v1/achievements/sync/', format='json')
        response = self.client.get('/api/v1/achievements/mine/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data[0]['achievement'], 'first-flight')