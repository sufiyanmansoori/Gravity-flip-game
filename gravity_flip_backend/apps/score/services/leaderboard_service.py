from django.db import transaction

from ..models import LeaderboardEntry


class LeaderboardService:
    @staticmethod
    @transaction.atomic
    def update_for_score(score):
        entry, _ = LeaderboardEntry.objects.select_for_update().get_or_create(level=score.level, user=score.user)
        if score.value >= entry.best_score:
            entry.best_score = score.value
            entry.stars = max(entry.stars, score.stars)
            entry.score_id = score.id
            entry.save(update_fields=['best_score', 'stars', 'score_id', 'updated_at'])
        LeaderboardService.rebuild(score.level)
        return entry

    @staticmethod
    def rebuild(level):
        entries = list(LeaderboardEntry.objects.select_for_update().filter(level=level).order_by('-best_score', 'created_at', 'user_id'))
        for rank, entry in enumerate(entries, start=1):
            if entry.rank != rank:
                LeaderboardEntry.objects.filter(pk=entry.pk).update(rank=rank)

    @staticmethod
    def top(level, limit=20):
        return LeaderboardEntry.objects.filter(level=level).select_related('user').order_by('rank', '-best_score')[:limit]