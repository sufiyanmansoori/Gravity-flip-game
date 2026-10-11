from django.contrib import admin

from .models import LeaderboardEntry, Score, UserScoreStats


@admin.register(Score)
class ScoreAdmin(admin.ModelAdmin):
    list_display = ('user', 'level', 'value', 'stars', 'created_at')
    list_filter = ('level', 'stars')
    search_fields = ('user__username', 'user__email', 'idempotency_key')
    readonly_fields = ('id', 'created_at', 'updated_at')


admin.site.register((LeaderboardEntry, UserScoreStats))