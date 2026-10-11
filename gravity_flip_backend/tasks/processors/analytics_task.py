from celery import shared_task


@shared_task(queue='analytics')
def aggregate_analytics_task(metric='events', bucket=None, dimension=''):
    from apps.analytics.services.metrics_service import MetricsService
    aggregate = MetricsService.aggregate_day(metric=metric, bucket=bucket, dimension=dimension)
    return {'metric': aggregate.metric, 'bucket': aggregate.bucket.isoformat(), 'count': aggregate.count}


@shared_task(queue='analytics')
def record_analytics_event_task(user_id, name, idempotency_key, **payload):
    from django.contrib.auth import get_user_model
    from apps.analytics.services.event_service import EventService
    user = get_user_model().objects.get(pk=user_id)
    event, created = EventService.record(user=user, name=name, idempotency_key=idempotency_key, payload=payload)
    return {'id': str(event.id), 'created': created}