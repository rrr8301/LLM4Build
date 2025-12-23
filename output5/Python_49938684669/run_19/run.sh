#!/bin/bash

# run.sh

# Exit immediately if a command exits with a non-zero status
set -e

# Activate Python environment
python3.13 -m venv venv
source venv/bin/activate

# Upgrade pip in the virtual environment
pip install --upgrade pip

# Install distutils in the virtual environment
pip install setuptools

# Ensure UV is installed and available in the virtual environment
pip install uv

# Check if UV is installed
if ! command -v uv &> /dev/null; then
    echo "UV could not be found, attempting to install again."
    pip install uv
fi

# Sync dependencies
uv sync --group=test

# Run tests, ensuring all tests are executed even if some fail
set +e
uv run pytest \
  --ignore=computer_vision/cnn_classification.py \
  --ignore=docs/conf.py \
  --ignore=dynamic_programming/k_means_clustering_tensorflow.py \
  --ignore=machine_learning/lstm/lstm_prediction.py \
  --ignore=neural_network/input_data.py \
  --ignore=project_euler/ \
  --ignore=quantum/q_fourier_transform.py \
  --ignore=scripts/validate_solutions.py \
  --ignore=web_programming/fetch_anime_and_play.py \
  --cov-report=term-missing:skip-covered \
  --cov=. .
TEST_EXIT_CODE=$?

# If tests are successful, build the directory markdown
if [ $TEST_EXIT_CODE -eq 0 ]; then
  python3.13 scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
fi

# Exit with the test exit code
exit $TEST_EXIT_CODE