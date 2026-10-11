from django.conf import settings


class SMSService:
    @staticmethod
    def send(*, user, body):
        phone = getattr(user, 'phone_number', '')
        if not phone:
            raise ValueError('User does not have a phone number.')
        if not getattr(settings, 'SMS_PROVIDER_URL', ''):
            raise RuntimeError('SMS provider is not configured.')
        return {'recipient': phone, 'accepted': True}