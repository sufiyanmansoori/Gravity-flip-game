from django.db import IntegrityError, transaction
from django.utils import timezone

from ..models.event import Event
from ..models.session import AnalyticsSession


class EventService:
    @staticmethod
    @transaction.atomic
    def record(*, user, name, idempotency_key, session_key='', route='', payload=None, client_timestamp=None, ip_address=None):
        if not name or len(name) > 80:
            raise ValueError('Event name is required and must be at most 80 characters.')
        try:
            event, created = Event.objects.get_or_create(user=user, idempotency_key=idempotency_key, defaults={'name': name, 'session_key': session_key, 'route': route, 'payload': payload or {}, 'client_timestamp': client_timestamp, 'ip_address': ip_address})
        except IntegrityError:
            event = Event.objects.get(user=user, idempotency_key=idempotency_key)
            created = False
        if session_key:
            session, _ = AnalyticsSession.objects.get_or_create(session_key=session_key, defaults={'user': user, 'started_at': timezone.now(), 'last_seen_at': timezone.now()})
            session.last_seen_at = timezone.now()
            if created:
                session.event_count += 1
            session.save(update_fields=['last_seen_at', 'event_count', 'updated_at'])
        return event, created

    @staticmethod
    @transaction.atomic
    def end_session(session_key):
        session = AnalyticsSession.objects.select_for_update().get(session_key=session_key)
        session.ended_at = timezone.now()
        session.last_seen_at = session.ended_at
        session.save(update_fields=['ended_at', 'last_seen_at', 'updated_at'])
        return session