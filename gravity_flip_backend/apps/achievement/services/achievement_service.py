from django.db.models import Prefetch

from ..models import Achievement, AchievementReward


class AchievementService:
    @staticmethod
    def public_queryset():
        return Achievement.objects.filter(is_active=True, is_hidden=False).prefetch_related(Prefetch('rewards', queryset=AchievementReward.objects.filter(is_active=True)))

    @staticmethod
    def all_active_queryset():
        return Achievement.objects.filter(is_active=True).prefetch_related('rewards')

    @staticmethod
    def progress_context(user):
        from apps.score.models import UserScoreStats
        stats = UserScoreStats.objects.filter(user=user).first()
        if not stats:
            return {'total_submissions': 0, 'completed_levels': 0, 'total_score': 0, 'best_score': 0, 'total_stars': 0}
        return {'total_submissions': stats.total_submissions, 'completed_levels': stats.completed_levels, 'total_score': stats.total_score, 'best_score': stats.best_score, 'total_stars': stats.total_stars}