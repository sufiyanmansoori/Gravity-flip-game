from __future__ import annotations

import os
from pathlib import Path

import environ
from logging.log_config import build_logging_config

BASE_DIR = Path(__file__).resolve().parent.parent.parent

env = environ.Env(
    DEBUG=(bool, False),
    ALLOWED_HOSTS=(list, ['localhost', '127.0.0.1']),
)

environ.Env.read_env(BASE_DIR / '.env')

SECRET_KEY = env('SECRET_KEY', default='development-secret-key-change-me')
DEBUG = env('DEBUG')
ALLOWED_HOSTS = env.list('ALLOWED_HOSTS', default=['localhost', '127.0.0.1'])

SITE_ID = 1

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'django.contrib.sites',
    
    # Third Party
    'rest_framework',
    'rest_framework.authtoken',
    'corsheaders',
    'drf_spectacular',
    'channels',
    
    # Local Apps
    'apps.users',
    'apps.user',
    'apps.auth',
    'apps.game',
    'apps.level',
    'apps.score',
    'apps.achievement',
    'apps.payment',
    'apps.payments',
    'apps.notification',
    'apps.notifications',
    'apps.admin',
    'apps.shop',
    'apps.games',
    'apps.leaderboards',
    'apps.analytics',
    'apps.core',
]

# ⚠️ FIX: CorsMiddleware SABSE UPAR hona chahiye!
# config/settings/base.py

MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',      # 1. Sabse Upar (CORS ke liye)
    'django.middleware.security.SecurityMiddleware', # 2. Security
    'security.helmet_config.HelmetMiddleware',     # 3. Custom Helmet
    'whitenoise.middleware.WhiteNoiseMiddleware',  # 4. Static Files
    'django.contrib.sessions.middleware.SessionMiddleware', # 5. Sessions (Zaroori)
    'django.middleware.common.CommonMiddleware',   # 6. Common
    'django.middleware.csrf.CsrfViewMiddleware',   # 7. CSRF
    'django.contrib.auth.middleware.AuthenticationMiddleware', # 8. Auth (Zaroori)
    'django.contrib.messages.middleware.MessageMiddleware',    # 9. Messages (Zaroori)
    'django.middleware.clickjacking.XFrameOptionsMiddleware', # 10. Clickjacking
]
ROOT_URLCONF = 'config.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [BASE_DIR / 'templates'],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'config.wsgi.application'
ASGI_APPLICATION = 'config.asgi.application'

# ✅ FIX: Development ke liye SQLite use karein (PostgreSQL ki zaroorat nahi)
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

AUTH_PASSWORD_VALIDATORS = [
    {'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator'},
    {'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator'},
    {'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator'},
    {'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator'},
]

AUTH_USER_MODEL = 'users.User'

LANGUAGE_CODE = 'en-us'
TIME_ZONE = 'UTC'
USE_I18N = True
USE_TZ = True

STATIC_URL = '/static/'
STATIC_ROOT = BASE_DIR / 'staticfiles'
STATICFILES_DIRS = [BASE_DIR / 'static']
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'

REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': [
        'apps.auth.authentication.JWTAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        'rest_framework.authentication.TokenAuthentication',
    ],
    'DEFAULT_PERMISSION_CLASSES': [
        'rest_framework.permissions.IsAuthenticated',
    ],
    'DEFAULT_THROTTLE_CLASSES': [
        'rest_framework.throttling.AnonRateThrottle',
        'rest_framework.throttling.UserRateThrottle',
    ],
    'DEFAULT_THROTTLE_RATES': {
        'anon': '30/minute',
        'user': '120/minute',
        'auth': '10/minute',
        'payment': '20/minute',
    },
    'DEFAULT_RENDERER_CLASSES': ['rest_framework.renderers.JSONRenderer'],
    'DEFAULT_PARSER_CLASSES': [
        'rest_framework.parsers.JSONParser',
        'rest_framework.parsers.FormParser',
        'rest_framework.parsers.MultiPartParser',
    ],
    'DEFAULT_VERSIONING_CLASS': 'rest_framework.versioning.URLPathVersioning',
    'DEFAULT_VERSION': 'v1',
    'ALLOWED_VERSIONS': ['v1'],
    'DEFAULT_SCHEMA_CLASS': 'drf_spectacular.openapi.AutoSchema',
}

SPECTACULAR_SETTINGS = {
    'TITLE': 'Gravity Flip Game API',
    'DESCRIPTION': 'Production API for the Gravity Flip Game backend',
    'VERSION': '1.0.0',
    'SERVE_INCLUDE_SCHEMA': False,
}

# ✅ FIX: Flutter Web Port Add Kiya
CORS_ALLOWED_ORIGINS = [
    'http://localhost:3000',
    'http://127.0.0.1:3000',
    'http://localhost:8080',
    'https://gravityflipgame.com',
    'http://localhost:57558',  # Flutter Web Debug Port
    'http://127.0.0.1:57558',
]
CORS_ALLOW_CREDENTIALS = True

SECURE_CONTENT_TYPE_NOSNIFF = True
SECURE_REFERRER_POLICY = 'strict-origin-when-cross-origin'
X_FRAME_OPTIONS = 'DENY'

# ✅ FIX: CSP Update - Connect-src mein '*' add kiya
CONTENT_SECURITY_POLICY = (
    "default-src 'self'; "
    "frame-ancestors 'none'; "
    "object-src 'none'; "
    "base-uri 'self'; "
    "connect-src 'self' *; "
    "script-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; "
    "style-src 'self' 'unsafe-inline' https://cdn.jsdelivr.net; "
    "img-src 'self' data: https://cdn.jsdelivr.net; "
    "font-src 'self' data: https://cdn.jsdelivr.net;"
)

