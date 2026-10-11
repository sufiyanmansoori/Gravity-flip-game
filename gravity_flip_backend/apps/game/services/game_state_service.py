import hashlib
import json

from django.db import transaction

from ..models import GameState


class GameStateService:
    @staticmethod
    @transaction.atomic
    def save_snapshot(game, snapshot, tick):
        state = GameState.objects.select_for_update().get(game=game)
        if tick < game.tick:
            raise ValueError('State tick cannot move backwards')
        state.snapshot = snapshot
        state.checksum = hashlib.sha256(json.dumps(snapshot, sort_keys=True, separators=(',', ':')).encode()).hexdigest()
        state.save(update_fields=['snapshot', 'checksum', 'updated_at'])
        game.tick = tick
        game.save(update_fields=['tick', 'updated_at'])
        return state