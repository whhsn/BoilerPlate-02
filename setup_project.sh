#!/bin/bash
# setup_project.sh: Prepare the full-stack boilerplate for first run
# Usage: bash setup_project.sh
set -e

log() {
  echo -e "[SETUP] $1"
}

error_exit() {
  echo -e "[ERROR] $1" >&2
  exit 1
}

# 0. Check for Miniconda/Conda
if ! command -v conda &> /dev/null; then
  log "Miniconda/Conda not found. Installing Miniconda..."
  MINICONDA=Miniconda3-latest-Linux-x86_64.sh
  wget https://repo.anaconda.com/miniconda/$MINICONDA -O /tmp/$MINICONDA || error_exit "Failed to download Miniconda installer."
  bash /tmp/$MINICONDA -b -p "$HOME/miniconda" || error_exit "Failed to install Miniconda."
  export PATH="$HOME/miniconda/bin:$PATH"
  log "Miniconda installed. Please restart your shell or run: export PATH=\"$HOME/miniconda/bin:$PATH\""
fi

# Ensure 'defaults' channel is explicitly set to avoid deprecation warnings
conda config --add channels defaults || log "[WARN] Could not add 'defaults' channel or it already exists."

# 1. Update conda if needed
if command -v conda &> /dev/null; then
  log "Checking for conda updates..."
  conda update -n base -c defaults conda -y || log "[WARN] Conda update failed or not needed."
fi

if ! conda info &> /dev/null; then
  error_exit "Conda is not initialized. Please restart your shell or run: export PATH=\"$HOME/miniconda/bin:$PATH\""
fi

# Ask user for environment name
DEFAULT_CONDA_ENV=$(basename "$PWD")
read -p "Enter the name for the conda environment to use/create (default: $DEFAULT_CONDA_ENV): " CONDA_ENV
CONDA_ENV=${CONDA_ENV:-$DEFAULT_CONDA_ENV}

# Save the conda environment name to .env
echo "CONDA_ENV_NAME=$CONDA_ENV" > .env

if conda env list | grep -q "^$CONDA_ENV[[:space:]]"; then
  log "Conda environment '$CONDA_ENV' already exists. Using it."
else
  log "Creating conda environment '$CONDA_ENV' with Python 3.11..."
  conda create -y -n "$CONDA_ENV" python=3.11 || error_exit "Failed to create conda environment."
fi

log "Activating conda environment '$CONDA_ENV'..."
# shellcheck disable=SC1091
source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate "$CONDA_ENV" || error_exit "Failed to activate conda environment."

# 1. Backend setup
log "Setting up backend..."
cd "$(dirname "$0")/backend" || error_exit "Failed to enter backend directory."

# Create .env from example if it doesn't exist
if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env || error_exit "Could not copy backend .env.example to .env."
    log "[backend] .env created from .env.example."
  else
    error_exit "Backend .env.example not found!"
  fi
fi

log "Installing backend dependencies..."
pip install -r requirements.txt || error_exit "Failed to install backend dependencies."
log "Running database migrations..."
if [ ! -d migrations ]; then
  log "Initializing migrations directory..."
  flask db init || error_exit "Failed to initialize migrations directory."
fi
flask db migrate -m "Initial migration" || log "Migration step skipped (may already exist)."
flask db upgrade || error_exit "Database migration failed."
cd .. || error_exit "Failed to return to project root."

# 2. Frontend setup
log "Setting up frontend..."
cd "$(dirname "$0")/frontend" || error_exit "Failed to enter frontend directory."

# Create .env from example if it doesn't exist
if [ ! -f .env ]; then
  if [ -f .env.example ]; then
    cp .env.example .env || error_exit "Could not copy frontend .env.example to .env."
    log "[frontend] .env created from .env.example."
  else
    error_exit "Frontend .env.example not found!"
  fi
fi

log "Installing frontend dependencies..."
npm install || error_exit "Failed to install frontend dependencies."
log "Updating frontend dependencies..."
npm update || log "[WARN] npm update failed or not needed."
log "Ensuring latest @types/react-i18next is installed..."
npm install @types/react-i18next@latest --save-dev || log "[WARN] Failed to install latest @types/react-i18next."
cd .. || error_exit "Failed to return to project root."

# 3. Docker images (optional)
log "To build and run with Docker, use: docker-compose up --build"

log "\nSetup complete. You can now run the backend and frontend as described in INSTALLATION.md."
