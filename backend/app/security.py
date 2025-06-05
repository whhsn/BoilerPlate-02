from flask_wtf.csrf import CSRFProtect
from flask_talisman import Talisman
from flask_limiter import Limiter
from flask_limiter.util import get_remote_address
from flask_cors import CORS

# This module is for initializing and configuring security-related extensions.
# Used in app/__init__.py for centralized security setup.
