import random


class LevelGeneratorService:
    @staticmethod
    def generate(*, seed, obstacle_count, world_width=1200, world_height=800):
        if obstacle_count < 0 or obstacle_count > 10_000:
            raise ValueError('obstacle_count must be between 0 and 10000')
        generator = random.Random(seed)
        obstacles = []
        for index in range(obstacle_count):
            obstacles.append({
                'id': index,
                'type': generator.choice(['wall', 'spike', 'moving']),
                'x': generator.randint(200, max(200, world_width - 80)),
                'y': generator.randint(40, max(40, world_height - 80)),
                'width': generator.randint(24, 96),
                'height': generator.randint(24, 96),
            })
        return {'seed': seed, 'world_width': world_width, 'world_height': world_height, 'obstacles': obstacles}