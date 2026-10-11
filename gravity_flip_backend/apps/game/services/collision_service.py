class CollisionService:
    @staticmethod
    def intersects(first, second):
        return first.x < second.x + second.width and first.x + first.width > second.x and first.y < second.y + second.height and first.y + first.height > second.y

    @classmethod
    def first_collision(cls, body, obstacles):
        return next((obstacle for obstacle in obstacles if obstacle.active and cls.intersects(body, obstacle)), None)