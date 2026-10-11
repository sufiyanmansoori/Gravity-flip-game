from django.contrib.auth.password_validation import validate_password as django_validate_password


def validate_password(password, user=None):
    django_validate_password(password, user=user)
    return password