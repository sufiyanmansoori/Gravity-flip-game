from security import _missing_dependency


class RSAEncryption:
    @staticmethod
    def load_public_key(pem):
        try:
            from cryptography.hazmat.primitives import serialization
            return serialization.load_pem_public_key(pem)
        except ImportError as exc:
            raise _missing_dependency('cryptography') from exc

    @staticmethod
    def load_private_key(pem, password=None):
        try:
            from cryptography.hazmat.primitives import serialization
            return serialization.load_pem_private_key(pem, password=password)
        except ImportError as exc:
            raise _missing_dependency('cryptography') from exc

    @staticmethod
    def encrypt(public_key, plaintext):
        try:
            from cryptography.hazmat.primitives.asymmetric import padding
            from cryptography.hazmat.primitives import hashes
            return public_key.encrypt(plaintext, padding.OAEP(mgf=padding.MGF1(algorithm=hashes.SHA256()), algorithm=hashes.SHA256(), label=None))
        except ImportError as exc:
            raise _missing_dependency('cryptography') from exc

    @staticmethod
    def decrypt(private_key, ciphertext):
        try:
            from cryptography.hazmat.primitives.asymmetric import padding
            from cryptography.hazmat.primitives import hashes
            return private_key.decrypt(ciphertext, padding.OAEP(mgf=padding.MGF1(algorithm=hashes.SHA256()), algorithm=hashes.SHA256(), label=None))
        except ImportError as exc:
            raise _missing_dependency('cryptography') from exc
