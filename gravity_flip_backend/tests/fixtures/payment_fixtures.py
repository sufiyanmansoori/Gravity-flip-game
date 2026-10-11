from decimal import Decimal

from apps.payment.models import SubscriptionPlan

from .user_fixtures import user


def payment_user(**overrides):
    return user(username='payment-user', email='billing@example.com', **overrides)


def subscription_plan(**overrides):
    data = {'code': 'test-premium', 'name': 'Test Premium', 'amount': Decimal('9.99'), 'currency': 'USD', 'interval': 'month'}
    data.update(overrides)
    return SubscriptionPlan.objects.create(**data)