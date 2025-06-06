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

# Prompt for conda environment name (default: project directory name)
PROJECT_ROOT=$(dirname "$0")
DEFAULT_CONDA_ENV=$(basename "$PROJECT_ROOT")

# Check if conda environment exists
if command -v conda &> /dev/null; then
  source "$(conda info --base)/etc/profile.d/conda.sh"
  if conda env list | grep -q "^$DEFAULT_CONDA_ENV[[:space:]]"; then
    echo "Activating existing conda environment: $DEFAULT_CONDA_ENV"
    conda activate "$DEFAULT_CONDA_ENV"
  else
    read -p "Conda environment '$DEFAULT_CONDA_ENV' does not exist. Enter a name to create (default: $DEFAULT_CONDA_ENV): " CONDA_ENV
    CONDA_ENV=${CONDA_ENV:-$DEFAULT_CONDA_ENV}
    echo "Creating and activating conda environment: $CONDA_ENV"
    conda create -y -n "$CONDA_ENV" python=3.11
    conda activate "$CONDA_ENV"
  fi
fi
# Activate Python venv
source venv/bin/activate
# Set Flask app entrypoint
export FLASK_APP=run.py
export FLASK_ENV=development
# Optionally load .env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi
# Run Flask
flask run --host=0.0.0.0 --port="$BACKEND_PORT"
