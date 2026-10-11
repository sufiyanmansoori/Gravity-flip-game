from django.contrib.auth import authenticate
from django.contrib.auth.hashers import check_password, make_password


class PasswordService:
    @staticmethod
    def hash(password):
        return make_password(password)

    @staticmethod
    def verify(password, encoded):
        return check_password(password, encoded)

    @staticmethod
    def authenticate(identifier, password):
        user = authenticate(username=identifier, password=password)
        if user is None:
            from apps.users.models import User
            user = User.objects.filter(email__iexact=identifier).first()
            if user and not user.check_password(password):
                user = None
        return user if user and user.is_active else None