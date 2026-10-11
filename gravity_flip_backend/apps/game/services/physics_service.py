from dataclasses import dataclass


@dataclass(frozen=True)
class PhysicsBody:
    x: float
    y: float
    velocity_x: float
    velocity_y: float
    width: float
    height: float


class PhysicsService:
    @staticmethod
    def integrate(body, gravity, delta_time, gravity_strength=980.0, friction=0.0, world_width=None, world_height=None):
        velocity_y = body.velocity_y + gravity * gravity_strength * delta_time
        velocity_x = body.velocity_x * max(0.0, 1.0 - friction * delta_time)
        x = body.x + velocity_x * delta_time
        y = body.y + velocity_y * delta_time
        if world_width is not None:
            x = min(max(0.0, x), max(0.0, world_width - body.width))
        if world_height is not None:
            y = min(max(0.0, y), max(0.0, world_height - body.height))
        return PhysicsBody(x, y, velocity_x, velocity_y, body.width, body.height)

    @staticmethod
    def flip_gravity(current_gravity):
        if current_gravity not in (-1, 1):
            raise ValueError('Gravity must be either -1 or 1')
        return -current_gravity