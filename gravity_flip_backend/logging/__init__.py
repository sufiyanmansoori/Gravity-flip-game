"""Project logging helpers with a stdlib logging compatibility facade."""

import importlib.util
import sys
import sysconfig
from pathlib import Path

_stdlib_path = Path(sysconfig.get_paths()['stdlib']) / 'logging' / '__init__.py'
_spec = importlib.util.spec_from_file_location('_gravity_stdlib_logging', _stdlib_path, submodule_search_locations=[str(_stdlib_path.parent)])
_stdlib = importlib.util.module_from_spec(_spec)
sys.modules.setdefault('_gravity_stdlib_logging', _stdlib)
_spec.loader.exec_module(_stdlib)

for _name in dir(_stdlib):
    if _name not in {'__name__', '__package__', '__spec__', '__path__'}:
        globals().setdefault(_name, getattr(_stdlib, _name))

__all__ = ['getLogger', 'Logger', 'Handler', 'Formatter', 'StreamHandler', 'FileHandler']
