from apps.users.models import User


def user(**overrides):
    data = {'username': 'test-user', 'email': 'test@example.com', 'password': 'Strong-password-123'}
    data.update(overrides)
    password = data.pop('password')
    return User.objects.create_user(password=password, **data)


def staff_user(**overrides):
    return user(username='test-admin', email='admin@example.com', is_staff=True, **overrides)