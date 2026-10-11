from celery import current_app


class TaskManager:
    """Safe facade for dispatching tasks from HTTP code and services."""

    @staticmethod
    def send(task_name, *args, queue=None, countdown=None, **kwargs):
        options = {}
        if queue:
            options['queue'] = queue
        if countdown is not None:
            options['countdown'] = countdown
        return current_app.send_task(task_name, args=args, kwargs=kwargs, **options)

    @staticmethod
    def run(task_name, *args, **kwargs):
        return current_app.send_task(task_name, args=args, kwargs=kwargs).get()

    @staticmethod
    def revoke(task_id, terminate=False):
        return current_app.control.revoke(task_id, terminate=terminate)