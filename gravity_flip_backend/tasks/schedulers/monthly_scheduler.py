from celery import shared_task


@shared_task(queue='maintenance')
def run_monthly():
    from tasks.processors.cleanup_task import cleanup_expired_sessions
    return cleanup_expired_sessions.delay(days=90).id