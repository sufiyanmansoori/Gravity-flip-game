from unittest.mock import patch

from django.test import TestCase
from rest_framework.test import APIClient

from apps.notification.models import Notification, NotificationTemplate
from apps.notification.services.notification_service import NotificationService
from apps.users.models import User


class NotificationServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', email='pilot@example.com', password='Strong-password-123')

    def test_in_app_notification_is_idempotent_and_delivered(self):
        first, created = NotificationService.create(user=self.user, channel='in_app', category='achievement', idempotency_key='achievement-1', subject='Unlocked', body='Great work')
        duplicate, duplicate_created = NotificationService.create(user=self.user, channel='in_app', category='achievement', idempotency_key='achievement-1', subject='Unlocked', body='Great work')
        self.assertTrue(created)
        self.assertFalse(duplicate_created)
        self.assertEqual(first.pk, duplicate.pk)
        self.assertEqual(NotificationService.deliver(first).status, Notification.Status.SENT)

    def test_template_requires_context_variables(self):
        template = NotificationTemplate.objects.create(code='welcome', channel='in_app', subject='Hi {name}', body='Welcome {name}')
        with self.assertRaises(ValueError):
            NotificationService.create(user=self.user, channel='in_app', category='system', idempotency_key='welcome-1', template=template, context={})


class NotificationIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='pilot', password='Strong-password-123')
        self.client = APIClient()
        self.client.force_authenticate(self.user)

    def test_read_all_endpoint(self):
        Notification.objects.create(user=self.user, channel='in_app', category='system', idempotency_key='one', subject='One', body='Body')
        response = self.client.post('/api/v1/notification/read_all/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['marked_read'], 1)