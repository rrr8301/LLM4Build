#!/bin/bash

# run.sh

# Activate Python virtual environment
python3.12 -m venv venv
source venv/bin/activate

# Install project dependencies
pip install -r requirements.txt

# Run tests
set +e  # Continue execution even if some tests fail
./ci/tests/Framework.bash
./ci/tests/Ref.bash
./ci/tests/30-ints.bash

# Run FppTest
cd ./FppTestProject/FppTest
fprime-util generate --ut
fprime-util build --ut
fprime-util check
cd -

# Note: Log archiving is not implemented in this script