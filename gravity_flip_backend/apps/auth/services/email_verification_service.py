from django.core.mail import send_mail
from django.conf import settings

from .otp_service import OTPService


class EmailVerificationService:
    @staticmethod
    def send(user):
        record, code = OTPService.issue(user, 'verify_email')
        send_mail('Verify your Gravity Flip account', f'Your verification code is {code}. It expires soon.', settings.DEFAULT_FROM_EMAIL, [user.email], fail_silently=False)
        return record

    @staticmethod
    def verify(user, code):
        valid = OTPService.verify(user, 'verify_email', code)
        if valid:
            user.is_verified = True
            user.save(update_fields=['is_verified'])
        return valid