from __future__ import annotations

from rest_framework import generics, permissions, status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response

from .models import PaymentTransaction, SubscriptionPlan, UserSubscription
from .serializers import PaymentTransactionSerializer, SubscriptionPlanSerializer, UserSubscriptionSerializer


class PaymentTransactionListView(generics.ListCreateAPIView):
    queryset = PaymentTransaction.objects.select_related('user', 'gateway')
    serializer_class = PaymentTransactionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        qs = super().get_queryset()
        if not self.request.user.is_staff:
            qs = qs.filter(user=self.request.user)
        return qs


class SubscriptionPlanListView(generics.ListAPIView):
    queryset = SubscriptionPlan.objects.filter(is_active=True)
    serializer_class = SubscriptionPlanSerializer
    permission_classes = [permissions.AllowAny]


class UserSubscriptionListView(generics.ListAPIView):
    queryset = UserSubscription.objects.select_related('user', 'plan')
    serializer_class = UserSubscriptionSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        if self.request.user.is_staff:
            return self.queryset
        return self.queryset.filter(user=self.request.user)


@api_view(['POST'])
@permission_classes([permissions.IsAuthenticated])
def create_checkout_session(request):
    payload = {
        'user': request.user.id,
        'amount': request.data.get('amount', 0),
        'currency': request.data.get('currency', 'USD'),
        'status': 'pending',
    }
    serializer = PaymentTransactionSerializer(data=payload)
    if serializer.is_valid():
        transaction = serializer.save()
        return Response({'transaction_id': transaction.id}, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
