from rest_framework import serializers

from ..models import Cart, CartItem


class CartItemSerializer(serializers.ModelSerializer):
    product = serializers.SerializerMethodField()
    line_total = serializers.SerializerMethodField()

    class Meta:
        model = CartItem
        fields = ['id', 'product', 'quantity', 'line_total']

    def get_product(self, obj):
        from .product_serializer import ProductSerializer
        return ProductSerializer(obj.product).data

    def get_line_total(self, obj):
        return obj.product.price * obj.quantity


class CartSerializer(serializers.ModelSerializer):
    items = CartItemSerializer(many=True, read_only=True)
    subtotal = serializers.SerializerMethodField()

    class Meta:
        model = Cart
        fields = ['id', 'items', 'subtotal', 'updated_at']

    def get_subtotal(self, obj):
        return sum((item.product.price * item.quantity for item in obj.items.all()), 0)