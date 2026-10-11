from django.contrib import admin

from .models import Difficulty, Level, LevelConfiguration, LevelProgression


@admin.register(Level)
class LevelAdmin(admin.ModelAdmin):
    list_display = ('title', 'slug', 'difficulty', 'status', 'version', 'published_at')
    list_filter = ('status', 'difficulty')
    search_fields = ('title', 'slug')
    readonly_fields = ('id', 'published_at', 'created_at', 'updated_at')


admin.site.register((Difficulty, LevelConfiguration, LevelProgression))