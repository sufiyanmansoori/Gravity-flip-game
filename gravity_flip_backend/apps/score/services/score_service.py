from django.db import IntegrityError, transaction

from ..models import Score
from .leaderboard_service import LeaderboardService
from .stats_service import StatsService


class ScoreService:
    @staticmethod
    @transaction.atomic
    def save(*, user, level, value, idempotency_key, game=None, duration_seconds=0, stars=0, metadata=None):
        if game is not None:
            if game.owner_id != user.pk:
                raise PermissionError('You can only submit a score for your own game.')
            if game.level_id != level.slug:
                raise ValueError('The score level does not match the game level.')
        try:
            score, created = Score.objects.get_or_create(
                user=user, idempotency_key=idempotency_key,
                defaults={'level': level, 'game': game, 'value': value, 'duration_seconds': duration_seconds, 'stars': stars, 'metadata': metadata or {}},
            )
        except IntegrityError:
            score = Score.objects.get(user=user, idempotency_key=idempotency_key)
            created = False
        if created:
            LeaderboardService.update_for_score(score)
            StatsService.update_for_score(score)
        elif score.value != value or score.level_id != level.id:
            raise ValueError('Idempotency key was already used for a different score.')
        return score, created