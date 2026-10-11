class ScoreCalculationService:
    @staticmethod
    def calculate(*, distance=0, obstacles_cleared=0, gravity_flips=0, time_bonus=0, completion_bonus=0):
        values = [distance, obstacles_cleared, gravity_flips, time_bonus, completion_bonus]
        if any(value < 0 for value in values):
            raise ValueError('Score components cannot be negative.')
        return int(distance) + int(obstacles_cleared) * 100 + int(gravity_flips) * 25 + int(time_bonus) + int(completion_bonus)

    @staticmethod
    def stars(value, target_score):
        if target_score <= 0:
            return 0
        ratio = value / target_score
        return min(5, max(0, int(ratio * 3)))