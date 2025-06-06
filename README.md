# BoilerPlate-02

A production-ready, scalable, and secure full-stack web application boilerplate.

## Documentation Quick Links

📚 **Getting Started**
- [Installation Guide](INSTALLATION.md) - Complete setup instructions
- [Usage Guide](USAGE_GUIDE.md) - How to use this boilerplate
- [Docker Setup](DOCKER_SETUP.md) - Container-based deployment

🏗 **Architecture**
- [Big Picture Overview](README_BIG_PICTURE.md) - System-wide architecture
- [Backend Architecture](backend/README_ARCH.md) - Flask backend details
- [Frontend Architecture](frontend/README_ARCH.md) - React frontend details

🧪 **Testing**
- [Backend Testing](backend/README_TESTING.md)
- [Frontend Testing](frontend/README_TESTING.md)

## Technology Stack

### Backend (Python/Flask)
- Flask with SQLAlchemy ORM
- Authentication & Authorization
- Rate Limiting & Security Features
- API Documentation
- Extensive Testing Suite

### Frontend (React/TypeScript)
- Modern React with TypeScript
- Vite for Development
- Tailwind CSS & Shadcn UI
- i18n/RTL Support
- Component Testing

### Infrastructure
- Docker & Docker Compose
- Database Options:
  - SQLite (Development)
  - PostgreSQL (Production)
  - MySQL (Alternative)
- Redis for Rate Limiting
- Comprehensive Security

## Key Features

### Security
- CSRF Protection
- CORS Configuration
- Secure Headers (HSTS, etc.)
- Rate Limiting
- Session Security
- SQL Injection Prevention

### Development
- Hot Reloading
- Type Safety
- Error Handling
- Logging System
- Testing Infrastructure

### Production Ready
- Environment Management
- Configuration System
- Docker Support
- Database Migrations
- Performance Optimizations

## Quick Start

1. Clone the repository:
   ```bash
   git clone [repository-url] my-project
   cd my-project
   ```

2. Run the setup script:
   ```bash
   bash setup_project.sh
   ```

3. Start the servers:
   ```bash
   # Terminal 1
   bash run_backend.sh

   # Terminal 2
   bash run_frontend.sh
   ```

For detailed setup instructions, see [INSTALLATION.md](INSTALLATION.md).

## Project Structure

```
├── backend/               # Flask backend
│   ├── app/              # Application code
│   ├── tests/            # Test suite
│   └── requirements.txt  # Python dependencies
│
├── frontend/             # React frontend
│   ├── src/             # Source code
│   ├── public/          # Static files
│   └── package.json     # Node.js dependencies
│
├── setup_project.sh     # Project setup script
├── run_backend.sh       # Backend startup script
└── run_frontend.sh      # Frontend startup script
```

## Further Documentation

See individual documentation files for detailed information:
- [Storage Configuration](INSTALLATION.md#storage-configuration-guide)
- [Security Setup](INSTALLATION.md#security-configuration)
- [Development Workflow](USAGE_GUIDE.md#development-workflow)
- [Production Deployment](DOCKER_SETUP.md#production-deployment)

## License

[MIT License](LICENSE)