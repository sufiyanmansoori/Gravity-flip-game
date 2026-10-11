from django.db import transaction
from django.utils import timezone

from ..models import Subscription


class SubscriptionService:
    @staticmethod
    def active_for_user(user):
        return Subscription.objects.filter(user=user, status=Subscription.Status.ACTIVE).select_related('plan')

    @staticmethod
    @transaction.atomic
    def cancel(subscription, at_period_end=True):
        subscription.cancel_at_period_end = at_period_end
        if not at_period_end:
            subscription.status = Subscription.Status.CANCELLED
            subscription.cancelled_at = timezone.now()
        subscription.save(update_fields=['cancel_at_period_end', 'status', 'cancelled_at', 'updated_at'])
        return subscription