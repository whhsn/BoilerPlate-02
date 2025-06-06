# Installation & Setup Guide

This guide provides comprehensive instructions for setting up the full-stack boilerplate project.

## Table of Contents
1. [Quick Start](#quick-start)
2. [Prerequisites](#prerequisites)
3. [Automated Setup](#automated-setup)
4. [Manual Setup](#manual-setup)
5. [Storage Configuration](#storage-configuration)
6. [Security Configuration](#security-configuration)
7. [Troubleshooting](#troubleshooting)

## Quick Start

```bash
git clone [repository-url] my-project
cd my-project
bash setup_project.sh
```

## Prerequisites

- Git
- Python 3.10+
- Node.js 18+
- Docker & Docker Compose (optional)

## Automated Setup

The `setup_project.sh` script automates the entire setup process. It:
1. Installs/checks Miniconda
2. Creates/activates conda environment
3. Sets up backend & frontend
4. Configures environment files
5. Initializes database

## Storage Configuration

### Database Options

Configure your database in `backend/.env`:

#### 1. SQLite (Development)
```properties
DATABASE_URL=sqlite:///boilerplate.db
```
- Local file-based database
- No setup required
- Perfect for development
- Not suitable for production

#### 2. PostgreSQL

a) Local Development
```properties
DATABASE_URL=postgresql://localhost:5432/boilerplate
```
- Local instance
- No auth for quick setup
- Direct connection

b) Docker Setup
```properties
DATABASE_URL=postgresql://boileruser:boilerpass@db:5432/boilerdb
```
- Containerized database
- Basic authentication
- Docker networking

c) Production
```properties
DATABASE_URL=postgresql://user:password@postgres.example.com:5432/dbname
```
- Full hostname
- Secure credentials
- Production ready

d) Advanced Configuration
```properties
DATABASE_URL=postgresql+psycopg2://user:pass@host:5432/db?max_connections=20
```
- Connection pooling
- Performance tuning
- High availability

#### 3. MySQL

Similar options available, see comments in `.env.example` for full configuration.

### Rate Limiting Storage

Configure in `backend/.env`:

#### 1. Memory Storage (Development)
```properties
RATELIMIT_STORAGE_URI=memory://
```
- In-memory storage
- No persistence
- Development only

#### 2. Redis Storage

a) Local Development
```properties
RATELIMIT_STORAGE_URI=redis://localhost:6379/0
```
- Local Redis
- No authentication

b) Docker Setup
```properties
RATELIMIT_STORAGE_URI=redis://redis:6379/0
```
- Containerized Redis
- Docker networking

c) Production
```properties
RATELIMIT_STORAGE_URI=redis://:password@redis.example.com:6379/0
```
- Secure authentication
- Production ready

d) Clustered Setup
```properties
RATELIMIT_STORAGE_URI=redis+cluster://localhost:7000,localhost:7001,localhost:7002/0
```
- High availability
- Horizontal scaling
- Automatic failover

## Security Configuration

Security settings in `backend/.env`:

```properties
# Cookie Security
SESSION_COOKIE_SECURE=True
REMEMBER_COOKIE_SECURE=True

# CORS Configuration
CORS_ORIGINS=http://localhost:3000

# API Security
SECRET_KEY=your-secret-key-here
```

## Environment-Specific Recommendations

### Development
- Use SQLite database
- Use memory rate limiting
- Local development URLs
- Debug mode enabled

### Testing
- Use SQLite database
- Use memory rate limiting
- Test-specific database
- Test configurations

### Production
- Use PostgreSQL with connection pooling
- Use Redis Cluster for rate limiting
- SSL/TLS everywhere
- Secure credentials
- Health monitoring

## Troubleshooting

### Common Issues

1. Database Connection
```bash
# Test PostgreSQL connection
psql postgresql://localhost:5432/boilerplate

# Test MySQL connection
mysql -u root -p boilerplate
```

2. Redis Connection
```bash
# Test Redis connection
redis-cli ping
```

3. Port Conflicts
```bash
# Check ports
lsof -i :5000  # Backend
lsof -i :3000  # Frontend
```

For more details, see:
- [Backend Architecture](backend/README_ARCH.md)
- [Database Schema](backend/README_ARCH.md#database-schema)
- [API Documentation](backend/README_ARCH.md#api-endpoints)