# ✅ FIX: Redis ki jagah Local Memory Cache use karein (Development ke liye safe)
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'unique-snowflake',
    }
}

# ✅ FIX: Channels Layer ko comment out kiya (Redis nahi chahiye abhi)
# CHANNEL_LAYERS = {
#     'default': {
#         'BACKEND': 'channels.layers.InMemoryChannelLayer',
#     },
# }

CELERY_BROKER_URL = env('CELERY_BROKER_URL', default='redis://localhost:6379/1')
CELERY_RESULT_BACKEND = env('CELERY_RESULT_BACKEND', default='redis://localhost:6379/2')
CELERY_ACCEPT_CONTENT = ['json']
CELERY_TASK_SERIALIZER = 'json'
CELERY_RESULT_SERIALIZER = 'json'
CELERY_TIMEZONE = TIME_ZONE
CELERY_TASK_TRACK_STARTED = True
CELERY_TASK_ACKS_LATE = True
CELERY_WORKER_PREFETCH_MULTIPLIER = 1
CELERY_TASK_REJECT_ON_WORKER_LOSS = True

AUTHENTICATION_BACKENDS = [
    'django.contrib.auth.backends.ModelBackend',
]

LOGGING = build_logging_config(BASE_DIR, debug=DEBUG, log_level=env('LOG_LEVEL', default='DEBUG' if DEBUG else 'INFO'))

JWT_SECRET = env('JWT_SECRET', default='jwt-secret-dev')

EMAIL_BACKEND = env('EMAIL_BACKEND', default='django.core.mail.backends.console.EmailBackend')
EMAIL_HOST = env('EMAIL_HOST', default='localhost')
EMAIL_PORT = int(env('EMAIL_PORT', default='587'))
EMAIL_HOST_USER = env('EMAIL_HOST_USER', default='')
EMAIL_HOST_PASSWORD = env('EMAIL_HOST_PASSWORD', default='')
EMAIL_USE_TLS = env('EMAIL_USE_TLS', default=True)
DEFAULT_FROM_EMAIL = env('DEFAULT_FROM_EMAIL', default='noreply@gravityflipgame.com')

# ... Baaki keys (Stripe, PayPal, etc.) wahi rahengi ...
STRIPE_SECRET_KEY = env('STRIPE_SECRET_KEY', default='')
STRIPE_WEBHOOK_SECRET = env('STRIPE_WEBHOOK_SECRET', default='')
PAYPAL_CLIENT_ID = env('PAYPAL_CLIENT_ID', default='')
PAYPAL_CLIENT_SECRET = env('PAYPAL_CLIENT_SECRET', default='')
RAZORPAY_KEY_ID = env('RAZORPAY_KEY_ID', default='')
RAZORPAY_KEY_SECRET = env('RAZORPAY_KEY_SECRET', default='')
RAZORPAY_WEBHOOK_SECRET = env('RAZORPAY_WEBHOOK_SECRET', default='')
SMS_PROVIDER_URL = env('SMS_PROVIDER_URL', default='')
PUSH_PROVIDER_URL = env('PUSH_PROVIDER_URL', default='')
FIREBASE_CREDENTIALS_PATH = env('FIREBASE_CREDENTIALS_PATH', default='')
AWS_REGION = env('AWS_REGION', default='us-east-1')
AWS_ACCESS_KEY_ID = env('AWS_ACCESS_KEY_ID', default='')
AWS_SECRET_ACCESS_KEY = env('AWS_SECRET_ACCESS_KEY', default='')
AWS_STORAGE_BUCKET_NAME = env('AWS_STORAGE_BUCKET_NAME', default='')
TWILIO_ACCOUNT_SID = env('TWILIO_ACCOUNT_SID', default='')
TWILIO_AUTH_TOKEN = env('TWILIO_AUTH_TOKEN', default='')
TWILIO_FROM_NUMBER = env('TWILIO_FROM_NUMBER', default='')
SENDGRID_API_KEY = env('SENDGRID_API_KEY', default='')
MAILGUN_API_KEY = env('MAILGUN_API_KEY', default='')
MAILGUN_DOMAIN = env('MAILGUN_DOMAIN', default='')
GOOGLE_ANALYTICS_MEASUREMENT_ID = env('GOOGLE_ANALYTICS_MEASUREMENT_ID', default='')
FACEBOOK_ACCESS_TOKEN = env('FACEBOOK_ACCESS_TOKEN', default='')
TWITTER_API_KEY = env('TWITTER_API_KEY', default='')
TWITTER_API_SECRET = env('TWITTER_API_SECRET', default='')
TWITTER_ACCESS_TOKEN = env('TWITTER_ACCESS_TOKEN', default='')
TWITTER_ACCESS_SECRET = env('TWITTER_ACCESS_SECRET', default='')
INSTAGRAM_ACCESS_TOKEN = env('INSTAGRAM_ACCESS_TOKEN', default='')
SENTRY_DSN = env('SENTRY_DSN', default='')
SENTRY_ENVIRONMENT = env('SENTRY_ENVIRONMENT', default='development')
SENTRY_TRACES_SAMPLE_RATE = env('SENTRY_TRACES_SAMPLE_RATE', default='0.0')
NEW_RELIC_LICENSE_KEY = env('NEW_RELIC_LICENSE_KEY', default='')
GRAFANA_BASE_URL = env('GRAFANA_BASE_URL', default='')