from django.contrib import admin

from .models import Cart, CartItem, Inventory, Order, OrderItem, Product


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ('sku', 'name', 'price', 'currency', 'category', 'is_active')
    list_filter = ('is_active', 'category', 'currency')
    search_fields = ('sku', 'name', 'slug')
    readonly_fields = ('id', 'created_at', 'updated_at')


@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
    list_display = ('id', 'user', 'total', 'currency', 'status', 'created_at')
    list_filter = ('status', 'currency')
    search_fields = ('id', 'user__username', 'user__email', 'idempotency_key')
    readonly_fields = ('id', 'created_at', 'updated_at')


admin.site.register((Inventory, Cart, CartItem, OrderItem))