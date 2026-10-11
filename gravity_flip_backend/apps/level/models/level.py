import uuid

from django.conf import settings
from django.db import models

from apps.core.models import TimeStampedModel


class Level(TimeStampedModel):
    class Status(models.TextChoices):
        DRAFT = 'draft', 'Draft'
        PUBLISHED = 'published', 'Published'
        ARCHIVED = 'archived', 'Archived'

    id = models.UUIDField(primary_key=True, default=uuid.uuid4, editable=False)
    slug = models.SlugField(max_length=100, unique=True)
    title = models.CharField(max_length=150)
    description = models.TextField(blank=True, default='')
    difficulty = models.ForeignKey('gravity_level.Difficulty', on_delete=models.PROTECT, related_name='levels')
    status = models.CharField(max_length=16, choices=Status.choices, default=Status.DRAFT)
    version = models.PositiveIntegerField(default=1)
    seed = models.PositiveBigIntegerField(default=0)
    definition = models.JSONField(default=dict, blank=True)
    created_by = models.ForeignKey(settings.AUTH_USER_MODEL, null=True, blank=True, on_delete=models.SET_NULL, related_name='created_levels')
    published_at = models.DateTimeField(null=True, blank=True)

    class Meta:
        db_table = 'gravity_levels'
        ordering = ['difficulty__rank', 'slug']
        indexes = [models.Index(fields=['status', 'difficulty']), models.Index(fields=['slug', 'version'])]

    def __str__(self):
        return f'{self.title} v{self.version}'