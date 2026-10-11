from celery import shared_task


@shared_task(queue='maintenance')
def run_weekly():
    from tasks.processors.cleanup_task import cleanup_old_events
    return cleanup_old_events.delay(days=180).id