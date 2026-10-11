from string import Formatter

from ..models import NotificationTemplate


class NotificationTemplateService:
    @staticmethod
    def render(template, context):
        fields = {name for _, name, _, _ in Formatter().parse(template.body) if name}
        missing = fields.difference(context)
        if missing:
            raise ValueError(f'Missing template variables: {", ".join(sorted(missing))}')
        subject = template.subject.format_map(context)
        body = template.body.format_map(context)
        return subject, body

    @staticmethod
    def get(code, channel):
        return NotificationTemplate.objects.get(code=code, channel=channel, is_active=True)