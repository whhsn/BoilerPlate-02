# Shell Scripts Documentation

This document provides comprehensive documentation for all shell scripts in the project.

## Project Root Scripts

### setup_project.sh
**Purpose**: Automated project setup and initialization

**Usage**:
```bash
bash setup_project.sh
```

**What it does**:
1. Checks/Installs Miniconda if not present
2. Creates/activates a conda environment
3. Sets up backend:
   - Creates `.env` from `.env.example`
   - Installs Python dependencies
   - Initializes database and runs migrations
4. Sets up frontend:
   - Creates `.env` from `.env.example`
   - Installs Node.js dependencies
   - Updates critical packages

**Environment Variables**:
- `CONDA_ENV_NAME`: Name of the conda environment (saved to `.env`)
- Backend environment variables from `backend/.env.example`
- Frontend environment variables from `frontend/.env.example`

### run_backend.sh
**Purpose**: Start the Flask backend server

**Usage**:
```bash
bash run_backend.sh
```

**What it does**:
1. Checks if required port is available (default: 5000)
2. Activates the correct conda environment
3. Sets up Flask environment variables
4. Starts the Flask development server

**Environment Variables**:
- `BACKEND_PORT` or `PORT`: Port to run the server on (default: 5000)
- `FLASK_APP`: Points to `run.py`
- `FLASK_ENV`: Set to development
- Environment variables from `backend/.env`

### run_frontend.sh
**Purpose**: Start the React frontend development server

**Usage**:
```bash
bash run_frontend.sh
```

**What it does**:
1. Checks if required port is available (default: 3000)
2. Activates conda environment if needed
3. Starts the Vite development server

**Environment Variables**:
- `FRONTEND_PORT` or `VITE_PORT`: Port to run the server on (default: 3000)
- Environment variables from `frontend/.env`

### new_project.sh
**Purpose**: Create a new project from the boilerplate

**Usage**:
```bash
bash new_project.sh <new_project_name>
```

**What it does**:
1. Clones the boilerplate into a new directory
2. Removes git history and reinitializes git
3. Runs `setup_project.sh`
4. Sets up initial commit

**Arguments**:
- `new_project_name`: Name for the new project directory

## Backend Scripts

### backend/run_test.sh
**Purpose**: Run tests for a specific module with coverage reporting

**Usage**:
```bash
cd backend
bash run_test.sh <test_module_path>
```

**Example**:
```bash
bash run_test.sh tests/test_auth.py
```

**What it does**:
1. Runs pytest for the specified module
2. Generates coverage report for that module

### backend/run_all_tests.sh
**Purpose**: Run the complete test suite with coverage reporting

**Usage**:
```bash
cd backend
bash run_all_tests.sh
```

**What it does**:
1. Runs all tests in the `tests/` directory
2. Generates comprehensive coverage report
3. Displays test results and coverage statistics

## Common Script Features

### Port Management
All server scripts (`run_backend.sh`, `run_frontend.sh`) include:
- Port availability checking
- Option to kill existing processes on ports
- Configurable port numbers via environment variables

### Environment Handling
All scripts feature:
- Conda environment management
- Environment variable loading from `.env` files
- Error handling and user feedback
- Debug logging for troubleshooting

### Error Handling
Scripts implement:
- Input validation
- Clear error messages
- Non-zero exit codes on failure
- Debug information when needed

## Troubleshooting

### Common Issues

1. **Port Already in Use**
```bash
# Check port usage
lsof -i :5000  # For backend
lsof -i :3000  # For frontend

# Kill process if needed
sudo kill $(lsof -t -i:5000)
```

2. **Conda Environment Issues**
```bash
# List environments
conda env list

# Manually activate environment
conda activate <env_name>
```

3. **Permission Issues**
```bash
# Make scripts executable
chmod +x setup_project.sh run_backend.sh run_frontend.sh
```

### Debug Mode
For detailed logging, run scripts with bash debug mode:
```bash
bash -x script_name.sh
```

## Best Practices

1. **Running Scripts**:
   - Always run from project root unless specified otherwise
   - Use bash explicitly (`bash script.sh` instead of `./script.sh`)
   - Check script output for errors

2. **Environment Files**:
   - Always copy from `.env.example` files first
   - Review settings before running scripts
   - Keep sensitive information in `.env` files

3. **Development Workflow**:
   - Run `setup_project.sh` once at project start
   - Use `run_backend.sh` and `run_frontend.sh` for daily development
   - Run tests frequently with `run_test.sh` or `run_all_tests.sh`
