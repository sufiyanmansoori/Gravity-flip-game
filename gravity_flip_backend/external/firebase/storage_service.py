from .firebase_admin import FirebaseAdmin
from external import ExternalServiceError


class FirebaseStorageService:
    @staticmethod
    def bucket():
        FirebaseAdmin.app()
        try:
            from firebase_admin import storage
            return storage.bucket()
        except ImportError as exc:
            raise ExternalServiceError('Install firebase-admin to use Firebase Storage.') from exc

    @classmethod
    def upload(cls, file_path, destination, content_type=None):
        blob = cls.bucket().blob(destination)
        blob.upload_from_filename(file_path, content_type=content_type)
        return blob.name

    @classmethod
    def delete(cls, destination):
        cls.bucket().blob(destination).delete()