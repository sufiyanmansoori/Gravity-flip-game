from django.conf import settings

from external import ExternalServiceError


class TwitterClient:
    @staticmethod
    def credentials():
        values = {key: getattr(settings, key, '') for key in ('TWITTER_API_KEY', 'TWITTER_API_SECRET', 'TWITTER_ACCESS_TOKEN', 'TWITTER_ACCESS_SECRET')}
        if not all(values.values()):
            raise ExternalServiceError('Twitter credentials are not fully configured.')
        return values