from datetime import date
from decimal import Decimal

from django.db import transaction

from ..models.event import Event
from ..models.metrics import MetricAggregate


class MetricsService:
    @staticmethod
    @transaction.atomic
    def aggregate_day(*, metric='events', bucket=None, dimension=''):
        bucket = bucket or date.today()
        events = Event.objects.filter(created_at__date=bucket)
        if dimension:
            events = events.filter(name=dimension)
        count = events.count()
        aggregate, _ = MetricAggregate.objects.select_for_update().get_or_create(metric=metric, bucket=bucket, dimension=dimension)
        aggregate.count = count
        aggregate.total = Decimal(count)
        aggregate.minimum = Decimal('1') if count else None
        aggregate.maximum = Decimal('1') if count else None
        aggregate.save(update_fields=['count', 'total', 'minimum', 'maximum', 'updated_at'])
        return aggregate

    @staticmethod
    def query(*, metric, start, end, dimension=''):
        return MetricAggregate.objects.filter(metric=metric, bucket__range=(start, end), dimension=dimension).order_by('bucket')