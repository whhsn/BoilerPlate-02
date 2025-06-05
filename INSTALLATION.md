# Installation & Setup Guide

This document provides step-by-step instructions to install, configure, and run the full-stack boilerplate project (Flask + React + Docker).

---

## 🚀 Recommended: Automated Setup with `setup_project.sh`

The easiest and most reliable way to set up this project is to use the provided `setup_project.sh` script. This script is designed to automate the entire setup process for both backend and frontend, ensuring all dependencies, environments, and configurations are handled for you.

### What the Script Does
- **Checks for Miniconda/Conda** and installs it if missing
- **Creates or activates a conda environment** (you can specify the name or use the default)
- **Sets up the backend**: creates a Python virtual environment, installs dependencies, copies `.env.example` to `.env` if needed, and runs database migrations
- **Sets up the frontend**: installs and updates npm dependencies, ensures latest type definitions
- **Logs progress and errors** for each step, making troubleshooting easier
- **Provides a message for Docker usage** if you want to use containers

### How to Use
From the project root, simply run:
```bash
bash setup_project.sh
```
Follow the prompts in your terminal. Once complete, your backend and frontend will be ready to run.

---

## Prerequisites
- Docker & Docker Compose
- Node.js (for local frontend dev)
- Python 3.10+ (for local backend dev)

## Quick Start (Docker)
1. Clone the repository and `cd` into the project root.
2. Copy backend environment variables:
   ```bash
   cp backend/.env.example backend/.env
   ```
3. Build and start all services:
   ```bash
   docker-compose up --build
   ```
4. Access the frontend at http://localhost:3000 and backend API at http://localhost:5000

## Local Development (without Docker)
### Backend
1. `cd backend`
2. Create a virtual environment and activate it:
   ```bash
   python3 -m venv venv
   source venv/bin/activate
   ```
3. Install dependencies:
   ```bash
   pip install -r requirements.txt
   ```
4. Copy `.env.example` to `.env` and configure as needed.
5. Run migrations and start the server:
   ```bash
   flask db upgrade
   flask run
   ```

### Frontend
1. `cd frontend`
2. Install dependencies:
   ```bash
   npm install
   ```
3. Start the dev server:
   ```bash
   npm run dev
   ```

---

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

---

**Note:** If you use `setup_project.sh`, you do not need to follow the manual steps above unless you want to customize or troubleshoot the setup process. The script is structured to automate all the steps required for a working development environment.
