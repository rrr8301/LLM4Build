#!/bin/bash

# Activate the virtual environment
source /app/venv/bin/activate

# Install project dependencies if requirements.txt exists
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Run tests using pytest
# Ensure that only the tests relevant to the application are run
set +e  # Do not exit immediately on error
pytest --maxfail=0 --ignore=Lib/idlelib --ignore=Lib/test --ignore=Lib/test/test_winapi.py --ignore=Lib/test/test_winconsoleio.py --ignore=Lib/test/test_winreg.py --ignore=Lib/test/test_winsound.py --ignore=Lib/test/test_wmi.py