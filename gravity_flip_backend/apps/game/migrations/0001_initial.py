import uuid

import django.db.models.deletion
from django.conf import settings
from django.db import migrations, models


class Migration(migrations.Migration):
    initial = True
    dependencies = [migrations.swappable_dependency(settings.AUTH_USER_MODEL)]
    operations = [
        migrations.CreateModel(
            name='Game',
            fields=[
                ('id', models.UUIDField(default=uuid.uuid4, editable=False, primary_key=True, serialize=False)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('level_id', models.CharField(max_length=100)),
                ('status', models.CharField(choices=[('created', 'Created'), ('running', 'Running'), ('paused', 'Paused'), ('completed', 'Completed'), ('abandoned', 'Abandoned')], default='created', max_length=16)),
                ('score', models.PositiveBigIntegerField(default=0)),
                ('tick', models.PositiveBigIntegerField(default=0)),
                ('seed', models.PositiveBigIntegerField()),
                ('finished_at', models.DateTimeField(blank=True, null=True)),
                ('metadata', models.JSONField(blank=True, default=dict)),
                ('owner', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='gravity_games', to=settings.AUTH_USER_MODEL)),
            ],
            options={'db_table': 'gravity_games', 'indexes': [models.Index(fields=['owner', 'status'], name='gravity_gam_owner_i_200d65_idx'), models.Index(fields=['created_at'], name='gravity_gam_created_4d6843_idx')]},
        ),
        migrations.CreateModel(
            name='GameState',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('gravity', models.SmallIntegerField(default=1)),
                ('world_width', models.PositiveIntegerField(default=1200)),
                ('world_height', models.PositiveIntegerField(default=800)),
                ('snapshot', models.JSONField(default=dict)),
                ('checksum', models.CharField(blank=True, default='', max_length=64)),
                ('game', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='state', to='gravity_game.game')),
            ],
            options={'db_table': 'gravity_game_states'},
        ),
        migrations.CreateModel(
            name='PhysicsData',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('gravity_strength', models.FloatField(default=980.0)),
                ('jump_impulse', models.FloatField(default=420.0)),
                ('horizontal_speed', models.FloatField(default=240.0)),
                ('friction', models.FloatField(default=0.0)),
                ('fixed_timestep', models.FloatField(default=1 / 60)),
                ('game', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name='physics', to='gravity_game.game')),
            ],
            options={'db_table': 'gravity_game_physics'},
        ),
        migrations.CreateModel(
            name='Obstacle',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('obstacle_type', models.CharField(max_length=32)),
                ('x', models.FloatField()),
                ('y', models.FloatField()),
                ('width', models.FloatField()),
                ('height', models.FloatField()),
                ('velocity_x', models.FloatField(default=0)),
                ('velocity_y', models.FloatField(default=0)),
                ('active', models.BooleanField(default=True)),
                ('metadata', models.JSONField(blank=True, default=dict)),
                ('game', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='obstacles', to='gravity_game.game')),
            ],
            options={'db_table': 'gravity_game_obstacles', 'indexes': [models.Index(fields=['game', 'active'], name='gravity_gam_game_id_ace941_idx')]},
        ),
        migrations.CreateModel(
            name='Player',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('updated_at', models.DateTimeField(auto_now=True)),
                ('x', models.FloatField(default=100)),
                ('y', models.FloatField(default=400)),
                ('velocity_x', models.FloatField(default=0)),
                ('velocity_y', models.FloatField(default=0)),
                ('width', models.PositiveSmallIntegerField(default=32)),
                ('height', models.PositiveSmallIntegerField(default=32)),
                ('alive', models.BooleanField(default=True)),
                ('game', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='players', to='gravity_game.game')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='gravity_game_players', to=settings.AUTH_USER_MODEL)),
            ],
            options={'db_table': 'gravity_game_players', 'constraints': [models.UniqueConstraint(fields=('game', 'user'), name='unique_gravity_game_player')]},
        ),
    ]