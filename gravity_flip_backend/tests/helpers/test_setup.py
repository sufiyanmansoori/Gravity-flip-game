from rest_framework.test import APIClient
from django.test import TestCase, override_settings


class ServiceTestCase(TestCase):
    reset_sequences = False


@override_settings(CACHES={'default': {'BACKEND': 'django.core.cache.backends.locmem.LocMemCache', 'LOCATION': 'shared-test-cache'}})
class APIClientTestCase(ServiceTestCase):
    def setUp(self):
        super().setUp()
        self.client = APIClient()

    def authenticate(self, user):
        self.client.force_authenticate(user=user)
        return self.client