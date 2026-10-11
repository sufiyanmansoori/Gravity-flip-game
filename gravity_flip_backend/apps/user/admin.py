from django.contrib import admin

from .models import NotificationSettings, UserPreferences, UserProfile


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ('user', 'display_name', 'country', 'timezone', 'created_at')
    search_fields = ('user__username', 'user__email', 'display_name')


admin.site.register((UserPreferences, NotificationSettings))