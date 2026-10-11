from pathlib import Path


def build_logging_config(base_dir, debug=False, log_level='INFO'):
    log_dir = Path(base_dir) / 'logs'
    level = log_level.upper() if isinstance(log_level, str) else log_level
    return {
        'version': 1,
        'disable_existing_loggers': False,
        'formatters': {
            'verbose': {'format': '{levelname} {asctime} {name} {process:d} {thread:d} {message}', 'style': '{'},
            'json': {'()': 'logging.handlers.JsonFormatter'},
        },
        'handlers': {
            'console': {'class': 'logging.handlers.ConsoleHandler', 'level': level},
            'application_file': {'class': 'logging.handlers.StructuredFileHandler', 'filename': str(log_dir / 'application.log'), 'max_bytes': 10 * 1024 * 1024, 'backup_count': 5, 'level': level},
            'error_file': {'class': 'logging.handlers.StructuredFileHandler', 'filename': str(log_dir / 'error.log'), 'max_bytes': 10 * 1024 * 1024, 'backup_count': 10, 'level': 'ERROR'},
        },
        'root': {'handlers': ['console', 'application_file'], 'level': level},
        'loggers': {
            'django.request': {'handlers': ['console', 'error_file'], 'level': 'ERROR', 'propagate': False},
            'django.security': {'handlers': ['console', 'error_file'], 'level': 'WARNING', 'propagate': False},
        },
    }
