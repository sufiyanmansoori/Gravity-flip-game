from decimal import Decimal

from django.db import transaction

from ..models import Order, OrderItem
from .cart_service import CartService
from .inventory_service import InventoryService


class OrderService:
    @staticmethod
    @transaction.atomic
    def checkout(*, user, idempotency_key):
        existing = Order.objects.filter(idempotency_key=idempotency_key).first()
        if existing:
            if existing.user_id != user.pk:
                raise ValueError('Idempotency key belongs to another user.')
            return existing, False
        cart = CartService.get(user)
        items = list(cart.items.select_related('product').select_for_update())
        if not items:
            raise ValueError('Cannot checkout an empty cart.')
        subtotal = Decimal('0')
        order = Order.objects.create(user=user, idempotency_key=idempotency_key, currency=items[0].product.currency)
        for item in items:
            product = item.product
            InventoryService.consume(product=product, quantity=item.quantity)
            line_total = product.price * item.quantity
            subtotal += line_total
            OrderItem.objects.create(order=order, product=product, sku=product.sku, name=product.name, unit_price=product.price, quantity=item.quantity, total=line_total)
        order.subtotal = subtotal
        order.total = subtotal
        order.save(update_fields=['subtotal', 'total', 'updated_at'])
        cart.items.all().delete()
        return order, True