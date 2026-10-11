from django.db.models import Count, Max, Q, Sum

from .profile_service import ProfileService


class UserService:
    @staticmethod
    def provision(user):
        return ProfileService.provision(user)

    @staticmethod
    def stats(user):
        from apps.achievement.models import UserAchievement
        from apps.games.models import GameSession
        from apps.score.models import Score

        score_stats = Score.objects.filter(user=user).aggregate(total=Sum('value'), best=Max('value'), levels=Count('level', distinct=True))
        games = GameSession.objects.filter(user=user).aggregate(total=Count('id'), wins=Count('id', filter=Q(status='completed')))
        return {
            'total_games_played': games['total'] or 0,
            'total_wins': games['wins'] or 0,
            'best_score': score_stats['best'] or 0,
            'total_score': score_stats['total'] or 0,
            'total_stars': Score.objects.filter(user=user).aggregate(total=Sum('stars'))['total'] or 0,
            'completed_levels': score_stats['levels'] or 0,
            'achievements_unlocked': UserAchievement.objects.filter(user=user).count(),
        }