from django.urls import reverse
from rest_framework.test import APITestCase

from apps.users.models import User


class GameIntegrationTests(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', email='pilot@example.com', password='Strong-password-123')
        self.client.force_authenticate(self.user)

    def test_create_game_endpoint(self):
        response = self.client.post('/api/v1/game/', {'level_id': 'training'}, format='json')
        self.assertEqual(response.status_code, 201)
        self.assertIn('game', response.data)