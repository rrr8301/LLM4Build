#!/bin/bash

# Activate environment (if any specific activation is needed, otherwise skip)
# source /path/to/venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
set +e  # Continue on errors
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
  --cov=.

# If tests are successful, build directory markdown
if [ $? -eq 0 ]; then
  python3 scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
fi