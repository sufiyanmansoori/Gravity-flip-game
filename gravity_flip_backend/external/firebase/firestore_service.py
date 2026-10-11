from .firebase_admin import FirebaseAdmin
from external import ExternalServiceError


class FirestoreService:
    @staticmethod
    def client():
        FirebaseAdmin.app()
        try:
            from firebase_admin import firestore
            return firestore.client()
        except ImportError as exc:
            raise ExternalServiceError('Install firebase-admin to use Firestore.') from exc

    @classmethod
    def set(cls, collection, document_id, data, merge=True):
        cls.client().collection(collection).document(document_id).set(data, merge=merge)

    @classmethod
    def get(cls, collection, document_id):
        snapshot = cls.client().collection(collection).document(document_id).get()
        return snapshot.to_dict() if snapshot.exists else None

    @classmethod
    def delete(cls, collection, document_id):
        cls.client().collection(collection).document(document_id).delete()