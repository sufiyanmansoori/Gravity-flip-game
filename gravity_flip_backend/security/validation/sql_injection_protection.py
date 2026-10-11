import re


_IDENTIFIER = re.compile(r'^[A-Za-z_][A-Za-z0-9_]*$')


def validate_identifier(identifier):
    """Validate dynamic SQL identifiers; values must still use query parameters."""
    if not isinstance(identifier, str) or not _IDENTIFIER.fullmatch(identifier):
        raise ValueError('Invalid SQL identifier.')
    return identifier


def validate_ordering(ordering, allowed_fields):
    field = ordering[1:] if ordering.startswith('-') else ordering
    validate_identifier(field)
    if field not in set(allowed_fields):
        raise ValueError('Unsupported ordering field.')
    return ordering
