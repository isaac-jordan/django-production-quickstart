from .base import *

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

# Uncomment to test Django Compressor
# COMPRESS_ENABLED = True
COMPRESS_CSS_FILTERS = ['compressor.filters.css_default.CssAbsoluteFilter', 'compressor.filters.cssmin.CSSMinFilter']

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [
            os.path.join(PROJECT_DIR, 'templates'),
        ],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

for template_engine in TEMPLATES:
    template_engine['OPTIONS']['debug'] = True

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = '4dzrov@0j(t#0txa(@hnjoig+1uu^t^xk6)j73$-0j-t7kim&a'

EMAIL_BACKEND = 'django.core.mail.backends.console.EmailBackend'

# Uncomment and provide valid details to test emailing from local dev
# EMAIL_BACKEND = 'django.core.mail.backends.smtp.EmailBackend'
# EMAIL_HOST = ''
# EMAIL_HOST_USER = ''
# EMAIL_HOST_PASSWORD = ''
# EMAIL_PORT = 587
# EMAIL_USE_TLS = True

try:
    # Create a ".local.py" file if you want to override some things locally but not check them into version-control
    from .local import *
except ImportError:
    pass