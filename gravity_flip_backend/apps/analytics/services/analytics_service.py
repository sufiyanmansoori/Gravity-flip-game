from django.db.models import Count

from ..models.event import Event
from ..models.session import AnalyticsSession


class AnalyticsService:
    @staticmethod
    def overview(*, user=None):
        events = Event.objects.filter(user=user) if user else Event.objects.all()
        sessions = AnalyticsSession.objects.filter(user=user) if user else AnalyticsSession.objects.all()
        return {'events': events.count(), 'event_types': list(events.values('name').annotate(count=Count('id')).order_by('-count')), 'sessions': sessions.count(), 'active_sessions': sessions.filter(ended_at__isnull=True).count()}

    @staticmethod
    def funnel(*, steps, user=None):
        events = Event.objects.filter(user=user) if user else Event.objects.all()
        return [{'step': step, 'users': events.filter(name=step).values('user_id').distinct().count(), 'events': events.filter(name=step).count()} for step in steps]