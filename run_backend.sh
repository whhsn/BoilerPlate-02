#!/bin/bash
# Run the Flask backend with all necessary pre-run steps
set -e

cd "$(dirname "$0")/backend"

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Use PORT from .env or default to 5000
BACKEND_PORT="${PORT:-5000}"

# Check and handle port
echo "Checking if port $BACKEND_PORT is in use..."
if lsof -i ":$BACKEND_PORT" > /dev/null 2>&1; then
  read -p "Port $BACKEND_PORT is in use. Do you want to kill the process? (y/N) " kill_process
  if [[ "$kill_process" =~ ^[Yy]$ ]]; then
    echo "Killing process on port $BACKEND_PORT..."
    sudo kill $(lsof -t -i":$BACKEND_PORT") || true
  else
    echo "Port $BACKEND_PORT is in use. Please free the port and try again."
    exit 1
  fi
fi

# Load environment name from .env if it exists, otherwise use project directory name
if [ -f ../.env ] && grep -q "^CONDA_ENV_NAME=" ../.env; then
    source ../.env
    echo "[INFO] Using conda environment from .env: $CONDA_ENV_NAME"
else
    # Get the project directory name directly from the script location
    CONDA_ENV_NAME=$(basename "$(cd "$(dirname "$0")" && pwd)")
    echo "[INFO] No CONDA_ENV_NAME in .env, using project directory name: $CONDA_ENV_NAME"
fi

# Check if conda is available
if ! command -v conda &> /dev/null; then
    echo "Error: conda is not installed or not in PATH"
    exit 1
fi

# Source conda.sh to ensure conda commands work in script
source "$(conda info --base)/etc/profile.d/conda.sh"

# Check if project conda environment exists
if conda env list | grep -q "^$CONDA_ENV_NAME[[:space:]]"; then
    echo "[DEBUG] Found existing environment: $CONDA_ENV_NAME"
    echo "Activating existing conda environment: $CONDA_ENV_NAME"
    conda activate "$CONDA_ENV_NAME"
    echo "[DEBUG] After activation - CONDA_DEFAULT_ENV: $CONDA_DEFAULT_ENV"
    echo "[DEBUG] Python path: $(which python)"
    echo "[DEBUG] Flask path: $(which flask 2>/dev/null || echo 'flask not found')"
  else
    echo "Error: Conda environment '$CONDA_ENV_NAME' not found!"
    echo "Please run 'bash setup_project.sh' first to set up the project environment."
    exit 1
  fi

# Set Flask app entrypoint
export FLASK_APP=run.py
export FLASK_ENV=development

# Optionally load .env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

echo "[DEBUG] Final environment check:"
echo "CONDA_DEFAULT_ENV: $CONDA_DEFAULT_ENV"
echo "Python path: $(which python)"
echo "Flask path: $(which flask 2>/dev/null || echo 'flask not found')"

# Run Flask
flask run --host=0.0.0.0 --port="$BACKEND_PORT"
