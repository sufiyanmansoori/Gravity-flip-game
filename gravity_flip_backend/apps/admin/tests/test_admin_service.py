from django.test import TestCase
from rest_framework.test import APIClient

from apps.admin.models import AdminAction, ModerationCase, SystemConfig
from apps.admin.services.moderation_service import ModerationService
from apps.admin.services.system_config_service import SystemConfigService
from apps.admin.services.user_management_service import UserManagementService
from apps.users.models import User


class AdminServiceTests(TestCase):
    def setUp(self):
        self.admin = User.objects.create_user(username='admin', password='Strong-password-123', is_staff=True)
        self.subject = User.objects.create_user(username='subject', password='Strong-password-123')

    def test_user_deactivation_is_audited(self):
        UserManagementService.set_active(actor=self.admin, user=self.subject, is_active=False, reason='abuse')
        self.subject.refresh_from_db()
        self.assertFalse(self.subject.is_active)
        self.assertEqual(AdminAction.objects.filter(action='user.deactivate').count(), 1)

    def test_moderation_suspend_updates_subject(self):
        case = ModerationCase.objects.create(subject=self.subject, reporter=self.admin, reason='abuse')
        ModerationService.decide(actor=self.admin, case=case, status='resolved', action='suspend', resolution='Suspended')
        self.subject.refresh_from_db()
        self.assertFalse(self.subject.is_active)
        self.assertEqual(AdminAction.objects.filter(action='moderation.decide').count(), 1)

    def test_system_config_upsert_is_audited(self):
        config = SystemConfigService.upsert(actor=self.admin, key='maintenance', value={'enabled': True})
        self.assertEqual(SystemConfigService.get('maintenance')['enabled'], True)
        self.assertEqual(config.updated_by_id, self.admin.pk)


class AdminIntegrationTests(TestCase):
    def setUp(self):
        self.admin = User.objects.create_user(username='admin', password='Strong-password-123', is_staff=True)
        self.user = User.objects.create_user(username='user', password='Strong-password-123')
        self.client = APIClient()

    def test_non_staff_is_denied(self):
        self.client.force_authenticate(self.user)
        response = self.client.get('/api/v1/admin/control/dashboard/')
        self.assertEqual(response.status_code, 403)

    def test_staff_can_view_dashboard(self):
        self.client.force_authenticate(self.admin)
        response = self.client.get('/api/v1/admin/control/dashboard/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['users'], 2)