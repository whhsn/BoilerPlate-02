# Backend Architecture Overview

## Structure
- **app/**
  - **__init__.py**: App factory, config, extensions
  - **models.py**: SQLAlchemy models (User, Role)
  - **routes/**: Blueprinted route modules (auth, user)
  - **schemas.py**: Marshmallow schemas
  - **config.py**: Centralized config loading (env, .env, etc.)
  - **security.py**: Auth, password hashing, role checks
  - **utils.py**: Logging, error handling
  - **migrations/**: Alembic migrations
- **tests/**: pytest test modules
- **run.py**: Entrypoint
- **requirements.txt**: Dependencies
- **.env.example**: Example config

## Key Features
- **App Factory**: For extensibility and testing
- **Config Abstraction**: All params from env or .env
- **ORM**: SQLAlchemy + Flask-Migrate
- **Role-based Auth**: Flask-Login, roles, secure cookies
- **Security**: CSRF, CORS, Talisman, rate limiting
- **Testing**: pytest, coverage, bash scripts

## Extensibility
- Add new models in `models.py`
- Add new blueprints in `routes/`
- Add new config in `config.py`
