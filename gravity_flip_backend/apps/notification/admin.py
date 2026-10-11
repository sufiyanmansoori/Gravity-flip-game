from django.contrib import admin

from .models import Notification, NotificationTemplate


@admin.register(Notification)
class NotificationAdmin(admin.ModelAdmin):
    list_display = ('user', 'channel', 'category', 'status', 'is_read', 'created_at', 'sent_at')
    list_filter = ('channel', 'category', 'status', 'is_read')
    search_fields = ('user__username', 'user__email', 'subject', 'idempotency_key')
    readonly_fields = ('id', 'created_at', 'updated_at', 'sent_at')


@admin.register(NotificationTemplate)
class NotificationTemplateAdmin(admin.ModelAdmin):
    list_display = ('code', 'channel', 'is_active')
    list_filter = ('channel', 'is_active')
    search_fields = ('code', 'subject', 'body')