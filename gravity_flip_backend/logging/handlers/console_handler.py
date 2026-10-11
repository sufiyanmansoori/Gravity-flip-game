import json
import logging


class ConsoleFormatter(logging.Formatter):
    def format(self, record):
        payload = {'timestamp': self.formatTime(record, '%Y-%m-%dT%H:%M:%S%z'), 'level': record.levelname, 'logger': record.name, 'message': record.getMessage(), 'module': record.module}
        if hasattr(record, 'request_id'):
            payload['request_id'] = record.request_id
        if record.exc_info:
            payload['exception'] = self.formatException(record.exc_info)
        return json.dumps(payload, default=str)


class ConsoleHandler(logging.StreamHandler):
    def __init__(self, stream=None):
        super().__init__(stream)
        self.setFormatter(ConsoleFormatter())
