from django.test import TestCase
from rest_framework.test import APIClient

from apps.user.models import NotificationSettings, UserPreferences, UserProfile
from apps.user.services.user_service import UserService
from apps.users.models import User


class UserServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', email='pilot@example.com', password='Strong-password-123')

    def test_provision_is_idempotent(self):
        first = UserService.provision(self.user)
        second = UserService.provision(self.user)
        self.assertEqual(first.pk, second.pk)
        self.assertEqual(UserProfile.objects.count(), 1)
        self.assertEqual(UserPreferences.objects.count(), 1)
        self.assertEqual(NotificationSettings.objects.count(), 1)

    def test_stats_have_zero_state(self):
        stats = UserService.stats(self.user)
        self.assertEqual(stats['total_games_played'], 0)
        self.assertEqual(stats['best_score'], 0)


class UserIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    def test_profile_can_be_updated(self):
        response = self.client.patch('/api/v1/user/me/', {'display_name': 'Gravity Pilot', 'preferences': {'theme': 'dark'}}, format='json')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['display_name'], 'Gravity Pilot')
        self.assertEqual(response.data['preferences']['theme'], 'dark')

    def test_stats_endpoint(self):
        response = self.client.get('/api/v1/user/stats/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['achievements_unlocked'], 0)