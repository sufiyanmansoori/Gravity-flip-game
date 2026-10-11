from rest_framework import serializers, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response

from ..models import Payment, Subscription
from ..serializers import CreatePaymentSerializer, SubscriptionSerializer
from ..services.payment_service import PaymentService
from ..services.refund_service import RefundService
from ..services.subscription_service import SubscriptionService


class PaymentViewSet(viewsets.GenericViewSet):
    queryset = Payment.objects.select_related('user')
    permission_classes = [IsAuthenticated]

    def list(self, request):
        payments = self.queryset.filter(user=request.user)
        return Response([self._payment_data(payment) for payment in payments])

    def create(self, request):
        serializer = CreatePaymentSerializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        data = dict(serializer.validated_data)
        data.pop('plan', None)
        try:
            payment, created, checkout = PaymentService.create(user=request.user, **data)
        except (RuntimeError, ValueError) as exc:
            raise serializers.ValidationError({'detail': str(exc)})
        return Response({'payment': self._payment_data(payment), 'checkout': checkout}, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=True, methods=['post'])
    def refund(self, request, pk=None):
        payment = self.get_queryset().get(pk=pk)
        try:
            payment = RefundService.refund(payment, request.data.get('amount'))
        except ValueError as exc:
            raise serializers.ValidationError({'detail': str(exc)})
        return Response(self._payment_data(payment))

    @action(detail=False, methods=['get'])
    def subscriptions(self, request):
        return Response(SubscriptionSerializer(SubscriptionService.active_for_user(request.user), many=True).data)

    @staticmethod
    def _payment_data(payment):
        return {'id': str(payment.id), 'amount': payment.amount, 'currency': payment.currency, 'provider': payment.provider, 'status': payment.status, 'provider_payment_id': payment.provider_payment_id, 'created_at': payment.created_at}