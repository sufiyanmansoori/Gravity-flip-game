class ProductIndex:
    name = 'gravity-products'
    mapping = {'properties': {'id': {'type': 'keyword'}, 'sku': {'type': 'keyword'}, 'slug': {'type': 'keyword'}, 'name': {'type': 'text'}, 'description': {'type': 'text'}, 'category': {'type': 'keyword'}, 'price': {'type': 'scaled_float', 'scaling_factor': 100}, 'currency': {'type': 'keyword'}, 'is_active': {'type': 'boolean'}}}

    @staticmethod
    def document(product):
        return {'id': str(product.pk), 'sku': product.sku, 'slug': product.slug, 'name': product.name, 'description': product.description, 'category': product.category, 'price': float(product.price), 'currency': product.currency, 'is_active': product.is_active}