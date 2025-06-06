#!/bin/bash
# Run the React frontend
set -e

cd "$(dirname "$0")/frontend"

# Load environment variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# Use VITE_PORT from .env or default to 3000
FRONTEND_PORT="${VITE_PORT:-3000}"

# Check and handle port
echo "Checking if port $FRONTEND_PORT is in use..."
if lsof -i ":$FRONTEND_PORT" > /dev/null 2>&1; then
  read -p "Port $FRONTEND_PORT is in use. Do you want to kill the process? (y/N) " kill_process
  if [[ "$kill_process" =~ ^[Yy]$ ]]; then
    echo "Killing process on port $FRONTEND_PORT..."
    sudo kill $(lsof -t -i":$FRONTEND_PORT") || true
  else
    echo "Port $FRONTEND_PORT is in use. Please free the port and try again."
    exit 1
  fi
fi

# Start the development server
echo "Starting frontend development server..."
VITE_PORT=$FRONTEND_PORT npm run dev
