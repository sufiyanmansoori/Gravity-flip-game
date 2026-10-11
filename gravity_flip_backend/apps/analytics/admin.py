from django.contrib import admin

from .models.event import Event
from .models.metrics import MetricAggregate
from .models.session import AnalyticsSession


@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    list_display = ('name', 'user', 'session_key', 'created_at')
    list_filter = ('name', 'created_at')
    search_fields = ('name', 'user__username', 'idempotency_key')
    readonly_fields = ('id', 'created_at', 'updated_at')


admin.site.register((AnalyticsSession, MetricAggregate))