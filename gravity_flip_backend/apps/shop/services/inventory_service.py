from django.db import transaction

from ..models import Inventory, Product


class InventoryService:
    @staticmethod
    @transaction.atomic
    def restock(*, product, quantity):
        if quantity <= 0:
            raise ValueError('Restock quantity must be positive.')
        inventory = Inventory.objects.select_for_update().get(product=product)
        inventory.quantity += quantity
        inventory.save(update_fields=['quantity', 'updated_at'])
        return inventory

    @staticmethod
    @transaction.atomic
    def reserve(*, product, quantity):
        inventory = Inventory.objects.select_for_update().get(product=product)
        if quantity <= 0 or inventory.available < quantity:
            raise ValueError(f'Insufficient inventory for {product.sku}.')
        inventory.reserved += quantity
        inventory.save(update_fields=['reserved', 'updated_at'])
        return inventory

    @staticmethod
    @transaction.atomic
    def consume(*, product, quantity):
        inventory = Inventory.objects.select_for_update().get(product=product)
        if quantity <= 0 or inventory.quantity < quantity:
            raise ValueError(f'Insufficient inventory for {product.sku}.')
        inventory.quantity -= quantity
        inventory.reserved = max(0, inventory.reserved - quantity)
        inventory.save(update_fields=['quantity', 'reserved', 'updated_at'])
        return inventory