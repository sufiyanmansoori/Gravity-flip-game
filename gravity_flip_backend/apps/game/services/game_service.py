import secrets
from datetime import timedelta

from django.db import transaction
from django.utils import timezone

from apps.users.models import User

from ..models import Game, GameState, Obstacle, PhysicsData, Player
from .level_loader_service import LevelLoaderService


class GameService:
    @staticmethod
    @transaction.atomic
    def create(owner, level_id, seed=None, metadata=None):
        game = Game.objects.create(owner=owner, level_id=level_id, seed=seed if seed is not None else secrets.randbelow(2**31), metadata=metadata or {})
        level = LevelLoaderService.load(level_id)
        GameState.objects.create(game=game, world_width=level['world_width'], world_height=level['world_height'], snapshot=level.get('snapshot', {}))
        PhysicsData.objects.create(game=game, **level.get('physics', {}))
        Player.objects.create(game=game, user=owner)
        for obstacle in level.get('obstacles', []):
            Obstacle.objects.create(game=game, **obstacle)
        return game

    @staticmethod
    @transaction.atomic
    def apply_action(game, user, action):
        if game.owner_id != user.pk:
            raise PermissionError('Only the game owner may control this game')
        if action == 'flip_gravity':
            state = GameState.objects.select_for_update().get(game=game)
            state.gravity = -state.gravity
            state.save(update_fields=['gravity', 'updated_at'])
            if game.status == Game.Status.CREATED:
                game.status = Game.Status.RUNNING
        elif action == 'resume':
            game.status = Game.Status.RUNNING
        elif action == 'pause':
            game.status = Game.Status.PAUSED
        elif action == 'finish':
            game.status = Game.Status.COMPLETED
            game.finished_at = timezone.now()
        game.save(update_fields=['status', 'finished_at', 'updated_at'])
        return game