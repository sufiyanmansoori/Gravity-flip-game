import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Cart(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    user = models.OneToOneField(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='shop_cart')

    class Meta:
        db_table = 'gravity_shop_carts'


class CartItem(TimeStampedModel):
    cart = models.ForeignKey(Cart, on_delete=models.CASCADE, related_name='items')
    product = models.ForeignKey('gravity_shop.Product', on_delete=models.PROTECT, related_name='cart_items')
    quantity = models.PositiveIntegerField(default=1)

    class Meta:
        db_table = 'gravity_shop_cart_items'
        constraints = [models.UniqueConstraint(fields=['cart', 'product'], name='unique_cart_product')]