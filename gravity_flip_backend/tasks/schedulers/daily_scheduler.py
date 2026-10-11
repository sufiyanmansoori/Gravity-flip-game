from celery import shared_task


@shared_task(queue='maintenance')
def run_daily():
    from tasks.processors.analytics_task import aggregate_analytics_task
    return aggregate_analytics_task.delay()