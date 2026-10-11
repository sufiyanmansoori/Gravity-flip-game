from django.conf import settings

from external import ExternalServiceError
from .aws_config import AWSConfig


class SESClient:
    @classmethod
    def send(cls, *, to, subject, text, html=None):
        try:
            import boto3
        except ImportError as exc:
            raise ExternalServiceError('Install boto3 to use AWS SES.') from exc
        message = {'Subject': {'Data': subject}, 'Body': {'Text': {'Data': text}}}
        if html:
            message['Body']['Html'] = {'Data': html}
        return boto3.client('ses', **AWSConfig.kwargs()).send_email(Source=settings.DEFAULT_FROM_EMAIL, Destination={'ToAddresses': [to]}, Message=message)