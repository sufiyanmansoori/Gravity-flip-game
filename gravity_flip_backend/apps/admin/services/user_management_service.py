from django.db import transaction

from apps.users.models import User

from .audit_log_service import AuditLogService


class UserManagementService:
    @staticmethod
    def queryset():
        return User.objects.all().order_by('-date_joined')

    @staticmethod
    @transaction.atomic
    def set_active(*, actor, user, is_active, reason='', request=None):
        before = {'is_active': user.is_active}
        user.is_active = is_active
        user.save(update_fields=['is_active'])
        AuditLogService.record(actor=actor, action='user.activate' if is_active else 'user.deactivate', target=user, reason=reason, before=before, after={'is_active': is_active}, request=request)
        return user