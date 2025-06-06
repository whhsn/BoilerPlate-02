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

## Rate Limiting

### Storage Backend
The rate limiting system uses a configurable storage backend:

- **Development**: In-memory storage (`memory://`)
  - Simple, no additional services required
  - Counters reset on server restart
  - Not suitable for production or multi-instance deployments

- **Production**: Redis storage
  - Persistent across restarts
  - Works with multiple application instances
  - Supports various Redis configurations:
    - Single instance
    - Redis with authentication
    - Redis Cluster

Configuration is done via `RATELIMIT_STORAGE_URI` in `.env`. See the comments in `.env.example` for all supported Redis configurations.

## Storage Architecture

### Database Layer

The application uses SQLAlchemy ORM with support for multiple database backends:

1. **SQLite**
   - File-based storage
   - Used by default in development
   - SQLAlchemy automatically handles connection pooling
   - Limitations: single writer, no concurrent writes

2. **PostgreSQL**
   - Primary choice for production
   - Features used:
     - Connection pooling via psycopg2
     - SSL/TLS encryption
     - Schema migrations via Alembic
     - Full text search capabilities
   - Configuration options:
     - Basic connection (development)
     - Docker networking
     - Production with authentication
     - Connection pooling parameters

3. **MySQL**
   - Alternative production option
   - Features used:
     - PyMySQL driver for pure Python compatibility
     - SSL/TLS support
     - InnoDB engine for transactions
   - Configuration patterns:
     - Local development setup
     - Docker container connection
     - Production deployment
     - SSL certificate verification

### Rate Limiting Architecture

Rate limiting uses a distributed storage backend to track request counts:

1. **Memory Storage**
   - Simple in-memory counter
   - Process-local storage
   - Limitations:
     - No persistence
     - No sharing between processes
     - Resets on restart

2. **Redis Storage**
   - Distributed rate limiting
   - Features used:
     - Atomic operations
     - TTL for counter expiration
     - Cluster support for scaling
   - Deployment patterns:
     - Single node (development)
     - Authentication enabled (production)
     - Cluster mode (high availability)
   - Benefits:
     - Persistent across restarts
     - Shared between application instances
     - Automatic key expiration
     - High performance

### Implementation Details

1. **Database Connections**
   - Managed by SQLAlchemy connection pool
   - Pool size configured via URL parameters
   - Automatic connection recycling
   - Error handling and retry logic

2. **Redis Rate Limiting**
   - Uses sorted sets for sliding windows
   - Atomic increment operations
   - Automatic cleanup of expired entries
   - Cluster-aware client for sharding

3. **High Availability Considerations**
   - Database failover handling
   - Redis Cluster for rate limiting
   - Connection error recovery
   - Graceful degradation strategies

4. **Security Measures**
   - SSL/TLS encryption for all connections
   - Password authentication
   - Connection string credentials via env vars
   - Regular security updates
