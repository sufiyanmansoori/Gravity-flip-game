from django.conf import settings

from .twilio_client import TwilioClient


class TwilioService:
    @staticmethod
    def send_sms(to, body):
        message = TwilioClient.client().messages.create(body=body, from_=settings.TWILIO_FROM_NUMBER, to=to)
        return {'sid': message.sid, 'status': message.status}

    @staticmethod
    def make_call(to, url):
        call = TwilioClient.client().calls.create(url=url, from_=settings.TWILIO_FROM_NUMBER, to=to)
        return {'sid': call.sid, 'status': call.status}