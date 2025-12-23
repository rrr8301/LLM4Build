# run.sh
#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Setup tox environment
tox run -e py --notest

# Run tests
set +e  # Continue execution even if some tests fail
tox run -e py --skip-pkg-install -- -n 4