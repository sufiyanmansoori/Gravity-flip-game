from tests.fixtures.user_fixtures import user
from tests.helpers.test_setup import APIClientTestCase


class UserFlowTests(APIClientTestCase):
    def test_user_can_create_profile_and_read_stats(self):
        account = user()
        self.authenticate(account)
        profile = self.client.get('/api/v1/user/me/')
        stats = self.client.get('/api/v1/user/stats/')
        self.assertEqual(profile.status_code, 200)
        self.assertEqual(stats.status_code, 200)
        self.assertEqual(stats.data['total_games_played'], 0)