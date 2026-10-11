import json
import logging
from pathlib import Path


class StructuredFileHandler(logging.handlers.RotatingFileHandler):
    def __init__(self, filename, max_bytes=10 * 1024 * 1024, backup_count=5, encoding='utf-8'):
        Path(filename).parent.mkdir(parents=True, exist_ok=True)
        super().__init__(filename, maxBytes=max_bytes, backupCount=backup_count, encoding=encoding)
        self.setFormatter(JsonFormatter())


class JsonFormatter(logging.Formatter):
    def format(self, record):
        payload = {'timestamp': self.formatTime(record, '%Y-%m-%dT%H:%M:%S%z'), 'level': record.levelname, 'logger': record.name, 'message': record.getMessage(), 'module': record.module, 'process': record.process, 'thread': record.thread}
        if hasattr(record, 'request_id'):
            payload['request_id'] = record.request_id
        if record.exc_info:
            payload['exception'] = self.formatException(record.exc_info)
        return json.dumps(payload, default=str)
