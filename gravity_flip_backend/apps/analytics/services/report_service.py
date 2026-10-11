from django.db.models import Count

from ..models.event import Event
from ..models.session import AnalyticsSession


class ReportService:
    @staticmethod
    def event_breakdown(*, start, end, user=None):
        events = Event.objects.filter(created_at__date__range=(start, end))
        if user:
            events = events.filter(user=user)
        return list(events.values('name').annotate(count=Count('id')).order_by('-count', 'name'))

    @staticmethod
    def retention(*, user=None):
        sessions = AnalyticsSession.objects.filter(user=user) if user else AnalyticsSession.objects.all()
        return {'sessions': sessions.count(), 'completed': sessions.filter(ended_at__isnull=False).count()}