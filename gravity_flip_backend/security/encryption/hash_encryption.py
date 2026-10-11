import hashlib
import hmac
import secrets


class PasswordHasher:
    algorithm = 'sha256'
    iterations = 310_000

    @classmethod
    def hash(cls, password):
        salt = secrets.token_bytes(16)
        digest = hashlib.pbkdf2_hmac(cls.algorithm, password.encode(), salt, cls.iterations)
        return f'pbkdf2_{cls.algorithm}${cls.iterations}${salt.hex()}${digest.hex()}'

    @classmethod
    def verify(cls, password, encoded):
        try:
            algorithm, iterations, salt, expected = encoded.split('$')
            name = algorithm.removeprefix('pbkdf2_')
            digest = hashlib.pbkdf2_hmac(name, password.encode(), bytes.fromhex(salt), int(iterations))
            return hmac.compare_digest(digest.hex(), expected)
        except (ValueError, TypeError, UnicodeError):
            return False
