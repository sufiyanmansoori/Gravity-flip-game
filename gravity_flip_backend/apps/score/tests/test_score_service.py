from django.test import TestCase

from apps.level.models import Difficulty, Level
from apps.score.models import Score, UserScoreStats
from apps.score.services.score_service import ScoreService
from apps.users.models import User


class ScoreServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', email='pilot@example.com', password='Strong-password-123')
        difficulty = Difficulty.objects.create(code='easy', name='Easy', rank=1)
        self.level = Level.objects.create(slug='tutorial', title='Tutorial', difficulty=difficulty, status=Level.Status.PUBLISHED)

    def test_score_is_idempotent_and_updates_stats(self):
        first, created = ScoreService.save(user=self.user, level=self.level, value=250, idempotency_key='run-1', stars=2)
        duplicate, duplicate_created = ScoreService.save(user=self.user, level=self.level, value=250, idempotency_key='run-1', stars=2)
        self.assertTrue(created)
        self.assertFalse(duplicate_created)
        self.assertEqual(first.pk, duplicate.pk)
        self.assertEqual(Score.objects.count(), 1)
        self.assertEqual(UserScoreStats.objects.get(user=self.user).total_submissions, 1)

    def test_idempotency_key_cannot_change_score(self):
        ScoreService.save(user=self.user, level=self.level, value=250, idempotency_key='run-1')
        with self.assertRaises(ValueError):
            ScoreService.save(user=self.user, level=self.level, value=300, idempotency_key='run-1')