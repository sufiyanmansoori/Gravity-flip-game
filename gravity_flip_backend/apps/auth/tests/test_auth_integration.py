from django.test import TestCase

from apps.auth.models import OneTimePassword
from apps.auth.services.otp_service import OTPService
from apps.users.models import User


class OTPIntegrationTests(TestCase):
    def test_otp_is_single_use(self):
        user = User.objects.create_user(username='pilot', email='pilot@example.com', password='Strong-password-123')
        _, code = OTPService.issue(user, OneTimePassword.Purpose.TWO_FACTOR)
        self.assertTrue(OTPService.verify(user, OneTimePassword.Purpose.TWO_FACTOR, code))
        self.assertFalse(OTPService.verify(user, OneTimePassword.Purpose.TWO_FACTOR, code))