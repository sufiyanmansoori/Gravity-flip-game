from decimal import Decimal

from django.test import TestCase
from rest_framework.test import APIClient

from apps.shop.models import Inventory, Order, Product
from apps.shop.services.cart_service import CartService
from apps.shop.services.order_service import OrderService
from apps.shop.services.product_service import ProductService
from apps.users.models import User


class ShopServiceTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='buyer', password='Strong-password-123')
        self.product = ProductService.create(data={'sku': 'COS-001', 'slug': 'starter-cosmetic', 'name': 'Starter Cosmetic', 'price': Decimal('4.99'), 'currency': 'USD'}, quantity=3)

    def test_checkout_consumes_inventory_and_is_idempotent(self):
        self.assertEqual(Inventory.objects.get(product=self.product).quantity, 3)
        CartService.add(user=self.user, product=self.product, quantity=2)
        self.assertEqual(self.user.shop_cart.items.get().quantity, 2)
        order, created = OrderService.checkout(user=self.user, idempotency_key='checkout-1')
        duplicate, duplicate_created = OrderService.checkout(user=self.user, idempotency_key='checkout-1')
        inventory = Inventory.objects.get(product=self.product)
        self.assertTrue(created)
        self.assertFalse(duplicate_created)
        self.assertEqual(order.pk, duplicate.pk)
        self.assertEqual(inventory.quantity, 1)
        self.assertEqual(order.total, Decimal('9.98'))

    def test_checkout_rejects_insufficient_inventory(self):
        CartService.add(user=self.user, product=self.product, quantity=2)
        other = User.objects.create_user(username='buyer2', password='Strong-password-123')
        CartService.add(user=other, product=self.product, quantity=2)
        OrderService.checkout(user=self.user, idempotency_key='checkout-1')
        with self.assertRaises(ValueError):
            OrderService.checkout(user=other, idempotency_key='checkout-2')


class ShopIntegrationTests(TestCase):
    def setUp(self):
        self.user = User.objects.create_user(username='buyer', password='Strong-password-123')
        self.client = APIClient()
        self.client.force_authenticate(self.user)
        self.product = ProductService.create(data={'sku': 'COS-002', 'slug': 'second-cosmetic', 'name': 'Second Cosmetic', 'price': Decimal('2.50'), 'currency': 'USD'}, quantity=5)

    def test_shop_checkout_endpoint(self):
        self.client.post('/api/v1/shop/add_to_cart/', {'product': str(self.product.pk), 'quantity': 1}, format='json')
        response = self.client.post('/api/v1/shop/checkout/', {'idempotency_key': 'api-checkout-1'}, format='json')
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.data['status'], Order.Status.PENDING)