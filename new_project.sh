#!/bin/bash
# new_project.sh: Automate starting a new project from BoilerPlate-02
# Usage: bash new_project.sh <new_project_name>
set -e

if [ -z "$1" ]; then
  echo "Usage: bash new_project.sh <new_project_name>"
  exit 1
fi

NEW_PROJECT_NAME="$1"
REPO_URL="https://github.com/whhsn/BoilerPlate-02.git"

# 1. Clone the boilerplate
if [ -d "$NEW_PROJECT_NAME" ]; then
  echo "Directory $NEW_PROJECT_NAME already exists. Aborting."
  exit 1
fi

git clone "$REPO_URL" "$NEW_PROJECT_NAME"
cd "$NEW_PROJECT_NAME"

# 2. Remove git history and re-init
rm -rf .git
git init
git add .
git commit -m "Initial commit: Start $NEW_PROJECT_NAME from BoilerPlate-02"

# 3. Run setup script
echo "\nRunning setup_project.sh..."
bash setup_project.sh

echo "\nProject $NEW_PROJECT_NAME is ready!"
echo "- Backend: bash run_backend.sh (http://localhost:5000)"
echo "- Frontend: bash run_frontend.sh (http://localhost:3000)"
echo "\nNext steps:"
echo "- Edit README.md to describe your new project."
echo "- Add your own models, APIs, and frontend pages."
echo "- (Optional) git remote add origin <your-new-repo-url> && git push -u origin main"
