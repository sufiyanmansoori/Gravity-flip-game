from external import ExternalServiceError
from .aws_config import AWSConfig


class CloudWatchClient:
    @staticmethod
    def put_metric(namespace, name, value, unit='Count', dimensions=None):
        try:
            import boto3
        except ImportError as exc:
            raise ExternalServiceError('Install boto3 to use CloudWatch.') from exc
        return boto3.client('cloudwatch', **AWSConfig.kwargs()).put_metric_data(Namespace=namespace, MetricData=[{'MetricName': name, 'Value': value, 'Unit': unit, 'Dimensions': dimensions or []}])