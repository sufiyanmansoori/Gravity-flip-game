from django.conf import settings

from external import ExternalServiceError


class MailgunClient:
    @staticmethod
    def send(*, to, subject, text, html=None):
        try:
            import requests
        except ImportError as exc:
            raise ExternalServiceError('Install requests to use Mailgun.') from exc
        api_key = getattr(settings, 'MAILGUN_API_KEY', '')
        domain = getattr(settings, 'MAILGUN_DOMAIN', '')
        if not api_key or not domain:
            raise ExternalServiceError('Mailgun credentials are not configured.')
        response = requests.post(f'https://api.mailgun.net/v3/{domain}/messages', auth=('api', api_key), data={'from': settings.DEFAULT_FROM_EMAIL, 'to': [to], 'subject': subject, 'text': text, 'html': html or ''}, timeout=10)
        response.raise_for_status()
        return response.json()