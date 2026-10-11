from celery import shared_task


@shared_task(bind=True, autoretry_for=(ConnectionError, TimeoutError), retry_backoff=True, retry_jitter=True, max_retries=5, queue='email')
def send_email_task(self, to, subject, body, html=None):
    from external.email.sendgrid import SendGridClient
    return SendGridClient.send(to=to, subject=subject, text=body, html=html)