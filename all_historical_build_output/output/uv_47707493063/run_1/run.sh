# run.sh
#!/bin/bash

# Activate Python environment
source /root/.pyenv/versions/3.12.0/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests with cargo nextest
cargo nextest run \
  --features python-patch \
  --workspace \
  --status-level skip --failure-output immediate-final --no-fail-fast -j 20 --final-status-level slow