#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Install project dependencies
pip install --no-cache-dir -r requirements.txt

# Run the build and test commands
set -eux
python main.py linearize --repo-path=$(pwd) --source-branch=main --new-branch-name=automated/linear_main \
  --start-commit-ref="$(git rev-parse --verify post-chrobalt-tag)" --end-commit-ref="$(git rev-parse --verify origin/main)"

# Run tests and ensure all tests are executed
python -m unittest discover