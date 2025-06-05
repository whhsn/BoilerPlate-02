# Docker Setup Guide for BoilerPlate-02

This guide explains how to use Docker and Docker Compose to run the full-stack BoilerPlate-02 project in isolated containers for both development and production.

---

## Prerequisites
- [Docker](https://docs.docker.com/get-docker/) (v20+ recommended)
- [Docker Compose](https://docs.docker.com/compose/) (v2+ recommended)

---

## 1. Project Structure
The repository includes:
- `docker-compose.yml` — Orchestrates backend, frontend, and database containers
- `backend/Dockerfile` — Builds the Flask backend image
- `frontend/Dockerfile` — Builds the React frontend image

---

## 2. Environment Variables
- Copy and configure environment files:
  ```bash
  cp backend/.env.example backend/.env
  # Edit backend/.env as needed
  # (Frontend .env is optional and not required for most setups)
  ```
- To make port settings dynamic, create a `.env` file at the project root (not just in backend/ or frontend/) and add:
  ```env
  BACKEND_PORT=5000
  FRONTEND_PORT=3000
  DB_PORT=5432
  ```
- The `docker-compose.yml` now uses `${BACKEND_PORT}`, `${FRONTEND_PORT}`, and `${DB_PORT}` for port mappings. You can change the exposed ports by editing the root `.env` file (see below for details).

---

## 3. Build and Start All Services
From the project root, run:
```bash
docker-compose up --build
```
- This will build images (if needed) and start all containers.
- The first build may take several minutes.

---

## 4. Accessing the App
- **Frontend:** http://localhost:3000
- **Backend API:** http://localhost:5000
- **Database:**
  - By default, SQLite is used (file-based, inside the backend container).
  - **To use PostgreSQL or MySQL:**
    1. Uncomment and configure the `db` service in `docker-compose.yml` (choose either the PostgreSQL or MySQL example, and set the environment variables as needed).
    2. Update `backend/.env`:
       - For PostgreSQL (Docker):
         ```env
         SQLALCHEMY_DATABASE_URI=postgresql://postgres:postgres@db:5432/postgres
         ```
       - For MySQL (Docker):
         ```env
         SQLALCHEMY_DATABASE_URI=mysql+pymysql://user:password@db:3306/dbname
         ```
    3. Rebuild and start the containers:
       ```bash
       docker-compose down -v
       docker-compose up --build
       ```
    4. The backend will now use the external database container.
  - **To use a non-Docker (local or remote) database:**
    1. Set up your PostgreSQL or MySQL server locally or use a managed/cloud instance.
    2. Update `backend/.env` with the correct connection string, e.g.:
       - For local PostgreSQL:
         ```env
         SQLALCHEMY_DATABASE_URI=postgresql://username:password@localhost:5432/dbname
         ```
       - For remote PostgreSQL:
         ```env
         SQLALCHEMY_DATABASE_URI=postgresql://username:password@remotehost:5432/dbname
         ```
       - For local MySQL:
         ```env
         SQLALCHEMY_DATABASE_URI=mysql+pymysql://user:password@localhost:3306/dbname
         ```
       - For remote MySQL:
         ```env
         SQLALCHEMY_DATABASE_URI=mysql+pymysql://user:password@remotehost:3306/dbname
         ```
    3. Run the backend as usual (with or without Docker). The backend will connect to the specified database server.

---

## 5. Common Docker Commands
- **Stop all containers:**
  ```bash
  docker-compose down
  ```
- **Rebuild after code changes:**
  ```bash
  docker-compose up --build
  ```
- **View logs:**
  ```bash
  docker-compose logs -f
  ```
- **Run a command in a container:**
  ```bash
  docker-compose exec backend bash
  docker-compose exec frontend bash
  ```

---

## 6. Customization
- **Change exposed ports dynamically:**
  1. Add `BACKEND_PORT`, `FRONTEND_PORT`, and `DB_PORT` to your root `.env` file.
  2. In `docker-compose.yml`, port mappings are set like:
     ```yaml
     ports:
       - "${BACKEND_PORT:-5000}:5000"
     # ...
     ports:
       - "${FRONTEND_PORT:-3000}:3000"
     # ...
     ports:
       - "${DB_PORT:-5432}:5432"
     ```
  3. Now, changing the port in the root `.env` will update the exposed port for each service.
- **Switch database:** Uncomment and configure the `db` service in `docker-compose.yml` and update backend `.env` accordingly.
- **Add environment variables:** Pass them via `.env` files or directly in `docker-compose.yml`.

---

## 7. Production Deployment
- For production, build images with `--build` and use environment variables for secrets.
- Consider using a production-ready database (PostgreSQL/MySQL) and persistent storage.
- Use a reverse proxy (e.g., Nginx, Traefik) for SSL and domain routing.

---

## 8. Troubleshooting
- If you see port conflicts, change the host ports in `docker-compose.yml`.
- For permission issues with volumes, check Docker's user mapping or run with `sudo`.
- To clean up all containers and images:
  ```bash
  docker-compose down -v
  docker system prune -af
  ```

---

## References
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

For more details, see the comments in `docker-compose.yml` and the Dockerfiles in `backend/` and `frontend/`.
