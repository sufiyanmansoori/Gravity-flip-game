from django.conf import settings

from external import ExternalServiceError


class FacebookClient:
    @staticmethod
    def access_token():
        token = getattr(settings, 'FACEBOOK_ACCESS_TOKEN', '')
        if not token:
            raise ExternalServiceError('FACEBOOK_ACCESS_TOKEN is not configured.')
        return token