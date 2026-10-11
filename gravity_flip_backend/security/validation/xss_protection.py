import html


def escape_html(value):
    return html.escape(str(value), quote=True)


def sanitize_html(value):
    """Return text-safe output; rich HTML should use a maintained allow-list sanitizer."""
    return escape_html(value)
