from decimal import Decimal

from django.test import TestCase

from apps.level.models import Difficulty, Level
from apps.level.services.difficulty_service import DifficultyService
from apps.level.services.level_generator_service import LevelGeneratorService
from apps.level.services.level_service import LevelService


class LevelServiceTests(TestCase):
    def setUp(self):
        self.difficulty = Difficulty.objects.create(code='normal', name='Normal', rank=1, speed_multiplier=Decimal('1.20'), obstacle_density=Decimal('1.50'), minimum_score=100)

    def test_create_publish_and_clone_level(self):
        level = LevelService.create(data={'slug': 'first', 'title': 'First', 'difficulty': self.difficulty, 'configuration': {'target_score': 500}})
        self.assertEqual(level.status, Level.Status.DRAFT)
        LevelService.publish(level)
        clone = LevelService.clone_version(level)
        self.assertEqual(clone.slug, 'first-v2')
        self.assertEqual(clone.status, Level.Status.DRAFT)

    def test_difficulty_scales_generation_parameters(self):
        level = LevelService.create(data={'slug': 'scaled', 'title': 'Scaled', 'difficulty': self.difficulty})
        result = DifficultyService.scale(level, 10, 100)
        self.assertEqual(result['obstacle_count'], 15)
        self.assertEqual(result['speed'], Decimal('120.0000'))

    def test_level_generation_is_deterministic(self):
        first = LevelGeneratorService.generate(seed=42, obstacle_count=3)
        second = LevelGeneratorService.generate(seed=42, obstacle_count=3)
        self.assertEqual(first, second)