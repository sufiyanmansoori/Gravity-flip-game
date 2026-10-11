from django.conf import settings

from external import ExternalServiceError


class TwilioClient:
    @staticmethod
    def client():
        try:
            from twilio.rest import Client
        except ImportError as exc:
            raise ExternalServiceError('Install twilio to use Twilio.') from exc
        sid = getattr(settings, 'TWILIO_ACCOUNT_SID', '')
        token = getattr(settings, 'TWILIO_AUTH_TOKEN', '')
        if not sid or not token:
            raise ExternalServiceError('Twilio credentials are not configured.')
        return Client(sid, token)