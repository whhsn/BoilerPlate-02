# BoilerPlate-02

## Project Overview

BoilerPlate-02 is a production-ready, scalable, and secure full-stack boilerplate for rapid development of modern web applications. It features a Flask backend, React frontend, Docker support, and robust testing and security best practices. The project is designed for extensibility, maintainability, and ease of use.

### Technology Stack
- **Backend:** Flask (Python), SQLAlchemy ORM, Flask-Migrate, Flask-WTF, Flask-Talisman, Flask-Login, Flask-CORS, Flask-Limiter, pytest
- **Frontend:** React (TypeScript), Vite, Tailwind CSS, Shadcn UI, Vitest, ESLint, i18n (RTL/Arabic support)
- **Database:** SQLite (default), PostgreSQL, MySQL (via config)
- **Dockerized:** Separate containers for backend, frontend, and database

## What Has Been Done
- All previous git history has been reset. The current state is a clean slate with a single initial commit containing the final working version of the project.
- The backend and frontend are fully set up with environment management, dependency installation, and ready-to-run scripts.
- Docker support is included for easy deployment and local development.
- Comprehensive documentation is provided for installation, architecture, and testing.
- Security best practices are implemented (CSRF, CORS, secure headers, rate limiting, HSTS, role-based access, etc.).
- Testing infrastructure is in place for both backend (pytest) and frontend (Vitest).
- Internationalization (i18n) and RTL support are enabled in the frontend.

## Usage of Shell Scripts

### setup_project.sh
Prepares the full-stack project for first use. It:
- Installs Miniconda if not present (downloads and sets up automatically)
- Creates or activates a conda environment (user prompted for name, default is project directory)
- Sets up the backend:
  - Creates Python venv
  - Installs backend dependencies from requirements.txt
  - Copies .env.example to .env if needed
  - Runs database migrations (initializes if not present)
- Sets up the frontend:
  - Installs and updates npm dependencies
  - Ensures latest type definitions for i18n
- Provides a message for Docker usage
- Handles errors and logs progress for each step

**Usage:**
```bash
bash setup_project.sh
```

### run_backend.sh
Runs the Flask backend with all necessary pre-run steps. It:
- Prompts for the conda environment to activate (defaults to backend directory name)
- Activates the conda environment (if conda is available)
- Activates the Python virtual environment (venv)
- Sets Flask app environment variables (FLASK_APP, FLASK_ENV)
- Loads .env variables if present (for secrets/config)
- Runs the Flask development server on 0.0.0.0:5000 (accessible from host)
- Useful for local development and debugging

**Usage:**
```bash
bash run_backend.sh
```

### run_frontend.sh
Runs the React frontend. It:
- Changes to the frontend directory
- Loads .env variables if present (for frontend config)
- Starts the Vite development server (hot reload, runs on http://localhost:3000)
- Useful for local frontend development

**Usage:**
```bash
bash run_frontend.sh
```

## Directory Structure
- `backend/` — Flask backend application, API, models, migrations, and tests
- `frontend/` — React frontend application, components, pages, context, and tests
- `docker-compose.yml` — Multi-container orchestration for backend, frontend, and database
- `setup_project.sh` — One-step setup for both backend and frontend
- `run_backend.sh` — Launches backend server with environment setup
- `run_frontend.sh` — Launches frontend dev server
- `INSTALLATION.md` — Step-by-step installation and setup guide
- `README_BIG_PICTURE.md` — High-level project overview and architecture

## Documentation
- See `INSTALLATION.md` for setup instructions (Docker and local dev)
- See `backend/README_ARCH.md` and `frontend/README_ARCH.md` for architecture details
- See `backend/README_TESTING.md` and `frontend/README_TESTING.md` for testing instructions
- See `README_BIG_PICTURE.md` for a high-level overview

## Quick Start
- To set up the project: `bash setup_project.sh`
- To run the backend: `bash run_backend.sh`
- To run the frontend: `bash run_frontend.sh`
- To use Docker: `docker-compose up --build`

## Database Structure

The backend uses SQLAlchemy ORM for database modeling and migrations. By default, the project uses SQLite (the database file is located at `backend/instance/boilerplate.db`), but you can configure PostgreSQL or MySQL by updating the backend configuration.

### How the Database is Managed
- **Models:** Defined in `backend/app/models.py`.
- **Migrations:** Managed with Flask-Migrate (Alembic). Migration scripts are in `backend/migrations/versions/`.
- **Initialization:** The setup and backend run scripts automatically create the database and apply migrations.

### Existing Tables (Initial State)
Based on the initial migration and typical boilerplate structure, the following tables are present:
- **user**: Stores user accounts for authentication and management (fields typically include id, username, email, password_hash, roles, etc.).
- **role**: (If using role-based access) Stores user roles and permissions.
- **alembic_version**: Tracks the current database migration version (used by Alembic/Flask-Migrate).

Additional tables may exist depending on your app’s features (e.g., tokens, logs, or domain-specific data). You can view and modify the schema in `backend/app/models.py` and generate new migrations as needed.

**Note:**
- The database is automatically created and migrated when you run `setup_project.sh` or `run_backend.sh`.
- You can inspect the schema by looking at the migration scripts or the models file.

---

For more details, see the documentation files in this repository. Contributions and suggestions are welcome!

## Testing Strategy and Plan

This project is committed to maintaining high code quality and reliability through comprehensive automated testing for both the backend and frontend. Below is the plan for implementing and maintaining tests in both parts of the stack.

### Backend Testing (Flask/Python)
- **Framework:** pytest is used for all backend tests.
- **Test Location:** All backend tests are located in `backend/tests/`.
- **Test Types:**
  - **Unit Tests:** For individual functions, models, and utilities.
  - **Integration Tests:** For API endpoints, database interactions, and authentication flows.
- **Fixtures:** Common test data and setup/teardown logic are managed using pytest fixtures (see `conftest.py`).
- **Running Tests:**
  - Use `bash backend/run_all_tests.sh` to run the full test suite.
  - Use `bash backend/run_test.sh <test_file>` to run a specific test file.
- **Coverage:** Aim for 80%+ code coverage. Add tests for new features and bug fixes.
- **Continuous Integration:** Integrate with CI tools (e.g., GitHub Actions) to run tests on every pull request.

### Frontend Testing (React/TypeScript)
- **Framework:** Vitest is used for all frontend tests.
- **Test Location:** All frontend tests are located in `frontend/src/**/__tests__/`.
- **Test Types:**
  - **Unit Tests:** For components, hooks, and utility functions.
  - **Integration Tests:** For page flows, context providers, and API interactions.
- **Mocking:** Use Vitest and React Testing Library to mock API calls, context, and user interactions.
- **Running Tests:**
  - Use `npm run test` in the `frontend/` directory to run all tests.
  - Use `npm run test -- <pattern>` to run specific tests.
- **Coverage:** Aim for 80%+ code coverage. Add tests for new UI features and bug fixes.
- **Continuous Integration:** Integrate with CI tools to ensure tests run on every pull request.

### General Testing Guidelines
- Write tests for every new feature and bug fix.
- Keep tests isolated, repeatable, and fast.
- Use descriptive test names and clear assertions.
- Review and update tests as code evolves.

For more details, see `backend/README_TESTING.md` and `frontend/README_TESTING.md`.