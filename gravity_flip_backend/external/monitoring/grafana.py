from django.conf import settings

from external import ExternalServiceError


class GrafanaClient:
    @staticmethod
    def dashboard_url(path=''):
        base = getattr(settings, 'GRAFANA_BASE_URL', '')
        if not base:
            raise ExternalServiceError('GRAFANA_BASE_URL is not configured.')
        return f'{base.rstrip("/")}/{path.lstrip("/")}'