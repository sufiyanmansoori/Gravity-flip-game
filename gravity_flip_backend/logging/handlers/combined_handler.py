import logging


class CombinedHandler(logging.Handler):
    """Fan out one record to child handlers without duplicate propagation."""

    def __init__(self, handlers=None):
        super().__init__()
        self.handlers = list(handlers or [])

    def emit(self, record):
        for handler in self.handlers:
            if record.levelno >= handler.level:
                handler.handle(record)

    def close(self):
        for handler in self.handlers:
            handler.close()
        super().close()
