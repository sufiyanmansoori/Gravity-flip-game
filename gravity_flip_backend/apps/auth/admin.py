from django.contrib import admin

from .models import AuthSession, OneTimePassword, RefreshToken


@admin.register(RefreshToken)
class RefreshTokenAdmin(admin.ModelAdmin):
    list_display = ('user', 'jti', 'expires_at', 'revoked_at', 'created_at')
    list_filter = ('revoked_at', 'created_at')
    search_fields = ('user__username', 'user__email', 'jti')
    readonly_fields = ('token_hash', 'created_at', 'updated_at')


@admin.register(OneTimePassword)
class OneTimePasswordAdmin(admin.ModelAdmin):
    list_display = ('user', 'purpose', 'expires_at', 'used_at', 'attempts')
    list_filter = ('purpose', 'used_at')
    search_fields = ('user__username', 'user__email')
    readonly_fields = ('code_hash', 'created_at', 'updated_at')


@admin.register(AuthSession)
class AuthSessionAdmin(admin.ModelAdmin):
    list_display = ('user', 'device_name', 'last_seen_at', 'revoked_at')
    list_filter = ('revoked_at', 'created_at')
    search_fields = ('user__username', 'user__email', 'session_key')
    readonly_fields = ('session_key', 'created_at', 'updated_at')