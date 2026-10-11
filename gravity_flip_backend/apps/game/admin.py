from django.contrib import admin

from .models import Game, GameState, Obstacle, PhysicsData, Player


@admin.register(Game)
class GameAdmin(admin.ModelAdmin):
    list_display = ('id', 'owner', 'level_id', 'status', 'score', 'tick', 'created_at')
    list_filter = ('status', 'level_id')
    search_fields = ('owner__username', 'owner__email', 'level_id')
    readonly_fields = ('id', 'seed', 'created_at', 'updated_at')


admin.site.register((GameState, Player, Obstacle, PhysicsData))