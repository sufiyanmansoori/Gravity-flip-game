from django.db.models import Q

from ..models import LevelProgression


class LevelProgressionService:
    @staticmethod
    def is_unlocked(*, level, completed_level_ids, best_score_by_level=None, stars_by_level=None):
        progression = getattr(level, 'progression', None)
        if progression is None:
            return True
        if progression.prerequisite_id and progression.prerequisite_id not in completed_level_ids:
            return False
        best_score = (best_score_by_level or {}).get(str(level.id), 0)
        stars = (stars_by_level or {}).get(str(level.id), 0)
        return best_score >= progression.required_score and stars >= progression.required_stars

    @staticmethod
    def ordered_levels():
        return LevelProgression.objects.select_related('level', 'prerequisite').filter(level__status='published').order_by('order', 'level__slug')