from django.db import transaction
from django.utils import timezone

from ..models import ModerationCase
from .audit_log_service import AuditLogService
from .user_management_service import UserManagementService


class ModerationService:
    @staticmethod
    @transaction.atomic
    def decide(*, actor, case, status, action, resolution, request=None):
        before = {'status': case.status, 'action': case.action}
        case.status = status
        case.action = action
        case.resolution = resolution
        case.assigned_to = actor
        case.save(update_fields=['status', 'action', 'resolution', 'assigned_to', 'updated_at'])
        if action == ModerationCase.Action.SUSPEND:
            UserManagementService.set_active(actor=actor, user=case.subject, is_active=False, reason=resolution, request=request)
        elif action == ModerationCase.Action.BAN:
            case.subject.is_active = False
            case.subject.save(update_fields=['is_active'])
        AuditLogService.record(actor=actor, action='moderation.decide', target=case, reason=resolution, before=before, after={'status': status, 'action': action}, request=request)
        return case