#!/bin/bash

# Run tests with pytest
# Continue running all tests even if some fail
set +e
uv run --with=pytest-run-parallel pytest \
    --iterations=8 --parallel-threads=auto \
    --ignore=computer_vision/cnn_classification.py \
    --ignore=docs/conf.py \
    --ignore=dynamic_programming/k_means_clustering_tensorflow.py \
    --ignore=machine_learning/local_weighted_learning/local_weighted_learning.py \
    --ignore=machine_learning/lstm/lstm_prediction.py \
    --ignore=neural_network/input_data.py \
    --ignore=project_euler/ \
    --ignore=quantum/q_fourier_transform.py \
    --ignore=scripts/validate_solutions.py \
    --ignore=web_programming/current_stock_price.py \
    --ignore=web_programming/fetch_anime_and_play.py \
    --cov-report=term-missing:skip-covered \
    --cov=. \
    --continue-on-collection-errors \
    --durations=10 \
    --junitxml=test-results.xml \
    --reruns 3

# Generate DIRECTORY.md if tests were at least partially successful
if [ $? -le 1 ]; then
    scripts/build_directory_md.py 2>&1 | tee DIRECTORY.md
fi