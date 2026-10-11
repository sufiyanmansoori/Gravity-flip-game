"""Compatibility proxy for the standard-library logging.config module."""

from importlib import import_module

_std_config = import_module('_gravity_stdlib_logging.config')

for _name in dir(_std_config):
    if not _name.startswith('__'):
        globals()[_name] = getattr(_std_config, _name)
