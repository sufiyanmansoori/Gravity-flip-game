from decimal import Decimal


class DifficultyService:
    @staticmethod
    def scale(level, base_obstacle_count, base_speed):
        difficulty = level.difficulty
        return {
            'obstacle_count': max(0, round(base_obstacle_count * float(difficulty.obstacle_density))),
            'speed': round(Decimal(str(base_speed)) * difficulty.speed_multiplier, 4),
            'time_limit_seconds': difficulty.time_limit_seconds or None,
            'minimum_score': difficulty.minimum_score,
        }

    @staticmethod
    def can_complete(level, score):
        return score >= level.difficulty.minimum_score