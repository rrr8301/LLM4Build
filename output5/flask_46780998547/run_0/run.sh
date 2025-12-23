# run.sh
#!/bin/bash

# Activate Python environment
python3.11 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt || true  # Assuming a requirements.txt file exists

# Run tests
uv run --locked tox run -e py3.11