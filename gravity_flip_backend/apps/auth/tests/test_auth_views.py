from rest_framework import status
from rest_framework.test import APITestCase


class AuthViewTests(APITestCase):
    def test_register_endpoint(self):
        response = self.client.post('/api/v1/auth/register/', {'username': 'pilot', 'email': 'pilot@example.com', 'password': 'Strong-password-123'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_201_CREATED)
        self.assertIn('access', response.data)

    def test_login_rejects_invalid_credentials(self):
        response = self.client.post('/api/v1/auth/login/', {'identifier': 'missing', 'password': 'wrong-password'}, format='json')
        self.assertEqual(response.status_code, status.HTTP_401_UNAUTHORIZED)