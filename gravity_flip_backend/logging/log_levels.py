import logging

TRACE = 5
DEBUG = logging.DEBUG
INFO = logging.INFO
WARNING = logging.WARNING
ERROR = logging.ERROR
CRITICAL = logging.CRITICAL

logging.addLevelName(TRACE, 'TRACE')


def level_from_name(value, default=INFO):
    if isinstance(value, int):
        return value
    return {'TRACE': TRACE, 'DEBUG': DEBUG, 'INFO': INFO, 'WARNING': WARNING, 'ERROR': ERROR, 'CRITICAL': CRITICAL}.get(str(value).upper(), default)
