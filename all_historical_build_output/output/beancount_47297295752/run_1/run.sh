#!/bin/bash

# run.sh

# Activate the virtual environment
source venv/bin/activate

# Install the project with specific build options
pip install -v --no-build-isolation -Cbuild-dir=build -Csetup-args=-Dtests=enabled -e .

# Run pytest, ensuring all tests are executed
pytest beancount || true

# Run meson tests
meson test -C build/ || true