from django.contrib import admin

from .models import AdminAction, ModerationCase, SystemConfig


@admin.register(AdminAction)
class AdminActionAdmin(admin.ModelAdmin):
    list_display = ('actor', 'action', 'target_type', 'target_id', 'created_at')
    list_filter = ('action', 'target_type')
    search_fields = ('actor__username', 'target_id', 'reason')
    readonly_fields = [field.name for field in AdminAction._meta.fields]


@admin.register(ModerationCase)
class ModerationCaseAdmin(admin.ModelAdmin):
    list_display = ('subject', 'reason', 'status', 'action', 'assigned_to', 'created_at')
    list_filter = ('status', 'action')
    search_fields = ('subject__username', 'reason', 'details')


@admin.register(SystemConfig)
class SystemConfigAdmin(admin.ModelAdmin):
    list_display = ('key', 'is_public', 'updated_by', 'updated_at')
    list_filter = ('is_public',)
    search_fields = ('key', 'description')