from .base import *

DEBUG = True
ALLOWED_HOSTS = ['*']

# --- CORS Settings (Frontend-Backend Connection ke liye Zaroori) ---

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',  # Yeh sabse upar hona chahiye!
    'django.middleware.common.CommonMiddleware',
    # ... baaki middleware yahan rahenge jo base.py se aa rahe hain
]

# Development mein saari origins allow karein (Flutter Web, Postman, etc.)
CORS_ALLOW_ALL_ORIGINS = True 

# Agar aap specific ports allow karna chahein toh yeh use karein:
# CORS_ALLOWED_ORIGINS = [
#     "http://localhost:57558",
#     "http://127.0.0.1:57558",
# ]

# --- Database ---
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# --- Email ---
EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

# --- Content Security Policy (Thoda Relaxed for Dev) ---
# Connect-src mein '*' add kiya taaki Flutter localhost par API call kar sake
CONTENT_SECURITY_POLICY = (
    "default-src 'self' https://cdn.jsdelivr.net; "
    "script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; "
    "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; "
    "img-src 'self' data: https://cdn.jsdelivr.net; "
    "font-src 'self' data: https://cdn.jsdelivr.net; "
    "connect-src 'self' *; " 
    "frame-ancestors 'none'; "
    "object-src 'none'; "
    "base-uri 'self'"
)

# --- Cache ---
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'gravity-flip-development-cache',
    },
}