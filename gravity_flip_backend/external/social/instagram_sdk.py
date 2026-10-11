from django.conf import settings

from external import ExternalServiceError


class InstagramClient:
    @staticmethod
    def access_token():
        token = getattr(settings, 'INSTAGRAM_ACCESS_TOKEN', '')
        if not token:
            raise ExternalServiceError('INSTAGRAM_ACCESS_TOKEN is not configured.')
        return token