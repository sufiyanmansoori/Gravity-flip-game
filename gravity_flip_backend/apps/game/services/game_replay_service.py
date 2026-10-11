from django.db import transaction

from ..models import Game


class GameReplayService:
    @staticmethod
    @transaction.atomic
    def record(game, action, tick, payload=None):
        replay = game.metadata.setdefault('replay', [])
        replay.append({'action': action, 'tick': tick, 'payload': payload or {}})
        game.save(update_fields=['metadata', 'updated_at'])
        return replay[-1]

    @staticmethod
    def events(game):
        return list(game.metadata.get('replay', []))