# run.sh
#!/bin/bash

# Activate Python environment
source /root/.uv/venv/bin/activate

# Install project dependencies
uv sync

# Run tests with cargo nextest
cargo nextest run \
  --features python-patch \
  --workspace \
  --status-level skip --failure-output immediate-final --no-fail-fast -j 20 --final-status-level slow