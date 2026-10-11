from rest_framework import serializers


class ResetPasswordSerializer(serializers.Serializer):
    email = serializers.EmailField()
    code = serializers.RegexField(r'^\d{6}$')
    new_password = serializers.CharField(min_length=8, write_only=True, trim_whitespace=False)