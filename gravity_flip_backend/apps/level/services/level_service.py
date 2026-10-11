from django.db import transaction
from django.utils import timezone

from ..models import Level, LevelConfiguration, LevelProgression


class LevelService:
    @staticmethod
    @transaction.atomic
    def create(*, data, created_by=None):
        config_data = data.pop('configuration', {})
        level = Level.objects.create(created_by=created_by, **data)
        LevelConfiguration.objects.create(level=level, **config_data)
        return level

    @staticmethod
    @transaction.atomic
    def publish(level):
        if not level.configuration:
            raise ValueError('A level must have configuration before publishing.')
        if level.status == Level.Status.ARCHIVED:
            raise ValueError('Archived levels cannot be published.')
        level.status = Level.Status.PUBLISHED
        level.published_at = timezone.now()
        level.save(update_fields=['status', 'published_at', 'updated_at'])
        return level

    @staticmethod
    @transaction.atomic
    def archive(level):
        level.status = Level.Status.ARCHIVED
        level.save(update_fields=['status', 'updated_at'])
        return level

    @staticmethod
    def public_queryset():
        return Level.objects.filter(status=Level.Status.PUBLISHED).select_related('difficulty', 'configuration', 'progression')

    @staticmethod
    @transaction.atomic
    def clone_version(level, *, created_by=None):
        original_slug = level.slug
        level.pk = None
        level.id = None
        level.version += 1
        level.slug = f'{original_slug}-v{level.version}'
        level.status = Level.Status.DRAFT
        level.published_at = None
        level.created_by = created_by or level.created_by
        level.save()
        configuration = level.configuration
        configuration.pk = None
        configuration.id = None
        configuration.level = level
        configuration.save()
        return level