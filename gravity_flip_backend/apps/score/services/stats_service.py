from django.db import transaction
from django.db.models import Max, Sum

from ..models import Score, UserScoreStats


class StatsService:
    @staticmethod
    @transaction.atomic
    def update_for_score(score):
        stats, _ = UserScoreStats.objects.select_for_update().get_or_create(user=score.user)
        stats.total_submissions = Score.objects.filter(user=score.user).count()
        stats.total_score = Score.objects.filter(user=score.user).aggregate(total=Sum('value'))['total'] or 0
        stats.best_score = Score.objects.filter(user=score.user).aggregate(best=Max('value'))['best'] or 0
        stats.total_stars = Score.objects.filter(user=score.user).aggregate(total=Sum('stars'))['total'] or 0
        stats.completed_levels = Score.objects.filter(user=score.user).values('level').distinct().count()
        stats.save(update_fields=['total_submissions', 'total_score', 'best_score', 'total_stars', 'completed_levels', 'updated_at'])
        return stats

    @staticmethod
    def for_user(user):
        stats, _ = UserScoreStats.objects.get_or_create(user=user)
        return stats