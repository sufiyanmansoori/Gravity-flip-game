from external import ExternalServiceError


class GoogleCloudStorageClient:
    @staticmethod
    def client():
        try:
            from google.cloud import storage
            return storage.Client()
        except ImportError as exc:
            raise ExternalServiceError('Install google-cloud-storage to use Google Cloud Storage.') from exc

    @classmethod
    def upload(cls, bucket_name, source, destination):
        blob = cls.client().bucket(bucket_name).blob(destination)
        blob.upload_from_filename(source)
        return blob.name