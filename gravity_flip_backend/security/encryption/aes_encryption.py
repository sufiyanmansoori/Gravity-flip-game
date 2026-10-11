import base64
import os

from security import _missing_dependency


class AESGCMEncryption:
    """Authenticated AES-GCM encryption; ciphertext includes nonce and tag."""

    def __init__(self, key):
        if len(key) not in (16, 24, 32):
            raise ValueError('AES-GCM key must be 16, 24, or 32 bytes.')
        self.key = key

    def encrypt(self, plaintext, associated_data=None):
        try:
            from cryptography.hazmat.primitives.ciphers.aead import AESGCM
        except ImportError as exc:
            raise _missing_dependency('cryptography') from exc
        nonce = os.urandom(12)
        ciphertext = AESGCM(self.key).encrypt(nonce, plaintext.encode(), associated_data)
        return base64.urlsafe_b64encode(nonce + ciphertext).decode()

    def decrypt(self, token, associated_data=None):
        try:
            from cryptography.hazmat.primitives.ciphers.aead import AESGCM
        except ImportError as exc:
            raise _missing_dependency('cryptography') from exc
        raw = base64.urlsafe_b64decode(token.encode())
        return AESGCM(self.key).decrypt(raw[:12], raw[12:], associated_data).decode()
