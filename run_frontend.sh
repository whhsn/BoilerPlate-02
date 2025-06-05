#!/bin/bash
# Run the React frontend
set -e
cd "$(dirname "$0")/frontend"
# Optionally load .env variables
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi
npm run dev
