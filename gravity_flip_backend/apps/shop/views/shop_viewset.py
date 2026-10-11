from rest_framework import serializers, status, viewsets
from rest_framework.decorators import action
from rest_framework.permissions import AllowAny, IsAuthenticated, IsAdminUser
from rest_framework.response import Response

from ..models import Order, Product
from ..serializers import CartSerializer, ProductSerializer
from ..services.cart_service import CartService
from ..services.order_service import OrderService
from ..services.product_service import ProductService


class ShopViewSet(viewsets.GenericViewSet):
    permission_classes = [IsAuthenticated]

    def get_permissions(self):
        return [AllowAny()] if self.action == 'products' else [IsAdminUser()] if self.action == 'create_product' else [IsAuthenticated()]

    @action(detail=False, methods=['get'])
    def products(self, request):
        queryset = ProductService.public_queryset()
        if request.query_params.get('category'):
            queryset = queryset.filter(category=request.query_params['category'])
        return Response(ProductSerializer(queryset, many=True).data)

    @action(detail=False, methods=['post'], url_path='products/create')
    def create_product(self, request):
        data = request.data.copy()
        quantity = data.pop('quantity', 0)
        product = ProductSerializer(data=data)
        product.is_valid(raise_exception=True)
        created = ProductService.create(data=product.validated_data, quantity=int(quantity))
        return Response(ProductSerializer(created).data, status=status.HTTP_201_CREATED)

    @action(detail=False, methods=['get'])
    def cart(self, request):
        return Response(CartSerializer(CartService.get(request.user)).data)

    @action(detail=False, methods=['post'])
    def add_to_cart(self, request):
        try:
            product = Product.objects.select_related('inventory').get(pk=request.data.get('product'))
            cart = CartService.add(user=request.user, product=product, quantity=int(request.data.get('quantity', 1)))
        except (Product.DoesNotExist, ValueError) as exc:
            raise serializers.ValidationError({'detail': str(exc)})
        return Response(CartSerializer(CartService.get(request.user)).data)

    @action(detail=False, methods=['post'])
    def checkout(self, request):
        key = request.data.get('idempotency_key')
        if not key:
            raise serializers.ValidationError({'idempotency_key': 'This field is required.'})
        try:
            order, created = OrderService.checkout(user=request.user, idempotency_key=key)
        except ValueError as exc:
            raise serializers.ValidationError({'detail': str(exc)})
        return Response({'id': str(order.id), 'status': order.status, 'total': order.total, 'created': created}, status=status.HTTP_201_CREATED if created else status.HTTP_200_OK)

    @action(detail=False, methods=['get'])
    def orders(self, request):
        orders = Order.objects.filter(user=request.user).prefetch_related('items')
        return Response([{'id': str(order.id), 'status': order.status, 'total': order.total, 'items': [{'sku': item.sku, 'name': item.name, 'quantity': item.quantity, 'total': item.total} for item in order.items.all()]} for order in orders])