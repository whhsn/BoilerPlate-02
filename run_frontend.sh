#!/bin/bash
# Run the React frontend
set -e
cd "$(dirname "$0")/frontend"
# Optionally load .env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Prompt for conda environment name (default: project directory name)
PROJECT_ROOT=$(dirname "$0")
DEFAULT_CONDA_ENV=$(basename "$PROJECT_ROOT")
read -p "Enter the name of the conda environment to activate (default: $DEFAULT_CONDA_ENV): " CONDA_ENV
CONDA_ENV=${CONDA_ENV:-$DEFAULT_CONDA_ENV}

npm run dev
