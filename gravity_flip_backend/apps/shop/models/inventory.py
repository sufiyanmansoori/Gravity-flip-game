from django.db import models

from apps.core.models import TimeStampedModel


class Inventory(TimeStampedModel):
    product = models.OneToOneField('gravity_shop.Product', on_delete=models.CASCADE, related_name='inventory')
    quantity = models.PositiveIntegerField(default=0)
    reserved = models.PositiveIntegerField(default=0)
    low_stock_threshold = models.PositiveIntegerField(default=5)

    class Meta:
        db_table = 'gravity_shop_inventory'

    @property
    def available(self):
        return max(0, self.quantity - self.reserved)