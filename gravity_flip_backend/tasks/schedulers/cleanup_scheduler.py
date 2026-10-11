from celery import shared_task


@shared_task(queue='maintenance')
def run_cleanup():
    from tasks.processors.cleanup_task import cleanup_expired_sessions, cleanup_old_events
    return {'sessions': cleanup_expired_sessions.delay().id, 'events': cleanup_old_events.delay().id}