import unicodedata


def sanitize_text(value, max_length=500, strip=True):
    if value is None:
        return ''
    value = unicodedata.normalize('NFKC', str(value))
    value = ''.join(char for char in value if char.isprintable() or char in '\n\t')
    return value.strip()[:max_length] if strip else value[:max_length]


def sanitize_mapping(mapping, allowed_keys, max_value_length=500):
    return {key: sanitize_text(mapping[key], max_value_length) for key in allowed_keys if key in mapping}
