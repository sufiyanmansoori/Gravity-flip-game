from external import ExternalServiceError


class GoogleAuthClient:
    @staticmethod
    def verify_id_token(token, audience):
        try:
            from google.oauth2 import id_token
            from google.auth.transport import requests
            return id_token.verify_oauth2_token(token, requests.Request(), audience)
        except ImportError as exc:
            raise ExternalServiceError('Install google-auth to use Google Auth.') from exc