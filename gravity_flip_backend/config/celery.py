from __future__ import annotations

import os
import importlib

from celery import Celery

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.dev')

app = Celery('gravity_flip_backend')
app.config_from_object('django.conf:settings', namespace='CELERY')
app.conf.update(
    task_default_queue='default',
    task_routes={
        'tasks.processors.email_task.*': {'queue': 'email'},
        'tasks.processors.notification_task.*': {'queue': 'notifications'},
        'tasks.processors.analytics_task.*': {'queue': 'analytics'},
        'tasks.processors.image_task.*': {'queue': 'media'},
        'tasks.processors.payment_task.*': {'queue': 'payments'},
        'tasks.processors.cleanup_task.*': {'queue': 'maintenance'},
    },
    beat_schedule={
        'daily-maintenance': {'task': 'tasks.schedulers.daily_scheduler.run_daily', 'schedule': 86400.0},
        'weekly-maintenance': {'task': 'tasks.schedulers.weekly_scheduler.run_weekly', 'schedule': 604800.0},
        'monthly-maintenance': {'task': 'tasks.schedulers.monthly_scheduler.run_monthly', 'schedule': 2592000.0},
        'cleanup-maintenance': {'task': 'tasks.schedulers.cleanup_scheduler.run_cleanup', 'schedule': 21600.0},
    },
)
app.conf.imports = (
    'tasks.processors.email_task',
    'tasks.processors.notification_task',
    'tasks.processors.analytics_task',
    'tasks.processors.image_task',
    'tasks.processors.payment_task',
    'tasks.processors.cleanup_task',
    'tasks.schedulers.daily_scheduler',
    'tasks.schedulers.weekly_scheduler',
    'tasks.schedulers.monthly_scheduler',
    'tasks.schedulers.cleanup_scheduler',
)
for task_module in app.conf.imports:
    importlib.import_module(task_module)
app.autodiscover_tasks()


@app.task(bind=True)
def debug_task(self):
    print(f'Request: {self.request!r}')
