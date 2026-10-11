from datetime import timedelta

TASK_DEFAULT_QUEUE = 'default'
TASK_QUEUES = ('default', 'email', 'notifications', 'analytics', 'media', 'payments', 'maintenance')
TASK_ROUTES = {
    'tasks.processors.email_task.*': {'queue': 'email'},
    'tasks.processors.notification_task.*': {'queue': 'notifications'},
    'tasks.processors.analytics_task.*': {'queue': 'analytics'},
    'tasks.processors.image_task.*': {'queue': 'media'},
    'tasks.processors.payment_task.*': {'queue': 'payments'},
    'tasks.processors.cleanup_task.*': {'queue': 'maintenance'},
}
TASK_RETRY = {'max_retries': 5, 'countdown': 60, 'backoff': True, 'jitter': True}
BEAT_SCHEDULE = {
    'daily-maintenance': {'task': 'tasks.schedulers.daily_scheduler.run_daily', 'schedule': timedelta(days=1)},
    'weekly-maintenance': {'task': 'tasks.schedulers.weekly_scheduler.run_weekly', 'schedule': timedelta(days=7)},
    'monthly-maintenance': {'task': 'tasks.schedulers.monthly_scheduler.run_monthly', 'schedule': timedelta(days=30)},
    'cleanup-maintenance': {'task': 'tasks.schedulers.cleanup_scheduler.run_cleanup', 'schedule': timedelta(hours=6)},
}