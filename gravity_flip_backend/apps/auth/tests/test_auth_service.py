from django.test import TestCase

from apps.users.models import User

from apps.auth.services.auth_service import AuthService
from apps.auth.services.jwt_service import JWTService


class AuthServiceTests(TestCase):
    def test_register_issues_access_and_refresh_tokens(self):
        result = AuthService.register(username='pilot', email='pilot@example.com', password='Strong-password-123')
        self.assertEqual(result['user'].email, 'pilot@example.com')
        self.assertEqual(JWTService.decode(result['access'], expected_type='access')['sub'], str(result['user'].pk))
        self.assertEqual(User.objects.count(), 1)

    def test_refresh_rotates_previous_token(self):
        result = AuthService.register(username='pilot', email='pilot@example.com', password='Strong-password-123')
        rotated = AuthService.refresh(result['refresh'])
        self.assertNotEqual(result['refresh'], rotated['refresh'])