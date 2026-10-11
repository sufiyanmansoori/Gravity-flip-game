from celery import shared_task


@shared_task(queue='media')
def process_image_task(source_path, destination_path=None, max_width=2048, max_height=2048):
    from pathlib import Path
    from PIL import Image
    source = Path(source_path)
    destination = Path(destination_path or source_path)
    with Image.open(source) as image:
        image.thumbnail((max_width, max_height), Image.Resampling.LANCZOS)
        image.save(destination, optimize=True)
    return {'path': str(destination), 'width': image.width, 'height': image.height}