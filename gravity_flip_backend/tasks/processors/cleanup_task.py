from datetime import timedelta

from celery import shared_task
from django.utils import timezone


@shared_task(queue='maintenance')
def cleanup_expired_sessions(days=30):
    from apps.auth.models import AuthSession
    cutoff = timezone.now() - timedelta(days=days)
    deleted, _ = AuthSession.objects.filter(last_seen_at__lt=cutoff, revoked_at__isnull=True).delete()
    return {'deleted': deleted}


@shared_task(queue='maintenance')
def cleanup_old_events(days=180):
    from apps.analytics.models.event import Event
    cutoff = timezone.now() - timedelta(days=days)
    deleted, _ = Event.objects.filter(created_at__lt=cutoff).delete()
    return {'deleted': deleted}