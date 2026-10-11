from django.contrib.auth import password_validation
from rest_framework import serializers


class RegisterValidator(serializers.Serializer):
    username = serializers.RegexField(r'^[A-Za-z0-9_.-]{3,30}$')
    email = serializers.EmailField()
    password = serializers.CharField(write_only=True, min_length=8, trim_whitespace=False)

    def validate_password(self, value):
        password_validation.validate_password(value)
        return value