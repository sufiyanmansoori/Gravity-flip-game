import hashlib
import hmac

from django.conf import settings


class RazorpayService:
    provider = 'razorpay'

    @staticmethod
    def verify_signature(order_id, payment_id, signature):
        secret = str(getattr(settings, 'RAZORPAY_KEY_SECRET', '')).encode()
        expected = hmac.new(secret, f'{order_id}|{payment_id}'.encode(), hashlib.sha256).hexdigest()
        return bool(secret.strip()) and hmac.compare_digest(expected, signature)

    @staticmethod
    def create_order(payment):
        key_id = getattr(settings, 'RAZORPAY_KEY_ID', '')
        secret = getattr(settings, 'RAZORPAY_KEY_SECRET', '')
        if not key_id or not secret:
            raise RuntimeError('Razorpay is not configured.')
        try:
            import razorpay
            return razorpay.Client(auth=(key_id, secret)).order.create({'amount': int(payment.amount * 100), 'currency': payment.currency, 'receipt': str(payment.id)})
        except ImportError as exc:
            raise RuntimeError('Install the razorpay package to use Razorpay payments.') from exc