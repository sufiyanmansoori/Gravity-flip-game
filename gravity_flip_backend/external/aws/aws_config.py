from django.conf import settings


class AWSConfig:
    @staticmethod
    def kwargs():
        return {'region_name': getattr(settings, 'AWS_REGION', 'us-east-1'), 'aws_access_key_id': getattr(settings, 'AWS_ACCESS_KEY_ID', ''), 'aws_secret_access_key': getattr(settings, 'AWS_SECRET_ACCESS_KEY', '')}