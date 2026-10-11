import json

from external import ExternalServiceError
from .aws_config import AWSConfig


class LambdaClient:
    @staticmethod
    def invoke(function_name, payload, asynchronous=False):
        try:
            import boto3
        except ImportError as exc:
            raise ExternalServiceError('Install boto3 to use AWS Lambda.') from exc
        result = boto3.client('lambda', **AWSConfig.kwargs()).invoke(FunctionName=function_name, InvocationType='Event' if asynchronous else 'RequestResponse', Payload=json.dumps(payload).encode())
        return result