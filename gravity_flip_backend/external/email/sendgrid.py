from django.conf import settings

from external import ExternalServiceError


class SendGridClient:
    @staticmethod
    def send(*, to, subject, text, html=None):
        try:
            from sendgrid import SendGridAPIClient
            from sendgrid.helpers.mail import Mail
        except ImportError as exc:
            raise ExternalServiceError('Install sendgrid to use SendGrid.') from exc
        key = getattr(settings, 'SENDGRID_API_KEY', '')
        if not key:
            raise ExternalServiceError('SENDGRID_API_KEY is not configured.')
        message = Mail(from_email=settings.DEFAULT_FROM_EMAIL, to_emails=to, subject=subject, plain_text_content=text, html_content=html)
        response = SendGridAPIClient(key).send(message)
        return {'status_code': response.status_code}