import uuid

from django.db import models

from apps.core.models import TimeStampedModel


class Product(TimeStampedModel):
    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    sku = models.CharField(max_length=64, unique=True)
    slug = models.SlugField(max_length=120, unique=True)
    name = models.CharField(max_length=180)
    description = models.TextField(blank=True, default='')
    price = models.DecimalField(max_digits=12, decimal_places=2)
    currency = models.CharField(max_length=3, default='USD')
    category = models.CharField(max_length=80, blank=True, default='')
    is_active = models.BooleanField(default=True)
    metadata = models.JSONField(default=dict, blank=True)

    class Meta:
        db_table = 'gravity_shop_products'
        ordering = ['name']
        indexes = [models.Index(fields=['is_active', 'category'])]

    def __str__(self):
        return f'{self.name} ({self.sku})'