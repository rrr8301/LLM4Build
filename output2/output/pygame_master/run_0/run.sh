#!/bin/bash

# Activate any necessary environments (none in this case)

# Install project dependencies
python3 setup.py docs
python3 setup.py sdist
python3 -m pip install dist/pygame-*.tar.gz -vv

# Run tests
set +e  # Continue execution even if some tests fail
python3 -m pygame.tests -v --exclude opengl,music,timing --time_out 300
set -e  # Re-enable exit on error