from ..models import AdminAction


class AuditLogService:
    @staticmethod
    def record(*, actor, action, target=None, reason='', before=None, after=None, request=None):
        return AdminAction.objects.create(
            actor=actor, action=action, target_type=target.__class__.__name__ if target else '', target_id=str(target.pk) if target else '', reason=reason,
            before=before or {}, after=after or {}, ip_address=request.META.get('REMOTE_ADDR') if request else None,
            request_id=request.headers.get('X-Request-ID', '') if request else '',
        )