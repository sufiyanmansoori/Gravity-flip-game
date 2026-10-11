from django.conf import settings


class LevelLoaderService:
    DEFAULT = {'world_width': 1200, 'world_height': 800, 'snapshot': {}, 'physics': {}, 'obstacles': []}

    @classmethod
    def load(cls, level_id):
        import json
        candidate_dirs = [settings.BASE_DIR / 'assets' / 'levels', settings.BASE_DIR.parent / 'gravity_flip_game' / 'assets' / 'levels']
        data = None
        for levels_dir in candidate_dirs:
            path = levels_dir / f'{level_id}.json'
            if path.is_file() and levels_dir in path.parents:
                with path.open(encoding='utf-8') as level_file:
                    data = json.load(level_file)
                break
        if data is None:
            return dict(cls.DEFAULT)
        result = dict(cls.DEFAULT)
        result.update(data)
        return result