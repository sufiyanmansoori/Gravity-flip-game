import logging

from .log_levels import TRACE


class LoggerAdapter(logging.LoggerAdapter):
    def trace(self, message, *args, **kwargs):
        if self.isEnabledFor(TRACE):
            self.log(TRACE, message, *args, **kwargs)


def get_logger(name, extra=None):
    return LoggerAdapter(logging.getLogger(name), extra or {})


def configure_logger(name, level=logging.INFO):
    logger = logging.getLogger(name)
    logger.setLevel(level)
    return logger
