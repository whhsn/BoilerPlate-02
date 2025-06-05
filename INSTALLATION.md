# Installation & Setup Guide

This document provides step-by-step instructions to install, configure, and run the full-stack boilerplate project (Flask + React + Docker).

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

For more details, see the documentation in each folder.
