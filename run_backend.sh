#!/bin/bash
# Run the Flask backend with all necessary pre-run steps
set -e
cd "$(dirname "$0")/backend"
# Prompt for conda environment name (default: backend directory name)
DEFAULT_CONDA_ENV=$(basename "$PWD")
read -p "Enter the name of the conda environment to activate (default: $DEFAULT_CONDA_ENV): " CONDA_ENV
CONDA_ENV=${CONDA_ENV:-$DEFAULT_CONDA_ENV}
# Activate conda environment
if command -v conda &> /dev/null; then
  source "$(conda info --base)/etc/profile.d/conda.sh"
  conda activate "$CONDA_ENV"
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
flask run --host=0.0.0.0 --port=5000
