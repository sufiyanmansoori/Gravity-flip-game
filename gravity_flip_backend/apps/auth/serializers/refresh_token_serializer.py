from rest_framework import serializers


class RefreshTokenSerializer(serializers.Serializer):
    refresh = serializers.CharField(min_length=20, trim_whitespace=True)