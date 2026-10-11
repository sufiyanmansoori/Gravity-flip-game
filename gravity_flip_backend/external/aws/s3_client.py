from django.conf import settings

from external import ExternalServiceError
from .aws_config import AWSConfig


class S3Client:
    @staticmethod
    def client():
        try:
            import boto3
            return boto3.client('s3', **AWSConfig.kwargs())
        except ImportError as exc:
            raise ExternalServiceError('Install boto3 to use AWS S3.') from exc

    @classmethod
    def upload_file(cls, filename, key, content_type=None, bucket=None):
        bucket = bucket or settings.AWS_STORAGE_BUCKET_NAME
        extra = {'ContentType': content_type} if content_type else None
        cls.client().upload_file(filename, bucket, key, ExtraArgs=extra or {})
        return key

    @classmethod
    def presigned_url(cls, key, expires=3600, bucket=None):
        return cls.client().generate_presigned_url('get_object', Params={'Bucket': bucket or settings.AWS_STORAGE_BUCKET_NAME, 'Key': key}, ExpiresIn=expires)