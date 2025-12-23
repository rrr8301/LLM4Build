# run.sh
#!/bin/bash

# Activate Python environment
export PYENV_ROOT="/root/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# Install project dependencies
pip install -r requirements.txt

# Run tests with cargo nextest
cargo nextest run \
  --features python-patch \
  --workspace \
  --status-level skip --failure-output immediate-final --no-fail-fast -j 20 --final-status-level slow