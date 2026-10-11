from django.db import transaction

from ..models import Cart, CartItem, Product


class CartService:
    @staticmethod
    def get(user):
        cart, _ = Cart.objects.get_or_create(user=user)
        return Cart.objects.prefetch_related('items__product__inventory').get(pk=cart.pk)

    @staticmethod
    @transaction.atomic
    def add(*, user, product, quantity):
        if quantity <= 0:
            raise ValueError('Quantity must be positive.')
        if not product.is_active:
            raise ValueError('Product is not available.')
        cart, _ = Cart.objects.get_or_create(user=user)
        item, _ = CartItem.objects.select_for_update().get_or_create(cart=cart, product=product, defaults={'quantity': 0})
        new_quantity = item.quantity + quantity
        if product.inventory.available < new_quantity:
            raise ValueError('Requested quantity exceeds available inventory.')
        item.quantity = new_quantity
        item.save(update_fields=['quantity', 'updated_at'])
        return cart

    @staticmethod
    @transaction.atomic
    def remove(*, user, product, quantity=None):
        cart = Cart.objects.get(user=user)
        item = CartItem.objects.select_for_update().get(cart=cart, product=product)
        if quantity is None or quantity >= item.quantity:
            item.delete()
        else:
            item.quantity -= quantity
            item.save(update_fields=['quantity', 'updated_at'])
        return cart