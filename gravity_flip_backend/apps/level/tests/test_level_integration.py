from django.test import TestCase
from rest_framework.test import APIClient

from apps.level.models import Difficulty, Level
from apps.users.models import User


class LevelIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='admin', email='admin@example.com', password='Strong-password-123', is_staff=True)
        self.difficulty = Difficulty.objects.create(code='easy', name='Easy', rank=1)
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    def test_admin_can_create_and_publish_level(self):
        response = self.client.post('/api/v1/levels/', {'slug': 'tutorial', 'title': 'Tutorial', 'difficulty': self.difficulty.pk, 'configuration': {'starting_gravity': 1}}, format='json')
        self.assertEqual(response.status_code, 201)
        publish = self.client.post('/api/v1/levels/tutorial/publish/', format='json')
        self.assertEqual(publish.status_code, 200)
        self.assertEqual(Level.objects.get(slug='tutorial').status, Level.Status.PUBLISHED)

    def test_public_list_hides_drafts(self):
        Level.objects.create(slug='draft', title='Draft', difficulty=self.difficulty)
        self.client.force_authenticate(user=None)
        response = self.client.get('/api/v1/levels/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, [])