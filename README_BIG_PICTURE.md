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
