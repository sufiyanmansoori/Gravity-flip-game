from django.test import TestCase

from apps.level.models import Difficulty, Level
from apps.score.models import LeaderboardEntry
from apps.score.services.score_service import ScoreService
from apps.users.models import User


class LeaderboardServiceTests(TestCase):
    def setUp(self):
        difficulty = Difficulty.objects.create(code='easy', name='Easy', rank=1)
        self.level = Level.objects.create(slug='tutorial', title='Tutorial', difficulty=difficulty, status=Level.Status.PUBLISHED)
        self.first = User.objects.create_user(username='first', password='Strong-password-123')
        self.second = User.objects.create_user(username='second', password='Strong-password-123')

    def test_entries_are_ranked_by_best_score(self):
        ScoreService.save(user=self.second, level=self.level, value=100, idempotency_key='second-1')
        ScoreService.save(user=self.first, level=self.level, value=300, idempotency_key='first-1')
        entries = list(LeaderboardEntry.objects.filter(level=self.level).order_by('rank'))
        self.assertEqual([(entry.rank, entry.user.username) for entry in entries], [(1, 'first'), (2, 'second')])