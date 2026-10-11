from django.db import transaction

from ..models import SystemConfig
from .audit_log_service import AuditLogService


class SystemConfigService:
    @staticmethod
    def get(key, default=None):
        config = SystemConfig.objects.filter(key=key).first()
        return config.value if config else default

    @staticmethod
    @transaction.atomic
    def upsert(*, actor, key, value, description='', is_public=False, request=None):
        config, _ = SystemConfig.objects.select_for_update().get_or_create(key=key, defaults={'value': value, 'description': description, 'is_public': is_public, 'updated_by': actor})
        before = {'value': config.value, 'is_public': config.is_public}
        config.value = value
        config.description = description
        config.is_public = is_public
        config.updated_by = actor
        config.save(update_fields=['value', 'description', 'is_public', 'updated_by', 'updated_at'])
        AuditLogService.record(actor=actor, action='system_config.upsert', target=config, before=before, after={'value': value, 'is_public': is_public}, request=request)
        return config