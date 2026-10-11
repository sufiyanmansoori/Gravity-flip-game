from django.test import SimpleTestCase

from apps.game.services.collision_service import CollisionService
from apps.game.services.physics_service import PhysicsBody, PhysicsService


class PhysicsServiceTests(SimpleTestCase):
    def test_gravity_increases_vertical_velocity(self):
        body = PhysicsBody(0, 0, 0, 0, 32, 32)
        result = PhysicsService.integrate(body, gravity=1, delta_time=0.1, gravity_strength=100)
        self.assertAlmostEqual(result.velocity_y, 10)
        self.assertAlmostEqual(result.y, 1)

    def test_gravity_flip_changes_direction(self):
        self.assertEqual(PhysicsService.flip_gravity(1), -1)

    def test_collision_uses_axis_aligned_bounds(self):
        body = PhysicsBody(10, 10, 0, 0, 20, 20)
        obstacle = PhysicsBody(25, 25, 0, 0, 20, 20)
        self.assertTrue(CollisionService.intersects(body, obstacle))