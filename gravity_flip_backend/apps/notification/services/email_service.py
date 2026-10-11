from django.conf import settings
from django.core.mail import send_mail


class EmailService:
    @staticmethod
    def send(*, user, subject, body):
        if not user.email:
            raise ValueError('User does not have an email address.')
        count = send_mail(subject, body, settings.DEFAULT_FROM_EMAIL, [user.email], fail_silently=False)
        return {'recipient': user.email, 'accepted': count > 0}