from django.db.models import Prefetch

from ..models import Inventory, Product


class ProductService:
    @staticmethod
    def public_queryset():
        return Product.objects.filter(is_active=True).prefetch_related('inventory')

    @staticmethod
    def create(*, data, quantity=0):
        product = Product.objects.create(**data)
        Inventory.objects.create(product=product, quantity=quantity)
        return product
