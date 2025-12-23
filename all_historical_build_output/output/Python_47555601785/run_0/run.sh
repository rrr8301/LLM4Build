#!/bin/bash

# Activate Python environment (if any)
# Assuming system Python is used, no virtualenv activation needed

# Sync dependencies with UV
uv sync --group=test

# Run tests with pytest, ensuring all tests are executed
set +e  # Do not exit immediately on error
uv run pytest \
  --ignore=computer_vision/cnn_classification.py \
  --ignore=docs/conf.py \
  --ignore=dynamic_programming/k_means_clustering_tensorflow.py \
  --ignore=machine_learning/lstm/lstm_prediction.py \
  --ignore=neural_network/input_data.py \
  --ignore=project_euler/ \
  --ignore=quantum/q_fourier_transform.py \
  --ignore=scripts/validate_solutions.py \
  --ignore=web_programming/current_stock_price.py \
  --ignore=web_programming/fetch_anime_and_play.py \
  --cov-report=term-missing:skip-covered \
  --cov=. .
set -e  # Re-enable exit on error

# If tests are successful, build the directory markdown
if [ $? -eq 0 ]; then
  python3 scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
fi