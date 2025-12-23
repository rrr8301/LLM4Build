# run.sh
#!/bin/bash

set -e

# Activate virtual environment if needed
# source venv/bin/activate

# Run tests
set +e  # Allow script to continue even if some tests fail
pytest -v --cov=docker tests/unit