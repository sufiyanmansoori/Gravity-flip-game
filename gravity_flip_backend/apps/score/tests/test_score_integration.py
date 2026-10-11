from django.test import TestCase
from rest_framework.test import APIClient

from apps.level.models import Difficulty, Level
from apps.users.models import User


class ScoreIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        difficulty = Difficulty.objects.create(code='easy', name='Easy', rank=1)
        self.level = Level.objects.create(slug='tutorial', title='Tutorial', difficulty=difficulty, status=Level.Status.PUBLISHED)
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    def test_save_score_endpoint(self):
        response = self.client.post('/api/v1/scores/', {'level': str(self.level.pk), 'value': 500, 'idempotency_key': 'api-run-1'}, format='json')
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.data['value'], 500)

    def test_stats_endpoint(self):
        response = self.client.get('/api/v1/scores/stats/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['total_submissions'], 0)