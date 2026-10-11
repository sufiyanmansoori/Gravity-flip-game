from django.db import connection


def count_rows(model):
    return model.objects.count()


def clear_model(model):
    deleted, _ = model.objects.all().delete()
    return deleted


def database_vendor():
    return connection.vendor