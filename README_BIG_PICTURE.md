# Boilerplate Project: Big Picture Overview

## Purpose
This project is a production-ready, scalable, and secure full-stack boilerplate for rapid development of modern web applications. It is designed for extensibility, maintainability, and best practices in security, testing, and architecture.

## Stack
- **Backend:** Flask (Python), SQLAlchemy ORM, Flask-Migrate, Flask-WTF, Flask-Talisman, Flask-Login, Flask-CORS, Flask-Limiter, pytest
- **Frontend:** React (TypeScript), Vite, Tailwind CSS, Shadcn UI, Vitest, ESLint, i18n (RTL/Arabic support)
- **Database:** SQLite (default), PostgreSQL, MySQL (via config)
- **Dockerized:** Separate containers for backend, frontend, and database

## Key Features
- Centralized configuration and environment management
- Secure authentication with role-based access
- CSRF, CORS, secure headers, rate limiting, HSTS
- Modern, responsive, RTL-ready UI
- Type-safe API client and global auth context
- 80%+ test coverage enforced (pytest, Vitest)
- Clean, atomic design and modular codebase

## Extensibility
- Add new backend models/routes in `backend/app/`
- Add new frontend pages/components in `frontend/src/`
- Add new languages in `frontend/src/i18n.ts`

## Documentation
- See `INSTALLATION.md` for setup
- See `backend/README_ARCH.md` and `frontend/README_ARCH.md` for architecture
- See `backend/README_TESTING.md` and `frontend/README_TESTING.md` for testing

# Project Structure and File Documentation

## Directory Structure

```
├── backend/                  # Flask backend application
│   ├── app/                 # Application code
│   │   ├── __init__.py     # App initialization and factory
│   │   ├── config.py       # Configuration management
│   │   ├── models.py       # Database models
│   │   ├── schemas.py      # API schemas/serializers
│   │   ├── security.py     # Security utilities
│   │   ├── utils.py        # Helper functions
│   │   └── routes/         # API endpoints
│   │       └── auth.py     # Authentication routes
│   ├── instance/           # Instance-specific files
│   │   └── boilerplate.db  # SQLite database (development)
│   ├── logs/               # Application logs
│   │   └── app.log        # Main log file
│   ├── migrations/         # Database migrations
│   ├── tests/             # Test suite
│   │   ├── conftest.py    # Test configurations
│   │   └── test_auth.py   # Auth tests
│   ├── Dockerfile         # Backend container definition
│   ├── requirements.txt   # Python dependencies
│   ├── run.py            # Application entry point
│   └── run_test.sh       # Test runner script
│
├── frontend/               # React frontend application
│   ├── src/              # Source code
│   │   ├── components/   # Reusable components
│   │   │   └── ProtectedRoute.tsx  # Auth wrapper
│   │   ├── context/     # React contexts
│   │   │   └── AuthContext.tsx    # Auth state management
│   │   ├── lib/        # Utilities
│   │   │   └── api.ts  # API client
│   │   ├── pages/      # Application pages
│   │   │   ├── DashboardPage.tsx  # Main dashboard
│   │   │   └── LoginPage.tsx      # Authentication
│   │   ├── types/      # TypeScript definitions
│   │   ├── App.tsx     # Root component
│   │   └── i18n.ts     # Internationalization setup
│   ├── Dockerfile      # Frontend container definition
│   ├── package.json    # Node.js dependencies
│   └── vite.config.ts  # Vite configuration
│
├── setup_project.sh        # Project setup automation
├── run_backend.sh         # Backend startup script
├── run_frontend.sh        # Frontend startup script
├── docker-compose.yml     # Container orchestration
└── documentation/         # Project documentation
    ├── INSTALLATION.md    # Setup instructions
    ├── USAGE_GUIDE.md     # Usage documentation
    ├── DOCKER_SETUP.md    # Docker instructions
    └── README_BIG_PICTURE.md  # Architecture overview
```

## Key Files Description

### Root Level
- `setup_project.sh`: Automated project setup script that handles environment creation, dependency installation, and initial configuration
- `run_backend.sh`: Script to start the Flask backend with proper environment activation
- `run_frontend.sh`: Script to start the React frontend development server
- `docker-compose.yml`: Docker services definition for development and production

### Backend (/backend)
- `app/__init__.py`: Application factory pattern implementation, extension initialization
- `app/config.py`: Configuration classes and environment variable management
- `app/models.py`: SQLAlchemy database models
- `app/schemas.py`: Marshmallow schemas for API serialization
- `app/security.py`: Security utilities (password hashing, token management)
- `app/routes/auth.py`: Authentication endpoints (login, register, etc.)
- `run.py`: WSGI entry point
- `requirements.txt`: Python package dependencies

### Frontend (/frontend)
- `src/App.tsx`: Main application component with routing setup
- `src/i18n.ts`: Internationalization configuration (supports RTL)
- `src/components/`: Reusable UI components
- `src/context/AuthContext.tsx`: Global authentication state management
- `src/lib/api.ts`: Axios-based API client with interceptors
- `src/pages/`: Application views/pages
- `package.json`: Node.js dependencies and scripts
- `vite.config.ts`: Build and development server configuration

### Documentation
- `INSTALLATION.md`: Complete setup guide
- `USAGE_GUIDE.md`: Development workflow and usage instructions
- `DOCKER_SETUP.md`: Container-based deployment guide
- `README_BIG_PICTURE.md`: High-level architecture and design decisions

### Configuration Files
- `backend/.env`: Backend environment configuration
  - Database connections
  - Security settings
  - Rate limiting configuration
  - API keys and secrets
- `frontend/.env`: Frontend environment configuration
  - API endpoints
  - Build settings
  - Feature flags

### Testing
- `backend/tests/`: Backend test suite using pytest
- `frontend/src/**/__tests__/`: Frontend tests using Vitest
- `backend/run_test.sh`: Backend test runner with coverage
- `frontend/vitest.config.ts`: Frontend test configuration
