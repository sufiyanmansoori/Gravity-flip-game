import importlib
import sys

sys.modules.get('logging').handlers = sys.modules[__name__]

_std_handlers = importlib.import_module('_gravity_stdlib_logging.handlers')
for _name in dir(_std_handlers):
    if not _name.startswith('__'):
        globals().setdefault(_name, getattr(_std_handlers, _name))

from .combined_handler import CombinedHandler
from .console_handler import ConsoleHandler
from .error_handler import ErrorHandler
from .file_handler import JsonFormatter, StructuredFileHandler

__all__ = ['CombinedHandler', 'ConsoleHandler', 'ErrorHandler', 'StructuredFileHandler']
