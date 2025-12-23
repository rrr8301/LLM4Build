#!/bin/bash

# Activate the virtual environment
source venv/bin/activate

# Ensure tox is installed in the virtual environment
pip install --upgrade tox

# Check if tox is correctly configured
tox --version

# Run tests with tox, ensuring all tests are executed
set +e  # Do not exit immediately on failure

# Ensure the tox environment is correctly set up
if [ ! -f tox.ini ]; then
    echo "tox.ini not found, creating a default configuration"
    cat <<EOL > tox.ini
[tox]
envlist = py311

[testenv]
deps = pytest
commands = pytest
EOL
fi

tox --skip-missing-interpreters
EXIT_CODE=$?

# Exit with the test command's exit code
exit $EXIT_CODE