from rest_framework import serializers

from ..models import Product


class ProductSerializer(serializers.ModelSerializer):
    available = serializers.SerializerMethodField()

    class Meta:
        model = Product
        fields = ['id', 'sku', 'slug', 'name', 'description', 'price', 'currency', 'category', 'available', 'metadata']
        read_only_fields = ['id', 'available']

    def get_available(self, obj):
        return obj.inventory.available if hasattr(obj, 'inventory') else 0