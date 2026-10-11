#!/usr/bin/env python
import os
import sys


def print_local_urls() -> None:
    server = next((argument for argument in sys.argv[2:] if ':' in argument), '127.0.0.1:8000')
    if server.startswith('['):
        host, _, port = server.rpartition(':')
        base_url = f'http://{host}:{port}'
    elif ':' in server:
        host, port = server.rsplit(':', 1)
        base_url = f'http://{host}:{port}'
    else:
        base_url = f'http://{server}:8000'
    print('\nGravity Flip Backend URLs:')
    print(f'  Home:    {base_url}/')
    print(f'  Health:  {base_url}/health/')
    print(f'  Admin:   {base_url}/admin/')
    print(f'  Swagger: {base_url}/api/docs/\n')


def main() -> None:
    os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'config.settings.dev')
    try:
        from django.core.management import execute_from_command_line
    except ImportError as exc:
        raise ImportError(
            "Couldn't import Django. Are you sure it's installed and available on "
            "your PYTHONPATH environment variable? Did you forget to activate a virtual environment?"
        ) from exc
    if len(sys.argv) > 1 and sys.argv[1] == 'runserver':
        print_local_urls()
    execute_from_command_line(sys.argv)


if __name__ == '__main__':
    main()
