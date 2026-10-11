from string import Formatter


def render_template(subject, body, context):
    fields = {name for _, name, _, _ in Formatter().parse(body) if name}
    missing = fields.difference(context)
    if missing:
        raise ValueError(f'Missing email template variables: {", ".join(sorted(missing))}')
    return subject.format_map(context), body.format_map(context)