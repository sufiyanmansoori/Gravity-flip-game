import uuid

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True
    dependencies = [migrations.swappable_dependency(settings.AUTH_USER_MODEL)]
    operations = [
        migrations.CreateModel(
            name='AuthSession',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('session_key', models.UUIDField(default=uuid.uuid4, editable=False, unique=True)),
                ('device_name', models.CharField(blank=True, default='', max_length=255)),
                ('ip_address', models.GenericIPAddressField(blank=True, null=True)),
                ('user_agent', models.TextField(blank=True, default='')),
                ('last_seen_at', models.DateTimeField(auto_now=True)),
                ('revoked_at', models.DateTimeField(blank=True, null=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auth_sessions', to=settings.AUTH_USER_MODEL)),
            ],
            options={'db_table': 'auth_sessions', 'indexes': [models.Index(fields=['user', 'revoked_at'], name='auth_sessio_user_id_2e5dd5_idx')]},
        ),
        migrations.CreateModel(
            name='OneTimePassword',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('purpose', models.CharField(choices=[('verify_email', 'Verify email'), ('reset_password', 'Reset password'), ('two_factor', 'Two-factor authentication')], max_length=32)),
                ('code_hash', models.CharField(max_length=128)),
                ('expires_at', models.DateTimeField()),
                ('used_at', models.DateTimeField(blank=True, null=True)),
                ('attempts', models.PositiveSmallIntegerField(default=0)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='one_time_passwords', to=settings.AUTH_USER_MODEL)),
            ],
            options={'db_table': 'auth_one_time_passwords', 'indexes': [models.Index(fields=['user', 'purpose', 'created_at'], name='auth_one_ti_user_id_6d5e0d_idx')]},
        ),
        migrations.CreateModel(
            name='RefreshToken',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('jti', models.UUIDField(default=uuid.uuid4, editable=False, unique=True)),
                ('token_hash', models.CharField(max_length=128, unique=True)),
                ('expires_at', models.DateTimeField()),
                ('revoked_at', models.DateTimeField(blank=True, null=True)),
                ('replaced_by', models.UUIDField(blank=True, null=True)),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='auth_refresh_tokens', to=settings.AUTH_USER_MODEL)),
            ],
            options={'db_table': 'auth_refresh_tokens', 'indexes': [models.Index(fields=['user', 'revoked_at'], name='auth_refres_user_id_3a0a03_idx'), models.Index(fields=['expires_at'], name='auth_refres_expires_0a7b9b_idx')]},
        ),
    ]