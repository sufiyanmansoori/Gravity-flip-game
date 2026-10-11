from django.test import TestCase
from rest_framework.test import APIClient

from apps.analytics.models.event import Event
from apps.analytics.models.session import AnalyticsSession
from apps.analytics.services.analytics_service import AnalyticsService
from apps.analytics.services.event_service import EventService
from apps.analytics.services.metrics_service import MetricsService
from apps.users.models import User


class AnalyticsServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')

    def test_event_recording_is_idempotent_and_tracks_session(self):
        first, created = EventService.record(user=self.user, name='game_start', idempotency_key='event-1', session_key='session-1')
        duplicate, duplicate_created = EventService.record(user=self.user, name='game_start', idempotency_key='event-1', session_key='session-1')
        self.assertTrue(created)
        self.assertFalse(duplicate_created)
        self.assertEqual(first.pk, duplicate.pk)
        self.assertEqual(AnalyticsSession.objects.get(session_key='session-1').event_count, 1)

    def test_overview_and_daily_aggregation(self):
        EventService.record(user=self.user, name='game_start', idempotency_key='event-1')
        EventService.record(user=self.user, name='game_end', idempotency_key='event-2')
        self.assertEqual(AnalyticsService.overview(user=self.user)['events'], 2)
        aggregate = MetricsService.aggregate_day()
        self.assertEqual(aggregate.count, 2)


class AnalyticsIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    def test_event_endpoint(self):
        response = self.client.post('/api/v1/analytics/events/', {'name': 'page_view', 'idempotency_key': 'page-1'}, format='json')
        self.assertEqual(response.status_code, 201)
        self.assertTrue(response.data['created'])

    def test_overview_endpoint(self):
        response = self.client.get('/api/v1/analytics/overview/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['events'], 0)