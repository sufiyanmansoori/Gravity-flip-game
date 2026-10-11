from django.contrib import admin

from .models import Achievement, AchievementReward, UserAchievement


@admin.register(Achievement)
class AchievementAdmin(admin.ModelAdmin):
    list_display = ('code', 'name', 'points', 'is_active', 'is_hidden')
    list_filter = ('is_active', 'is_hidden')
    search_fields = ('code', 'name')
    readonly_fields = ('id', 'created_at', 'updated_at')


admin.site.register((AchievementReward, UserAchievement))