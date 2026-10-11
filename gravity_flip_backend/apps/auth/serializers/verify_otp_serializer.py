from rest_framework import serializers


class VerifyOTPSerializer(serializers.Serializer):
    code = serializers.RegexField(r'^\d{6}$')