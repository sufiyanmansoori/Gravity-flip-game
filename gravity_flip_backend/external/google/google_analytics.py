from django.conf import settings

from external import ExternalServiceError


class GoogleAnalyticsClient:
    @staticmethod
    def measurement_id():
        value = getattr(settings, 'GOOGLE_ANALYTICS_MEASUREMENT_ID', '')
        if not value:
            raise ExternalServiceError('GOOGLE_ANALYTICS_MEASUREMENT_ID is not configured.')
        return value

    @classmethod
    def event_payload(cls, client_id, name, params=None):
        return {'client_id': client_id, 'events': [{'name': name, 'params': params or {}}]}