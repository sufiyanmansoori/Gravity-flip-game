from django.db import models

from apps.core.models import TimeStampedModel


class MetricAggregate(TimeStampedModel):
    metric = models.CharField(max_length=100)
    bucket = models.DateField()
    dimension = models.CharField(max_length=100, blank=True, default='')
    count = models.PositiveBigIntegerField(default=0)
    total = models.DecimalField(max_digits=20, decimal_places=4, default=0)
    minimum = models.DecimalField(max_digits=20, decimal_places=4, null=True, blank=True)
    maximum = models.DecimalField(max_digits=20, decimal_places=4, null=True, blank=True)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_analytics_metrics'
        constraints = [models.UniqueConstraint(fields=['metric', 'bucket', 'dimension'], name='unique_metric_bucket_dimension')]
        indexes = [models.Index(fields=['metric', '-bucket'])]


class AnalyticsSnapshot(TimeStampedModel):
    metric_name = models.CharField(max_length=255)
    metric_value = models.FloatField(default=0)
    dimension = models.CharField(max_length=255, blank=True, default='')
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'analytics_snapshots'